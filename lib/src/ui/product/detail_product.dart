
import 'package:flutter/material.dart';

import '../../services/utilities/app_url.dart';
import '../../services/utilities/colors.dart';
import 'package:project1/src/services/api/product_service.dart';
import '../../models/product_detail.dart';
import '../home/home.dart';


class DetailProductScreen extends StatefulWidget {
  int id;
   DetailProductScreen({
    required this.id
  });

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();

    return SafeArea(
      child:
        Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                FutureBuilder(
                    future: productService.getDetailProduct(widget.id),
                    builder: (context, AsyncSnapshot<ProductDetail> snapshot){
                      if(!snapshot.hasData){
                        return Text("loadding");
                      }else{
                        return Column(
                          children: [
                            //Thông tin sản phẩm
                            Stack(
                              children: [
                                Image(
                                  image: NetworkImage(AppUrl.url + snapshot.data!.product!.picture.toString()),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width * 0.8,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,

                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
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
                                          onPressed: () {
                                          },
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(40, 40),
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(0),
                                              backgroundColor: background_btn),
                                          child: const Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                          },
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
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: SECONDARY_COLOR,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: const Text(
                                            'Yêu thích+',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.product!.title.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '₫' + snapshot.data!.product!.price.toString(),
                                          style: TextStyle(
                                            fontSize: 26,
                                            color: SECONDARY_COLOR,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            snapshot.data!.product!.priceSale==""? '₫' + snapshot.data!.product!.priceSale.toString() : "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 20,
                                              decoration: TextDecoration.lineThrough),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Mô tả sản phẩm',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width - 50,
                                          height: 100,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      snapshot.data!.product!.content.toString(),
                                                      textAlign: TextAlign.justify,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),

                            //Vận chuyển
                            SizedBox(
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
                                    Image(
                                      image: AssetImage("assets/images/shoppe_express.png"),
                                      width: 100,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width: 250,
                                        child: Text(
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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Chọn loại hàng',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '(6 vị)',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                          IconButton(

                                            icon: Image.asset("assets/images/product.png"),
                            iconSize: 60,
                                            onPressed: () {},
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
          height: 60,
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
                        children: [
                          Icon(
                            Icons.chat,
                            color: PRIMARY_COLOR,
                            size: 35,
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
                        _modalBottomSheetMenu(widget.id);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: SECONDARY_COLOR),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            color: PRIMARY_COLOR,
                            size: 35,
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
                        padding: EdgeInsets.all(0),
                        backgroundColor: PRIMARY_COLOR),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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

  void _modalBottomSheetMenu(id) {
    ProductService productService = ProductService();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 350,
            color: Colors.transparent,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: const [
                              Image(
                                  width: 80,

                                  image: AssetImage("assets/images/product.png")),

                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '₫' + '89.000',
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
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mùi hương',
                            style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            children: [
                          Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: BACKGROUND_COLOR),
                        onPressed: () {},
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage("assets/images/product.png"),
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Táo ',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    )
                            ],
                          ),

                        ]
                      ),
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
                            icon: Icon(Icons.remove), onPressed: () {}),
                            const Text('1'),
                            IconButton(icon: Icon(Icons.add), onPressed: () {})
                          ]
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Mua ngay');
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PRIMARY_COLOR),
                        child: Text(
                          'Thêm vào giỏ hàng',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        });
  }
}
