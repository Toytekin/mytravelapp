import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:seyehatapp/page/boarding/state2.dart';
import 'package:seyehatapp/page/boarding/state3.dart';
import 'package:seyehatapp/page/boarding/statte1.dart';
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
            const State1(),
            const State2(),
            const State3(),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                final currentContext =
                    context; // context'i bir yerel değişkende saklayın.
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('showHome', true);

                // ignore: use_build_context_synchronously
                GoRouter.of(currentContext).go(
                    AppRouterName.anasayfa.path); // Yerel değişkeni kullanın.
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(80)),
              child: Text(
                LocaleKeys.bording_st1b.tr(),
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
