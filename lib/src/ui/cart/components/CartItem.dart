import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/src/providers/cart_provider/CartProvider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String productTypeId;
  final String title;
  final int amount;
  final String price;
  final String image;
  final String type;

  CartItem(
      {Key? key,
      required this.productId,
      required this.id, required this.productTypeId,
      required this.title,
      required this.amount,
      required this.price,
      required this.image,
      required this.type})
      : super(key: key);

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
                            width: 90,
                            height: 90,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
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
                                        width: size - (85 + 20 + 50),
                                        child: Text(
                                          this.title,
                                          softWrap: true,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color.fromRGBO(
                                                  152, 152, 152, 1))),
                                      child: IconButton(
                                          padding: EdgeInsets.only(right: 0),
                                          onPressed: () {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .removeItem(productId);
                                          },
                                          icon: Icon(
                                            Icons.delete_forever_rounded,
                                            color: Colors.black,
                                            size: 14,
                                          )),
                                    ),
                                  ]),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 8, 0, 10),
                                child: Text('Loại: ${this.type}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),),
                              Container(
                                width: size - (85 + 15 * 2 + 12),
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
                                              child: Text(
                                                  this.amount.toString(),
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
                                              Text('${double.parse(this.price)*this.amount}',
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
