import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project1/src/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:project1/src/ui/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/utilities/colors.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Center(
                  child: Icon(Icons.pets_outlined,size: 100,color: Colors.black54,),
                ),
              ),
              Expanded(child: SizedBox()),
             Text(
                "from",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
               SizedBox(
                height: 5,
              ),
              Text(
                "Huy_Linh_Quang",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: PRIMARY_COLOR,
                ),
              ),
             SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
