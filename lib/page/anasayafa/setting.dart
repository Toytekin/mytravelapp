import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seyehatapp/services/cubit/theme_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Icon(
                  Icons.settings,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  size: constraints.maxWidth / 3,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.dark_mode),
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
                const Icon(Icons.light_mode),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Deneme'))
          ],
        ),
      ),
    );
  }
}
