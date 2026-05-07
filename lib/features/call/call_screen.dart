import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/app/user_service.dart';
import 'package:hack1/features/materials.dart';

class CallPage extends ConsumerStatefulWidget {
  final String postId;

  const CallPage({super.key, required this.postId});

  @override
  ConsumerState<CallPage> createState() => _CallPageState();
}

class _CallPageState extends ConsumerState<CallPage> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isRemoteVideoOff = false;
  late final RtcEngine _engine;
  int? _remoteUid;

  String? partnerId;
  String? channelName;

  bool _partnerJoined = false;
  DateTime? _startedAt;

  @override
  void initState() {
    super.initState();

    _loadCallInfo();
  }

  // 会話スタート時の変数保存
  Future<void> _loadCallInfo() async {
    final postDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .get();

    final data = postDoc.data();
    if (data == null) return;

    partnerId = data['userId'];
    channelName = 'call_${widget.postId}';

    await initAgora();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> initAgora() async {
    _engine = createAgoraRtcEngine();

    await _engine.initialize(
      RtcEngineContext(appId: "93744bcaec484d509dfb174f35a6916a"),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          print(
            "自分が入室成功: ${connection.channelId}, uid: ${connection.localUid}",
          );
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          print("相手が入室: $remoteUid");
          setState(() {
            _remoteUid = remoteUid;
            _partnerJoined = true; //相手が入ってきたか
            _startedAt = DateTime.now(); //相手が入ってきた時間をスタート時間にする
          });
        },
        onUserOffline: (connection, remoteUid, reason) {
          print("相手が退出: $remoteUid");
          setState(() {
            _remoteUid = null;
          });
        },
        onError: (err, msg) {
          print("Agoraエラー: $err, $msg");
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          print("相手のビデオ状態: $muted");

          setState(() {
            _isRemoteVideoOff = muted;
          });
        },
      ),
    );

    await _engine.enableAudio();
    await _engine.muteLocalAudioStream(false);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: '',
      channelId: channelName!,
      uid: 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        publishCameraTrack: true,
        autoSubscribeVideo: true,
      ),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(title: const Text('通話中')),
      body: Stack(
        children: [
          // 背景・相手の映像
          Positioned.fill(
            child: _remoteUid == null
                ? const Center(child: Text('相手を待っています...'))
                : _isRemoteVideoOff
                ? Container(
                    color: const Color(0xFFF3EEE9),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            child: Icon(Icons.person, size: 70),
                          ),
                          SizedBox(height: 16),
                          Text('相手のビデオがオフです'),
                        ],
                      ),
                    ),
                  )
                : AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine,
                      canvas: VideoCanvas(uid: _remoteUid),
                      connection: RtcConnection(channelId: channelName),
                    ),
                  ),
          ),

          // 自分の小窓
          Positioned(
            top: 20,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 130,
                height: 180,
                color: Colors.white,
                child: _isVideoOff
                    ? const Center(child: Icon(Icons.person, size: 50))
                    : AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
              ),
            ),
          ),

          // 下の操作ボタン
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    color: const Color(0xFFBF5557),
                    onTap: _toggleMic,
                  ),
                  const SizedBox(width: 16),
                  _buildButton(
                    icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                    color: const Color(0xFFBF5557),
                    onTap: _toggleVideo,
                  ),
                  const SizedBox(width: 16),
                  _buildButton(
                    icon: Icons.call_end,
                    color: Colors.red,
                    onTap: _leaveCall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // マイクのオンオフ切り替え
  Future<void> _toggleMic() async {
    setState(() {
      _isMuted = !_isMuted;
    });

    await _engine.muteLocalAudioStream(_isMuted);
  }

  // カメラのオンオフ切り替え
  Future<void> _toggleVideo() async {
    setState(() {
      _isVideoOff = !_isVideoOff;
    });

    await _engine.muteLocalVideoStream(_isVideoOff);
  }

  // 通話終了
  Future<void> _leaveCall() async {
    await _engine.leaveChannel();
    final userId = await UserService.getUserId();

    if (_partnerJoined) {
      // 通話終了時に相手が入ったのならば、firestore callsにデータ保存
      await FirebaseFirestore.instance
          .collection('calls')
          .doc(widget.postId)
          .set({
            'postId': widget.postId,
            'channelName': channelName,
            'participantIds': [userId, partnerId],
            'status': 'ended',
            'startedAt': Timestamp.fromDate(_startedAt!),
            'endedAt': Timestamp.now(),
          });
    }

    if (!mounted) return;
    context.go('/after-call/${widget.postId}');
  }
}

// 通話コントロールボタンのウィジェット
Widget _buildButton({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8)],
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );
}
