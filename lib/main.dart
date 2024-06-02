import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/constant/theme/theme.dart';
import 'package:seyehatapp/services/cubit/boarding.dart';
import 'package:seyehatapp/services/cubit/notlar_cubit.dart';
import 'package:seyehatapp/services/cubit/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:seyehatapp/services/model/not_model.dart';
import 'package:seyehatapp/services/model/profilmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NotModelAdapter());
  await Hive.openBox<NotModel>('nots');

  //
  Hive.registerAdapter(ProfilModelAdapter());
  await Hive.openBox<ProfilModel>('prf');

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
        path: 'asset/lang', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => BoardingCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => NotlarCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: state ? TravelTheme.lightTheme : TravelTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            routerConfig: AppRouters.instance.router,
          );
        },
      ),
    );
  }
}
