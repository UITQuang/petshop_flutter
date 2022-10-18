import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:project1/ui/login/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController nameControler = TextEditingController();

  void signup(String name, phone, password) async {
    try {
      Response response = await post(
          Uri.parse('https://meowmeowpetshop.xyz/api/v1/create-customer'),
          body: {'name': name,'phone': phone, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('successfullt');
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameControler,
                  decoration: InputDecoration(
                      labelText: 'Tên người dùng',
                      prefixIcon: Icon(Icons.account_circle_outlined)),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: phoneControler,
                  decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: Icon(Icons.phone)),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passwordControler,
                  decoration: InputDecoration(
                      labelText: 'Mật khẩu', prefixIcon: Icon(Icons.password)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  signup(
                      nameControler.text.toString(),
                      phoneControler.text.toString(),
                      passwordControler.text.toString());
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
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
