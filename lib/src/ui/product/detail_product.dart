import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/cart_provider/CartProvider.dart';
import '../../services/utilities/app_url.dart';
import '../../services/utilities/colors.dart';
import 'package:project1/src/services/api/product_service.dart';
import '../../models/product_detail.dart';
import '../cart/Cart.dart';
import '../home/home.dart';
import 'components/ProductDetailBottomModel.dart';

class DetailProductScreen extends StatefulWidget {
  int id;
  DetailProductScreen({required this.id});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final ScrollController _firstController = ScrollController();

  String activeTypeId = "";
  String picture = "";
  String price = "";
  String title = "";
  int amount = 1;

  var box = Hive.box('productBox');

  void _changeProduct(iProduct) {
    print(iProduct.picture);
    print(iProduct.id);
    setState(() {
      picture = iProduct!.picture;
      price = iProduct!.price;
      activeTypeId = iProduct!.id.toString();
      title = iProduct!.title;
    });
  }

  void _update(int newAmount) {
    setState(() => amount = newAmount);
  }

  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();

    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                FutureBuilder(
                    future: productService.getDetailProduct(widget.id),
                    builder: (context, AsyncSnapshot<ProductDetail> snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Container(
                                    color: Colors.white,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 3,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        box.put('productInfo', {
                          'id': snapshot.data!.product!.itemId.toString(),
                          'typeId': activeTypeId,
                          'title': snapshot.data!.product!.title.toString(),
                          'price': snapshot.data!.product!.price.toString(),
                          'image': AppUrl.url +
                              snapshot.data!.product!.picture.toString(),
                          'type': title.toString(),
                        });

                        return Column(
                          children: [
                            //Thông tin sản phẩm
                            Stack(
                              children: [
                                Image(
                                  image: NetworkImage(AppUrl.url +
                                      snapshot.data!.product!.picture
                                          .toString()),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.8,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(40, 40),
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(0),
                                          backgroundColor: background_btn),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(40, 40),
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(0),
                                              backgroundColor: background_btn),
                                          child: Stack(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  Cart()));
                                                    },
                                                    icon: Icon(
                                                        Icons.shopping_cart),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 3,
                                                top: 6,
                                                child: Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                      color: SECONDARY_COLOR,
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: Text(
                                                      context
                                                          .watch<CartProvider>()
                                                          .items
                                                          .length
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(40, 40),
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(0),
                                              backgroundColor: background_btn),
                                          child: const Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 2, 6, 2),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: SECONDARY_COLOR,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Text(
                                            'Yêu thích+',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.product!.title
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '₫' +
                                              snapshot.data!.product!.price
                                                  .toString(),
                                          style: const TextStyle(
                                            fontSize: 26,
                                            color: SECONDARY_COLOR,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data!.product!.priceSale ==
                                                  ""
                                              ? '₫' +
                                                  snapshot
                                                      .data!.product!.priceSale
                                                      .toString()
                                              : "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 20,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Mô tả sản phẩm',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          height: 100,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: SingleChildScrollView(
                                                child: Text(
                                                  snapshot
                                                      .data!.product!.content
                                                      .toString(),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),

                            //Vận chuyển
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/shoppe_express.png'),
                                      width: 100,
                                      height: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width: 250,
                                        child: const Text(
                                          'Dịch vụ giao hàng hoả tốc, đảm bảo bạn sẽ nhận được hàng trong vòng 4h tại TP.HCM',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ))
                                  ],
                                ),
                              ),
                            ),

                            //Chọn phân loại
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Text(
                                          'Chọn loại hàng',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                snapshot
                                                    .data!.productType!.length;
                                            i++)
                                          IconButton(
                                            icon: Image.network(AppUrl.url +
                                                snapshot.data!.productType![i]!
                                                    .picture
                                                    .toString()),
                                            iconSize: 60,
                                            onPressed: () {
                                              _modalBottomSheetMenu(
                                                  snapshot.data!.productType);
                                            },
                                          ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        );
                      }
                    }),
              ],
            )),
        bottomNavigationBar: Container(
          height: 50,
          color: SECONDARY_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        print('Chat');
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: SECONDARY_COLOR),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.chat,
                            color: PRIMARY_COLOR,
                            size: 30,
                          ),
                          Text(
                            'Chat ngay',
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ))),
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        // _modalBottomSheetMenu();
                        context.read<CartProvider>().addItem(
                              productId: box.get('productInfo')['id'],
                              productTypeId: box.get('productInfo')['typeId'],
                              title: box.get('productInfo')['title'],
                              amount: amount,
                              price: box.get('productInfo')['price'],
                              image: box.get('productInfo')['image'],
                              type: box.get('productInfo')['type'],
                            );
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: SECONDARY_COLOR),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_shopping_cart,
                            color: PRIMARY_COLOR,
                            size: 30,
                          ),
                          Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ))),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      print('Mua ngay');
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: PRIMARY_COLOR),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Mua ngay',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(productType) {
    Size size = MediaQuery.of(context).size;
    picture = productType[0]!.picture;
    price = productType[0]!.price;
    ProductService productService = ProductService();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => ProductDetailBottomModel(
              curentProductType: _curentProductType,
              productType: productType,
              listProductType: _listProductType,
              productAmount: amount, update: _update,
            ));
  }

  Widget _curentProductType() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Image(
                image: NetworkImage(AppUrl.url + picture),
                width: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '₫' + price,
                style: TextStyle(
                  fontSize: 26,
                  color: SECONDARY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
              alignment: Alignment.topRight,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }

  Widget _listProductType(iProduct) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: BACKGROUND_COLOR),
        onPressed: () {
          _changeProduct(iProduct);
        },
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image(
              image: NetworkImage(AppUrl.url + iProduct!.picture),
              width: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              iProduct.title.toString(),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
