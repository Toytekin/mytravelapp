import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seyehatapp/constant/router/router.dart';
import 'package:seyehatapp/generated/locale_keys.g.dart';
import 'package:seyehatapp/services/model/profilmodel.dart';
import 'package:seyehatapp/services/profil_services.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  var repo = ProfilServices();
  ProfilModel? profilModel;
  double score = 2;

  ImagePicker imagePicker = ImagePicker();
  File? secilenImage;

  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    veriGetir();
  }

  Future<void> veriGetir() async {
    var data = await repo.getProfil();

    if (data != null) {
      setState(() {
        profilModel = data;
        nameController.text = data.name.toString();
        secilenImage = File(data.photoURL.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            yaziname(),
            ElevatedButton(
              onPressed: () {
                if (secilenImage != null && nameController.text.isNotEmpty) {
                  var profilModel = ProfilModel(
                    name: nameController.text.toString(),
                    photoURL: secilenImage?.path.toString(),
                  );
                  repo.save(profilModel);
                  context.go(AppRouterName.anasayfa.path);
                }
              },
              child: Text(
                LocaleKeys.not_kaydet.tr(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding yaziname() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 25,
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
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
}
