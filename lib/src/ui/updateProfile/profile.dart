import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../services/utilities/app_url.dart';
import '../../services/utilities/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var box = Hive.box('userBox');

  //image picker
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

  Future<void> updateProfile(String name, String phone, String email,
      String address, String id) async {
    // var stream = http.ByteStream(image!.openRead());
    // stream.cast();
    // var length = await image!.length();
    // var uri = Uri.parse(AppUrl.uploadImage);
    //
    // print(uri);
    // var request = http.MultipartRequest('POST', uri);
    //
    // var multipart = http.MultipartFile('picture', stream, length);
    // request.fields['id'] = id;
    // request.files.add(multipart);
    // var response = await request.send();
    // // response.stream.transform(utf8.decoder).listen((value) {
    // //   print(value);
    // //
    // // });
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //
    //   setState(() {
    //     showSpinner = false;
    //   });
    //
    //   print('thanh cong');
    // } else {
    //
    //
    //   // print(data);
    //   print('false');
    // }
    try {
      http.Response response = await http.post(Uri.parse(AppUrl.updateProfile),
          body: {
            'name': name,
            'phone': phone,
            'email': email,
            'address': address,
            'id': id
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        box.put("name", data['name']);
        box.put("phone", data['phone']);
        box.put("address", data['address']);
        box.put("email", data['email']);
        box.put("id", data['id']);
        box.put("picture", data['picture']);
        _showDialog("Cập nhật thành công!");
      } else {
        _showDialog("Cập nhật thất bại!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _showDialog(String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Thông báo"),
            content: Text(content),
            actions: <Widget>[
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"))
            ],
          );
        });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = box.get("name");
    emailController.text = box.get("email");
    phoneController.text = box.get("phone");
    addressController.text = box.get("address");
    // _image=box.get("image");
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff1F1D48),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(5),
                child: Container(
                  color: Colors.grey[200],
                  height: 1.0,
                ),
              ),
              brightness: Brightness.light,
              titleSpacing: 10,
              automaticallyImplyLeading: true,
            ),
            bottomNavigationBar: Material(
              color: const Color(0xff1F1D48),
              child: InkWell(
                onTap: () {
                  updateProfile(
                      nameController.text.toString(),
                      phoneController.text.toString(),
                      emailController.text.toString(),
                      addressController.text.toString(),
                      box.get("id").toString());
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Cập nhật thông tin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: profile()),
      ),
    );
  }

  Widget profile() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: ListView(
        children: [
          avatar(),
          inputInfo(nameController, "Họ và tên", "name"),
          inputInfo(emailController, "Email", "email"),
          inputInfo(phoneController, "Số điện thoại", "phone"),
          inputInfo(addressController, "Địa chỉ", "address"),
        ],
      ),
    );
  }

  Widget avatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                // Image border
                child: SizedBox.fromSize(
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/avatar.jpg")),
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
    );
  }

  Widget inputInfo(TextEditingController textEditingController, String title,
      String getBox) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 3),
                  labelText: title,
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  textEditingController.text = box.get(getBox).toString();
                });
              },
              child: const Icon(
                Icons.edit,
                size: 10,
              ),
            )
          ],
        ));
  }
}
