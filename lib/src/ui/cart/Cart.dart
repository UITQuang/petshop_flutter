import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/src/ui/payment/Payment.dart';

class Cart extends StatelessWidget {
  var title;

  Cart({this.title = 'Giỏ hàng'});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 29, 72, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {

          },
        ),
        title: Text(title, style: TextStyle(fontSize: 20)),
      ),
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          children: <Widget>[
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            ),
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            ),
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            ),
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            ),
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            ),
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            ),
            CartItem(
              title: 'Hạt dinh dưỡng cho mèo CATSON',
              amount: '1',
              price: '89000',
              image: "assets/images/product.png",
            )
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
                'TIẾN HÀNH ĐẶT HÀNG',
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

class CartItem extends StatelessWidget {
  CartItem(
      {this.title = '', this.amount = '', this.price = '', this.image = ''});
  final String title;
  final String amount;
  final String price;
  final String image;

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(13.0, 0, 13.0, 12.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.5,
                              color: Color.fromRGBO(232, 232, 232, 1)))),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(
                            width: 85,
                            height: 85,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      this.image,
                                    ))),
                          ),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: size - (85 + 20 + 36),
                                        child: Text(
                                          this.title,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                        width: 20,
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    152, 152, 152, 1))),
                                        child: Icon(
                                          Icons.delete_forever_rounded,
                                          color: Colors.black,
                                          size: 14,
                                        ))
                                  ]),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: size - (85 + 15*2 + 10),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(children: <Widget>[
                                          Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Color.fromRGBO(
                                                          186, 186, 186, 1))),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: 14,
                                              )),
                                          Container(
                                              width: 20,
                                              height: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Color.fromRGBO(
                                                          186, 186, 186, 1))),
                                              child: Text(this.amount,
                                                  style:
                                                      TextStyle(fontSize: 15))),
                                          Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Color.fromRGBO(
                                                          186, 186, 186, 1))),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 14,
                                              )),
                                        ]),
                                      ),
                                      Container(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.close_sharp,
                                                color: Colors.grey,
                                                size: 18,
                                              ),
                                              Text(this.price,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ]),
                                      )
                                    ]),
                              )
                            ])
                      ]))),
        ]);
  }
}
