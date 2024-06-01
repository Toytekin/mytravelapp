import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';

class State1 extends StatelessWidget {
  const State1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('asset/image/tr1.png'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.bording_st1.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
