import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      asset: 'assets/images/image 70.png',
      title: 'ひつじのしおりへようこそ！',
      description: '思い出を世代を超えて共有しませんか？',
    ),
    _OnboardingPage(
      assets: [
        'assets/images/image 63 (1).png',
        'assets/images/telephone logo (1).png',
        'assets/images/image 71 (1).png',
      ],
      title: 'テレビ通話でいろいろなお話が出来ます',
      description: '',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2EA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (page.asset != null) ...[
                          Image.asset(
                            page.asset!,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.68,
                          ),
                          const SizedBox(height: 32),
                        ] else if (page.assets != null &&
                            page.assets!.isNotEmpty) ...[
                          SizedBox(
                            height: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: page.assets!.asMap().entries.map((
                                entry,
                              ) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1,
                                  ),
                                  child: Image.asset(
                                    entry.value,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ] else
                          const SizedBox(height: 36),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF5B3E3E),
                          ),
                        ),
                        const SizedBox(height: 22),
                        if (page.description.isNotEmpty)
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5B3E3E),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(_pages.length, (index) {
                        final bool active = index == _currentPage;
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: active ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? const Color(0xFF2E2F45)
                                : const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    ),
                    ElevatedButton(
                      onPressed: _handleNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC1C1),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '次へ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String? asset;
  final List<String>? assets;
  final String title;
  final String description;

  const _OnboardingPage({
    this.asset,
    this.assets,
    required this.title,
    required this.description,
  });
}
