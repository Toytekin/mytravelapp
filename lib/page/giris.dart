import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:seyehatapp/services/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  bool onboarding = false;

  @override
  void initState() {
    super.initState();
    durumaBak();
  }

  Future<void> durumaBak() async {
    final pref = await SharedPreferences.getInstance();
    bool deger = pref.getBool('showHome') ?? false;

    setState(() {
      onboarding = deger;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (BuildContext context, bool state) {
              return Switch(
                value: state,
                onChanged: (value) {
                  context.read<ThemeCubit>().temaDegistir();
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              LocaleKeys.giris_title.tr(),
              style: TextStyle(
                color: Theme.of(context).appBarTheme.backgroundColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      context.setLocale(const Locale("en", "US"));
                    },
                    icon: Icon(
                      Icons.ads_click,
                      size: 57,
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    )),
                IconButton(
                    onPressed: () {
                      if (onboarding == false) {
                        context.go(AppRouterName.bordBar.path);
                      } else {
                        context.go(AppRouterName.anasayfa.path);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_circle_right_sharp,
                      size: 57,
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
