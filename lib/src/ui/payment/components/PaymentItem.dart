import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider/CartProvider.dart';

Widget showProductItem(context, cartItem) {

  return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      child: Row(children: <Widget>[
        Container(
          width: 85,
          height: 85,
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
              color: Colors.red[100],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    cartItem.image.toString(),
                  ))),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(cartItem.title.toString(),
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              Container(
                child: Text(cartItem.type.toString(),
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text('₫${double.parse(cartItem.price) * cartItem.amount}00',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                      ),
                      Container(
                        child: Text('x${cartItem.amount}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                      ),
                    ]),
              ),
            ])
      ]));
}