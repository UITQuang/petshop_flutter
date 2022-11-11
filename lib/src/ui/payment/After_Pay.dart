import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AfterPay extends StatelessWidget {
  late String title;

  AfterPay({this.title = 'Đặt hàng thành công'});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              bottomOpacity: 0.0,
              elevation: 0.0,
              backgroundColor: Color.fromRGBO(31, 29, 72, 1),
            ),
            body: Container(
                color: Color.fromRGBO(31, 29, 72, 1),
                child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 10, 120),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          height: 140,
                          width: 300,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 300,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  this.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: 300,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Đơn hàng của bạn đã được gửi đến\nchủ shop. Xin đợi chủ shop xác nhận',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                  width: 300,
                                  child: Row(
                                    children: <Widget>[
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          //shape: StadiumBorder(),
                                          side: BorderSide(
                                              width: 1, color: Colors.white),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Trang chủ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          //shape: StadiumBorder(),
                                          side: BorderSide(
                                              width: 1, color: Colors.white),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Đơn mua',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )),
                    ],
                  ),
                ]))));
  }
}