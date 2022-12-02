import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/src/ui/updateProfile/profile.dart';

import '../../services/utilities/app_url.dart';
import '../../services/utilities/colors.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  File? image;

  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      return;
    }
  }

  var box = Hive.box('userBox');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PRIMARY_COLOR,
      ),
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Stack(
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: (box.get("picture").toString() != "")
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              AppUrl.url + box.get("picture").toString()),
                        )
                      : const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/avatar.jpg"),
                        ),
                ),
                Positioned(
                    right: -3,
                    bottom: -4,
                    child: SizedBox(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10))),
                        child: const Padding(
                          padding: EdgeInsets.all(0),
                          child: Icon(
                            Icons.edit_note_outlined,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                      ),
                    )))
              ],
            ),
          ),
          Text(
            box.get("name"),
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            box.get("email"),
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
