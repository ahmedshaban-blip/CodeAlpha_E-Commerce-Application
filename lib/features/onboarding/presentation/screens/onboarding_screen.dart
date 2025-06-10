// import 'package:e_commerce/core/routing/routes.dart';
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

// class OnboardingScreen extends StatefulWidget {
//  const OnboardingScreen({super.key});

//  @override
//  State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//  final controller = PageController();
//  bool isLastPage = false;

//  @override
//  void dispose() {
//    controller.dispose();
//    super.dispose();
//  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//      body: Padding(
//        padding: EdgeInsets.symmetric(horizontal: 24),
//        child: Column(
//          children: [
//            SizedBox(height: 60),
//            Expanded(
//              child: PageView(
//                controller: controller,
//                onPageChanged: (index) => setState(() => isLastPage = index == 2),
//                children: const [
//                  OnboardPage(title: 'Welcome', description: 'This is onboarding 1'),
//                  OnboardPage(title: 'Explore', description: 'This is onboarding 2'),
//                  OnboardPage(title: 'Start', description: 'This is onboarding 3'),
//                ],
//              ),
//            ),

//            SizedBox(height: 20),
//            SizedBox(
//              width: double.infinity,
//              child: ElevatedButton(
//                onPressed: () {
//                  Navigator.pushNamed(context, Routes.loginScreen);
//                },
//                child: Text(isLastPage ? 'Get Started' : 'Next'),
//              ),
//            ),
//            SizedBox(height: 40),
//          ],
//        ),
//      ),
//    );
//  }
// }

// class OnboardPage extends StatelessWidget {
//  final String title;
//  final String description;
//  const OnboardPage({super.key, required this.title, required this.description});

//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.symmetric(horizontal: 24),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          Icon(Icons.flutter_dash, size: 120),
//          SizedBox(height: 20),
//          Text(
//            title,
//            style: GoogleFonts.nunito(
//              fontSize: 26,
//              fontWeight: FontWeight.bold,
//            ),
//          ),
//          SizedBox(height: 12),
//          Text(
//            description,
//            textAlign: TextAlign.center,
//            style: GoogleFonts.nunito(fontSize: 16),
//          ),
//        ],
//      ),
//    );
//  }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnBoardingData> _pages = [
    OnBoardingData(
      image: Icons.shopping_cart,
      title: 'تسوق بسهولة',
      description: 'اكتشف آلاف المنتجات بأفضل الأسعار',
    ),
    OnBoardingData(
      image: Icons.local_shipping,
      title: 'توصيل سريع',
      description: 'احصل على طلباتك في أسرع وقت ممكن',
    ),
    OnBoardingData(
      image: Icons.payment,
      title: 'دفع آمن',
      description: 'طرق دفع متعددة وآمنة 100%',
    ),
  ];

  Future<void> _completeOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/AuthWrapper');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // زر التخطي
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 60), // لتوسيط العنوان
                  const Text(
                    'مرحباً بك',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _completeOnBoarding,
                    child: const Text('تخطي'),
                  ),
                ],
              ),
            ),

            // محتوى الصفحات
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // الأيقونة
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            _pages[index].image,
                            size: 100,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 50),

                        // العنوان
                        Text(
                          _pages[index].title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // الوصف
                        Text(
                          _pages[index].description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // مؤشرات الصفحات والأزرار
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // مؤشرات الصفحات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.blue
                              : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // زر التالي/البدء
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          _completeOnBoarding();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'ابدأ الآن'
                            : 'التالي',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingData {
  final IconData image;
  final String title;
  final String description;

  OnBoardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
