import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/constant/theme/theme.dart';
import 'package:seyehatapp/services/cubit/boarding.dart';
import 'package:seyehatapp/services/cubit/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => BoardingCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp.router(
              theme: state ? TravelTheme.lightTheme : TravelTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              routerConfig: AppRouters.instance.router);
        },
      ),
    );
  }
}
