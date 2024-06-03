import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/page/boarding/boarding.dart';
import 'package:seyehatapp/page/anasayafa/anasayfa.dart';
import 'package:seyehatapp/page/giris.dart';
import 'package:seyehatapp/page/not/not_olustur.dart';
import 'package:seyehatapp/page/not/nt_giris.dart';
import 'package:seyehatapp/page/profil/profil_view.dart';
import 'package:seyehatapp/page/splash/splash.dart';

enum AppRouterName {
  girisEkrani('/home', 'Home'),
  bordBar('/bord', 'Bord'),
  notGiris('/notgiris', 'NotGiris'),
  notOlustur('/otolustur', 'NotOlustur'),
  setting('/setting', 'Setting'),
  splash('/splash', 'splash'),

  anasayfa('/page2', 'Deneme');

  const AppRouterName(this.path, this.name);

  final String path;
  final String name;
}

class AppRouters {
  AppRouters._();
  static AppRouters? _instance;
  static AppRouters get instance => _instance ?? AppRouters._();

// GoRouter configuration
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const GirisEkrani(),
      ),
      GoRoute(
        path: '/page2',
        builder: (context, state) => const AnaSayfa(),
      ),
      GoRoute(
        path: '/bord',
        builder: (context, state) => const BoardingScreen(),
      ),
      GoRoute(
        path: '/notgiris',
        builder: (context, state) => const NotGirisScreen(),
      ),
      GoRoute(
        path: '/otolustur',
        builder: (context, state) => const NotOlusturScreen(),
      ),
      GoRoute(
        path: '/setting',
        builder: (context, state) => const ProfilView(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          final nextPage = state.extra as Widget?;
          return SplashScreen(nextPage: nextPage!);
        },
      ),
    ],
  );
}
