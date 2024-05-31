import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (value) {
            setState(() => isLastPage = value == 2);
          },
          controller: controller,
          children: [
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.yellow,
            ),
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                GoRouter.of(context).go(AppRouterName.anasayfa.path);
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(80)),
              child: const Text(
                'Başla',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text('Skip')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                        dotHeight: 16,
                        dotWidth: 16,
                        type: WormType.thinUnderground,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => controller.nextPage(
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500)),
                      child: const Text('Next')),
                ],
              ),
            ),
    );
  }
}
