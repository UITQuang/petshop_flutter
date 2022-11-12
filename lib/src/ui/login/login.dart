import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project1/src/ui/home/home.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:project1/src/ui/login/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var box = Hive.box('userBox');

  void login(String phone, password) async {
    try {
      Response response = await post(
          Uri.parse('https://meowmeowpetshop.xyz/api/v1/login-customer'),
          body: {'phone': phone, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Homepage()));
        box.put("name", data['data']['name']);
        box.put("phone", data['data']['phone']);
        box.put("address", data['data']['address']);
        box.put("email", data['data']['email']);
        box.put("id", data['data']['id']);
        print(box.get("name"));
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerView(),
              inputInformation(
                  phoneNumberController, "Số điện thoại", Icons.phone),
              const SizedBox(
                height: 30,
              ),
              inputInformation(
                  passwordController, "Mật khẩu", Icons.password_outlined),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
                child: Row(
                  children: const [
                    Expanded(child: SizedBox()),
                    Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              btnLogin(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0, top: 80.0),
                child: loginByMedia(),
              ),
              btnSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: const [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Welcome Back",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 70.0),
            child: Center(
              child: Text(
                "Sign in with your phone number and password or continue with cocial media",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget btnLogin() {
    return GestureDetector(
      onTap: () {
        login(phoneNumberController.text.toString(),
            passwordController.text.toString());
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          'Đăng Nhập',
          style: TextStyle(
              color: Color(0xff1F1D48),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget btnSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Chưa có tài khoản? ",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: const Text(
            'Đăng Ký',
            style: TextStyle(
                color: Color(0xff1F1D48),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Widget loginByMedia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loginBy(Icons.facebook, "FaceBook", Colors.blue),
        const SizedBox(
          width: 15,
        ),
        loginBy(Icons.email_outlined, "Google", Colors.red)
      ],
    );
  }

  Widget loginBy(IconData iconData, String title, MaterialColor materialColor) {
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
          color: materialColor, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget inputInformation(TextEditingController textEditingController,
      String title, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: title,
            prefixIcon: Icon(icon),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          )),
    );
  }
}
