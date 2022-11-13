import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
  void signup(String name, phone, password) async {
    try {
      Response response = await post(
          Uri.parse('https://meowmeowpetshop.xyz/api/v1/create-customer'),
          body: {'name': name,'phone': phone, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        _showDialog("Đăng kí tài khoản thành công");

      } else {
        _showDialog("Đăng kí tài khoản thất bại");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:  AppBar(
    backgroundColor: Color(0xff1F1D48),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(5),
      child: Container(
        color: Colors.grey[200],
        height: 1.0,
      ),
    ),
    brightness: Brightness.light,
    titleSpacing: 10,
    automaticallyImplyLeading: true,
    title: Text('Đăng Ký'),
  ),
      body: info()
    );
  }
  Widget info(){
    return SingleChildScrollView(
        child:Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           SizedBox(height: MediaQuery.of(context).size.height*0.1),
         inputInformation(nameController, "Tên người dùng", Icons.account_circle_outlined, false),
         inputInformation(phoneController, "Số điện thoại ", Icons.phone, false),
         inputInformation(passwordController, "Mật Khẩu", Icons.password_outlined, true),
          btnSignUp(),
          btnLSignIn()
        ],
      ),
    ));
  }
  Widget inputInformation(TextEditingController textEditingController,
      String title, IconData icon, bool obs) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
            obscureText: obs,
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: title,
              prefixIcon: Icon(icon),
              enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            )),
      ),
    );
  }
  Widget btnSignUp() {
    return Padding(
      padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          signup(
              nameController.text.toString(),
              phoneController.text.toString(),
              passwordController.text.toString());
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          decoration: BoxDecoration(
              color: const Color(0xff1F1D48), borderRadius: BorderRadius.circular(15)),
          child: const Text(
            'Đăng kí',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
  Widget btnLSignIn() {
    return Padding(
      padding: const EdgeInsets.only(top:20.0,bottom:20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Bạn đã có tài khoản? ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              'Đăng nhập',
              style: TextStyle(
                  color: Color(0xff1F1D48),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
