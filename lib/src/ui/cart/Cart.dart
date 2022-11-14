import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/src/providers/cart_provider/CartProvider.dart';
import 'package:project1/src/ui/payment/Payment.dart';
import 'package:provider/provider.dart';
import 'components/CartItem.dart';

class Cart extends StatelessWidget {
  String title = '';

  Cart({this.title = 'Giỏ hàng'});
  @override
  Widget build(BuildContext context) {
    final cartItemsData = Provider.of<CartProvider>(context);
    //print(cartItemsData.items['product']?.title);
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
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
      body:ListView.builder(
            itemCount: cartItemsData.items.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            itemBuilder: (context, index) {
              print(cartItemsData.generalItems());
              return //ListView(
                //shrinkWrap: true,
                //padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                //children: <Widget>[
                //?. . - null handle value error
                CartItem(
                  productId: cartItemsData.items.keys.toList()[index],
                  id: cartItemsData.items.values.toList()[index].id.toString(),
                  productTypeId: cartItemsData.items.values
                      .toList()[index]
                      .productTypeId
                      .toString(),
                  title:
                  cartItemsData.items.values.toList()[index].title.toString(),
                  amount: cartItemsData.items.values.toList()[index].amount,
                  price:
                  cartItemsData.items.values.toList()[index].price.toString(),
                  image:
                  cartItemsData.items.values.toList()[index].image.toString(),
                  type: cartItemsData.items.values.toList()[index].type.toString(),
                );
              //]);
            }),

      bottomNavigationBar: Material(
        color: Color.fromRGBO(31, 29, 72, 1),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Payment()));
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
