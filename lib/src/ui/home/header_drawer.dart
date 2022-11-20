import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

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
  @override
  var box= Hive.box('userBox');
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xff1F1D48),
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
                const SizedBox(
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avatar.jpg"),
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: -1,
                    child: SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(10))),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.photo_camera,
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