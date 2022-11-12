import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:project1/src/services/utilities/app_url.dart';

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

  @override
  var box = Hive.box('userBox');

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
  }

  void updateProfile(String name, String phone, String email, String address,
      String id) async {
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
        _showDialog("Cập nhật thành công!");
      } else {
        _showDialog("Cập nhật thất bại!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: profile());
  }

  Widget profile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: Stack(
                children: [
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: -1,
                      child: SizedBox(
                          child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ),
                      )))
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Họ và tên",
                        labelStyle: TextStyle(
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
                        nameController.text = box.get("name").toString();
                      });
                    },
                    child: Icon(
                      Icons.edit,
                      size: 10,
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Email",
                        labelStyle: TextStyle(
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
                        emailController.text = box.get("email").toString();
                      });
                    },
                    child: Icon(
                      Icons.edit,
                      size: 10,
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Số điện thoại",
                        labelStyle: TextStyle(
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
                        phoneController.text = box.get("phone").toString();
                      });
                    },
                    child: Icon(
                      Icons.edit,
                      size: 10,
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Địa chỉ",
                        labelStyle: TextStyle(
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
                        addressController.text = box.get("address").toString();
                      });
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 10,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
