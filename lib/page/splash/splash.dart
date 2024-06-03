import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextPage;

  const SplashScreen({super.key, required this.nextPage});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.nextPage),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              LocaleKeys.giris_title.tr(),
              style: GoogleFonts.seymourOne(
                textStyle: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  letterSpacing: .3,
                  fontSize: 28,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Image.asset(
                  'asset/image/logo.png',
                  height: constraints.maxWidth / 1.5,
                  width: constraints.maxWidth / 1.5,
                );
              },
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
