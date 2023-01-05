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
  bool enableEdit = false;
  bool enableCancel = false;
  bool enableUpdate = false;
  bool editedName = false;
  bool editedEmail = false;
  bool editedPhone = false;
  bool editedAddress = false;
  File? image;

  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {
        enableUpdate = true;
      });
    } else {
      return;
    }
  }

  Future<void> updateProfile(String name, String phone, String email,
      String address, String id) async {
    try {
      setState(() {
        showSpinner = true;
      });
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
        setState(() {
          enableUpdate = false;
          enableEdit = false;
          enableCancel = false;
        });
        setState(() {
          showSpinner = false;
        });
      } else {
        setState(() {
          showSpinner = false;
        });
        _showDialog("Cập nhật thất bại!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updatePicture(String id) async {
    setState(() {
      showSpinner = true;
    });
    var uri = Uri.parse(AppUrl.uploadImage);
    var request = http.MultipartRequest('POST', uri);

    request.fields['id'] = id;
    if (image == null) {
      setState(() {
        showSpinner = false;
      });
    } else {
      request.files.add(http.MultipartFile(
          'picture', image!.readAsBytes().asStream(), image!.lengthSync(),
          filename: image!.path.split('/').last));
      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false;
          enableUpdate = false;
        });
        //Lấy ra đường dẫn sau khi cập nhật
        response.stream.transform(utf8.decoder).listen((value) {
          var data = jsonDecode(value);
          box.put("picture", data['picture']);
        });
      } else {
        setState(() {
          showSpinner = false;
        });
      }
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

  @override
  void initState() {
    super.initState();
    nameController.text = box.get("name");
    emailController.text = box.get("email");
    phoneController.text = box.get("phone");
    addressController.text = box.get("address");

    nameController.addListener(() {
      final edited = (nameController.text != box.get("name"));
      setState(() {
        editedName = edited;
        if ((editedName) ||
            (editedEmail) ||
            (editedPhone) ||
            (editedAddress) ||
            (image != null)) {
          enableUpdate = true;
        } else {
          enableUpdate = false;
        }
      });
    });
    emailController.addListener(() {
      final edited = (emailController.text != box.get("email"));
      setState(() {
        editedEmail = edited;
        if ((editedName) ||
            (editedEmail) ||
            (editedPhone) ||
            (editedAddress) ||
            (image != null)) {
          enableUpdate = true;
        } else {
          enableUpdate = false;
        }
      });
    });

    phoneController.addListener(() {
      final edited = (phoneController.text != box.get("phone"));
      setState(() {
        editedPhone = edited;
        if ((editedName) ||
            (editedEmail) ||
            (editedPhone) ||
            (editedAddress) ||
            (image != null)) {
          enableUpdate = true;
        } else {
          enableUpdate = false;
        }
      });
    });

    addressController.addListener(() {
      final edited = (addressController.text != box.get("address"));
      setState(() {
        editedAddress = edited;
        if ((editedName) ||
            (editedEmail) ||
            (editedPhone) ||
            (editedAddress) ||
            (image != null)) {
          enableUpdate = true;
        } else {
          enableUpdate = false;
        }
      });
    });
    // listener(nameController, "name", editedName);
    // listener(emailController, "email",editedEmail);
    // listener(phoneController, "phone",editedPhone);
    // listener(addressController, "address",editedAddress);
  }

  // void listener(TextEditingController textEditingController, String title, bool editedTitle) {
  //   textEditingController.addListener(() {
  //     final edited = (textEditingController.text != box.get(title));
  //     setState(() {
  //       editedTitle = edited;
  //       if ((editedName) ||
  //           (editedEmail) ||
  //           (editedPhone) ||
  //           (editedAddress) ||
  //           (image != null)) {
  //         enableUpdate = true;
  //       } else {
  //         enableUpdate = false;
  //       }
  //     });
  //   });
  // }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: PRIMARY_COLOR,
              brightness: Brightness.light,
              automaticallyImplyLeading: true,
              title: const Text("Thông tin cá nhân "),
            ),
            bottomNavigationBar: Material(
              color: const Color(0xff1F1D48),
              child: InkWell(
                onTap: (enableUpdate)
                    ? () {
                        (image != null)
                            ? updatePicture(box.get("id").toString())
                            : null;
                        (editedName ||
                                editedEmail ||
                                editedPhone ||
                                editedAddress)
                            ? updateProfile(
                                nameController.text.toString(),
                                phoneController.text.toString(),
                                emailController.text.toString(),
                                addressController.text.toString(),
                                box.get("id").toString())
                            : null;
                      }
                    : null,
                child: SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Cập nhật thông tin",
                      style: TextStyle(
                        color: enableUpdate ? Colors.white : Colors.grey,
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
    return Container(
      decoration: const BoxDecoration(
        color: PRIMARY_COLOR,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.8, 1),
          colors: <Color>[
            PRIMARY_COLOR,
            Color(0xff472db7),
            Color(0xff8757da),
          ],
          // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      child: ListView(
        children: [avatar(), detailInfo()],
      ),
    );
  }

  Widget avatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.35,
              width: MediaQuery.of(context).size.width * 0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                // Image border
                child: SizedBox.fromSize(
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : (box.get("picture").toString() != null)
                            ? Image.network(
                                AppUrl.url + box.get("picture").toString(),
                                fit: BoxFit.cover,
                              )
                            : Image.asset("assets/images/avatar.jpg")),
              ),
            ),
            Positioned(
                right: 5,
                bottom: 5,
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
                      padding: EdgeInsets.only(top: 2.0, left: 2, right: 2),
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

  Widget detailInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            inputInfo(nameController, "Họ và tên:", "name"),
            inputInfo(emailController, "Email:", "email"),
            inputInfo(phoneController, "Số điện thoại:", "phone"),
            inputInfo(addressController, "Địa chỉ:", "address"),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                cancelInfo(),
                const Expanded(child: SizedBox()),
                editInfo(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget editInfo() {
    return GestureDetector(
      onTap: () {
        setState(() {
          enableEdit = true;
          enableCancel = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Center(
            child: Text("Chỉnh sửa",
                style: TextStyle(
                  color: (enableEdit) ? Colors.blue : Colors.grey,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ))),
      ),
    );
  }

  Widget cancelInfo() {
    return GestureDetector(
      onTap: () {
        setState(() {
          enableCancel = false;
          enableEdit = false;
          nameController.text = box.get("name");
          emailController.text = box.get("email");
          phoneController.text = box.get("phone");
          addressController.text = box.get("address");
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Center(
            child: Text(
          "Đặt lại",
          style: TextStyle(
            color: enableCancel ? Colors.black : Colors.grey,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        )),
      ),
    );
  }

  Widget inputInfo(TextEditingController textEditingController, String title,
      String getBox) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                enabled: enableEdit,
                style: const TextStyle(fontSize: 19),
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 3),
                  labelText: title,
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            Icon(
              Icons.edit,
              size: 20,
              color: enableEdit ? Colors.blue : Colors.grey,
            )
          ],
        ));
  }
}
