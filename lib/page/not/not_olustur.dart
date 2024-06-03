import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seyehatapp/services/cubit/notlar_cubit.dart';
import 'package:seyehatapp/services/model/not_model.dart';
import 'package:uuid/uuid.dart';

class NotOlusturScreen extends StatefulWidget {
  const NotOlusturScreen({super.key});

  @override
  State<NotOlusturScreen> createState() => _NotOlusturScreenState();
}

class _NotOlusturScreenState extends State<NotOlusturScreen> {
  TextEditingController titlecntr = TextEditingController();
  TextEditingController anicntr = TextEditingController();

  double score = 2;

  ImagePicker imagePicker = ImagePicker();
  File? secilenImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: geriDon(context),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                raiting(),
                InkWell(
                  onTap: () {
                    picImage();
                  },
                  child: secilenImage == null
                      ? Image.asset(
                          "asset/image/ani.png",
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          secilenImage!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                ),
                titleYazi(title: titlecntr),
                const SizedBox(height: 20),
                aniYazi(notDetay: anicntr),
                ElevatedButton(
                    onPressed: () {
                      if (titlecntr.text.isNotEmpty &&
                          anicntr.text.isNotEmpty) {
                        var aniID = Uuid().v1();

                        if (secilenImage != null) {
                          var ani = NotModel(
                            notID: aniID,
                            notTitle: titlecntr.text.toString(),
                            ani: anicntr.text.toString(),
                            score: score,
                            imgURL: secilenImage!.path,
                          );

                          context.read<NotlarCubit>().kaydet(ani);
                          context.go(AppRouterName.notGiris.path);
                        } else {
                          var ani = NotModel(
                              score: score,
                              notID: aniID,
                              notTitle: titlecntr.text.toString(),
                              ani: anicntr.text.toString());

                          context.read<NotlarCubit>().kaydet(ani);
                          context.go(AppRouterName.notGiris.path);
                        }
                      } else {
                        // Snackbar gösterimi
                        final snackBar = SnackBar(
                          content: Text('Tüm alanların dolu olduğuna emin ol!'),
                          action: SnackBarAction(
                            label: 'Geri Al',
                            onPressed: () {
                              // Geri al butonuna basıldığında yapılacak işlemler
                            },
                          ),
                        );
                        // ScaffoldMessenger kullanarak Snackbar'ı göster
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(LocaleKeys.not_kaydet.tr()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> picImage() async {
    var photo = await imagePicker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      debugPrint("burası çalıştı");
      setState(() {
        secilenImage = File(photo.path);
      });
    }
  }

  RatingBar raiting() {
    return RatingBar.builder(
      initialRating: 2,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(Icons.favorite,
          color: Theme.of(context).appBarTheme.backgroundColor),
      onRatingUpdate: (rating) {
        setState(() {
          score = rating;
        });
      },
    );
  }

  IconButton geriDon(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.go(AppRouterName.notGiris.path);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).appBarTheme.backgroundColor,
        ));
  }
}

class aniYazi extends StatelessWidget {
  const aniYazi({
    super.key,
    required this.notDetay,
  });

  final TextEditingController notDetay;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: notDetay, // Here, use `notDetay` instead of `title`
      maxLines: 8,
      minLines: 7,
      decoration: InputDecoration(
        label: Text(LocaleKeys.not_ani.tr()),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class titleYazi extends StatelessWidget {
  const titleYazi({
    super.key,
    required this.title,
  });

  final TextEditingController title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 26,
      controller: title,
      decoration: InputDecoration(
        label: Text(LocaleKeys.not_baslik.tr()),
        border: OutlineInputBorder(),
      ),
    );
  }
}
