import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/src/models/product_detail.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider/CartProvider.dart';
import '../../../services/utilities/colors.dart';

class ProductDetailBottomModel extends StatefulWidget {
  final dynamic curentProductType;
  final List<ProductType> productType;
  final dynamic listProductType;
  final int productAmount;
  final ValueChanged<int> update;

  const ProductDetailBottomModel(
      {Key? key,
      required this.curentProductType,
      required this.productType,
      required this.listProductType,
      required this.productAmount,
      required this.update})
      : super(key: key);

  @override
  State<ProductDetailBottomModel> createState() =>
      _ProductDetailBottomModelState(productAmount);
}

class _ProductDetailBottomModelState extends State<ProductDetailBottomModel> {
  int productAmount;
  _ProductDetailBottomModelState(this.productAmount);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('productBox');
    return SafeArea(
        child: Wrap(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.curentProductType(),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mùi hương',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          children: [
                            for (int i = 0; i < widget.productType.length; i++)
                              widget.listProductType(widget.productType[i])
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Số lượng',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(children: [
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (productAmount > 1) {
                                setState(() {
                                  productAmount = productAmount - 1;
                                });
                                widget.update(productAmount);
                              } else {
                                print('Error: Amount must be large than 1');
                              }
                            }),
                        Text(productAmount.toString()),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                productAmount = productAmount + 1;
                              });
                              widget.update(productAmount);
                            })
                      ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addItem(
                            productId: box.get('productInfo')['id'],
                            productTypeId: box.get('productInfo')['typeId'],
                            title: box.get('productInfo')['title'],
                            amount: box.get('productInfo')['amount'],
                            price: box.get('productInfo')['price'],
                            image: box.get('productInfo')['image'],
                            type: box.get('productInfo')['type'],
                          );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: PRIMARY_COLOR),
                    child: const Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )),
      ],
    ));
    ;
  }
}
