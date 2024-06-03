import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:seyehatapp/services/cubit/notlar_cubit.dart';
import 'package:seyehatapp/services/model/not_model.dart';

class NotGirisScreen extends StatefulWidget {
  const NotGirisScreen({super.key});

  @override
  State<NotGirisScreen> createState() => _NotGirisScreenState();
}

class _NotGirisScreenState extends State<NotGirisScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotlarCubit>().notlariCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarTM(context),
      body: Center(child: Center(
        child: BlocBuilder<NotlarCubit, List<NotModel>>(
          builder: (context, state) {
            if (state == []) {
              return Center(
                child: Icon(Icons.hourglass_empty),
              );
            } else {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  var item = state[index];

                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: item.imgURL != null // Resim yolu varsa
                          ? DecorationImage(
                              image: FileImage(File(item.imgURL.toString())),
                              fit: BoxFit.cover,
                              opacity: 0.3)
                          : null, // Resim yoksa arka planı null olarak bırakın
                    ),
                    child: Column(
                      children: [
                        aniTitleYazi(item, context),
                        const SizedBox(height: 20),
                        Text(
                          item.ani,
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text(LocaleKeys.not_dylogbaslik.tr()),
                                      content:
                                          Text(LocaleKeys.not_dylogyazi.tr()),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            // Sil butonuna tıklandığında yapılacak işlemler
                                            Navigator.of(context).pop();
                                            // Silme işlemi gerçekleştirilebilir
                                            await context
                                                .read<NotlarCubit>()
                                                .sil(item.notID);
                                            context.go(
                                                AppRouterName.anasayfa.path);
                                          },
                                          child: Text(LocaleKeys.not_sil.tr()),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Vazgeç butonuna tıklandığında yapılacak işlemler
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              Text(LocaleKeys.not_vazgec.tr()),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                              ),
                            ),
                            RatingBar.builder(
                              onRatingUpdate: (_) {}, // Boş fonksiyon
                              initialRating: item.score,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(Icons.favorite,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        onPressed: () {
          context.go(AppRouterName.notOlustur.path);
        },
      ),
    );
  }

  AppBar appbarTM(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
          onPressed: () {
            context.go(AppRouterName.anasayfa.path);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.backgroundColor,
          )),
    );
  }

  Padding aniTitleYazi(NotModel item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            item.notTitle,
            style: GoogleFonts.seymourOne(
              textStyle: TextStyle(
                color: Theme.of(context).appBarTheme.backgroundColor,
                letterSpacing: .3,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
