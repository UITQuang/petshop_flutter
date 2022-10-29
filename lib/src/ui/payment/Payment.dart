import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Payment extends StatelessWidget {
  var title;

  Payment({this.title = 'Đặt hàng'});
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
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                //width: x,
                width: 411,
                  margin: EdgeInsets.only(top: 10.0),
                  color: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(
                              width: 30,
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.place,
                                color: Colors.black,
                                size: 30,
                              ))
                        ]),
                        Column(children: <Widget>[
                          Container(
                            //width: x/2
                            width: 330,
                            child: Text('Địa chỉ nhận hàng',
                                style: TextStyle(fontSize: 14)),
                          ),
                          Container(
                            width: 330,
                            child: Text('Nguyễn Quang Linh | 0388888888',
                                style: TextStyle(fontSize: 14)),
                          ),
                          Container(
                            width: 330,
                            child: Text(
                                'Ktx khu b, đại học quốc gia, phường Đông Hoà, Dĩ An, Bình Dương',
                                style: TextStyle(fontSize: 14)),
                          )
                        ])
                      ]))
            ]),
            Column(
              children: <Widget> [
                Container(
                  width: 411,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.fromLTRB(15.0,15.0,15.0,15.0),
                  child: Row(
                    children:<Widget> [
                      Container(
                        width: 85,
                        height: 85,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/product.png",
                                ))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Container(
                            //width: x/2
                            child:
                            Text('Hạt dinh dưỡng cho mèo CATSON',textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            //width: x/2
                            child:
                            Text('Phân loại: Táo',textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            //width: x,
                            width: 270,
                            child:
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child:
                                    Text('₫89.000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    child: Text('x1',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                  ),
                                ]
                            ),
                          ),
                        ]
                      )
                    ]
                  )
                ),
                Container(
                    width: 411,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 0.0),
                    padding: EdgeInsets.fromLTRB(15.0,15.0,15.0,15.0),
                    child: Row(
                        children:<Widget> [
                          Container(
                            width: 85,
                            height: 85,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/product.png",
                                    ))),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Container(
                                  //width: x/2
                                  child:
                                  Text('Hạt dinh dưỡng cho mèo CATSON',textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                ),
                                Container(
                                  //width: x/2
                                  child:
                                  Text('Phân loại: Táo',textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  //width: x,
                                  width: 270,
                                  child:
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          child:
                                          Text('₫89.000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                                        ),
                                        Container(
                                          child: Text('x1',
                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                        ),
                                      ]
                                  ),
                                ),
                              ]
                          )
                        ]
                    )
                )
              ]
            ),
            Row(children: <Widget>[
              Container(
                //width: x,
                width: 411,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0,15.0,22.0,15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child:
                              Text('Tin nhắn:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          child: Text('Lưu ý cho người bán...',
                              style: TextStyle(color: Color.fromRGBO(152, 152, 152, 1),fontSize: 16, fontWeight: FontWeight.w400)),
                        )
                      ]))
            ]),
            Row(children: <Widget>[
              Container(
                //width: x,
                  width: 411,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0,15.0,22.0,15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child:
                          Text('Tổng số tiền:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          child: Text('₫198.000',
                              style: TextStyle(color: Color.fromRGBO(31, 29, 72, 1),fontSize: 26, fontWeight: FontWeight.bold)),
                        )
                      ]))
            ]),
            Row(
                children: <Widget>[
              Container(
                //width: x,
                  width: 411,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0,15.0,15.0,15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              //width: x/2
                              width: 370,
                              child:
                              Text('Chi tiết thanh toán',textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                              width: 350,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child:
                                      Text('Tổng tiền hàng', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                    ),
                                    Container(
                                      child: Text('₫178.000',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                    ),
                                  ]
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                              width: 350,
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child:
                                      Text('Tổng tiền vận chuyển', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                    ),
                                    Container(
                                      child: Text('₫20.000',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                    ),
                                  ]
                              ),
                            ),
                            Container(
                              width: 370,
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child:
                                      Text('Tổng than toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      child: Text('₫198.000',
                                          style: TextStyle(color: Color.fromRGBO(31, 29, 72, 1),fontSize: 26, fontWeight: FontWeight.bold)),
                                    ),
                                  ]
                              ),
                            ),
                          ]
                        ),

                      ]))
            ]),
            Row(children: <Widget>[
              Container(
                //width: x,
                  width: 411,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0,15.0,22.0,15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child:
                          Text('Hình thức thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Text('Thanh toán khi nhận hàng',
                              style: TextStyle(color: Color.fromRGBO(152, 152, 152, 1),fontSize: 16, fontWeight: FontWeight.w400)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color.fromRGBO(152, 152, 152, 1),
                            )
                          ])
                      ]))
            ])
          ]),
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
                'MUA HÀNG',
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
}
