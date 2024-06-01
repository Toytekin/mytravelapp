import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/constant/router/router.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                context.go(AppRouterName.setting.path);
              },
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).appBarTheme.backgroundColor,
                size: 28,
              ))
        ],
      ),
      body: const Center(
        child: Text('AnaSayfa Sayfası'),
      ),
    );
  }
}
