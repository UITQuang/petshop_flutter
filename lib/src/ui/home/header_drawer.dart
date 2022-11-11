import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
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
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
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

                  onTap: () {},
                  child: const Icon(Icons.camera_alt_outlined, color: Colors.white,),
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
