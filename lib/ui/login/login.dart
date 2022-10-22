import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:project1/ui/login/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  void login(String phone, password) async {
    try {
      Response response = await post(Uri.parse('https://meowmeowpetshop.xyz/api/v1/login-customer'),
          body: {'phone': phone, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['data']['name']);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'Google',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('Hoặc bằng tài khoản'),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: phoneNumberControler,
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
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Text('Quên mật khẩu?'),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  login(phoneNumberControler.text.toString(),
                      passwordControler.text.toString());
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Đăng Nhập'),
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
              GestureDetector(
                onTap: (){
                  // get(SignUpPage);

                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignUpPage()));

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
