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

  void signup(String name, phone, password) async {
    try {
      Response response = await post(
          Uri.parse('https://meowmeowpetshop.xyz/api/v1/create-customer'),
          body: {'name': name,'phone': phone, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('successful');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:  AppBar(
    backgroundColor: Colors.grey,
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
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            width: 300,
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Tên người dùng',
                  prefixIcon: Icon(Icons.account_circle_outlined)),
            ),
          ),
          Container(
            width: 300,
            child: TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  prefixIcon: Icon(Icons.phone)),
            ),
          ),
          Container(
            width: 300,
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Mật khẩu', prefixIcon: Icon(Icons.password)),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          _signup(),
        ],
      ),
    ));
  }
  Widget _signup(){
    return  GestureDetector(
      onTap: () {
        signup(
            nameController.text.toString(),
            phoneController.text.toString(),
            passwordController.text.toString());

        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
      },
      child: Container(
        alignment: Alignment.center,
        child: Text('Đăng Ký'),
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
