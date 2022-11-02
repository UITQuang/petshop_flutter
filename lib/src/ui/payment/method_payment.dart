import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MethodPayment extends StatelessWidget {
  var title;

  MethodPayment({this.title = 'Phương thức thanh toán'});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //var size = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(31, 29, 72, 1),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(title, style: TextStyle(fontSize: 20)),
          ),
          body:  ListView(
            padding: EdgeInsets.all(10),
              children: [
                method("assets/images/momo.png", "Momo"),
                method("assets/images/vnpay.png", "Vnpay"),
                method("assets/images/cod.png", "Thanh toán khi nhận hàng"),
              ],
          ),
          bottomNavigationBar: Material(
            color: Color.fromRGBO(31, 29, 72, 1),
            child: InkWell(
              onTap: () {
                //print('called on tap');
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'ĐỒNG Ý',
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
        ));
  }
  Widget method (String assetImage, String methodName){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: (){},
        child: Row(
          children:  [
            Image(image: AssetImage(assetImage), width: 45, height: 45,),
            SizedBox(width: 10,),
            Text(
              methodName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
            )
          ],
        ),
      ),
    );
  }
}
