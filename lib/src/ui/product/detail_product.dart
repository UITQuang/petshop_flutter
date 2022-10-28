import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/utilities/colors.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Column(
                  children: [
                    //Thông tin sản phẩm
                    Stack(
                      children: [
                        Image(
                          image: const NetworkImage(
                              'https://meowmeowpetshop.xyz/files/Product/cat-oscar.jpeg'),
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
                               print("back");
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
                                    print('oke');
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
                                    print('oke');
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
                                    'Cát vệ sinh cho mèo MIN 8L xuất sứ Nhật Bản (Ship nhanh TPHCM)',
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
                                  '₫' + '89.000',
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
                                  '₫' + '109.000',
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
                                          "✅Viên thơm khử mùi Cature | Hộp 450ml | Hạt khử mùi cát vệ sinh mèo.✅\r\n\r\nCông dụng\r\n\r\n✅ Không còn nỗi lo mùi khắp phòng, nhà toàn mùi khó chịu nơi vệ sinh của boss\r\n✅ Không còn phải đi tìm nhiều hay thay nhiều loại cát nào hợp với Boss.\r\n✅ Các hạt khử mùi đóng vai trò hấp phụ mùi, hấp thụ một phần nước tiểu, khóa nước tiểu và do đó làm giảm mùi hôi. \r\n✅ Khử mùi hiệu quả với 118 loại tinh dầu, phân huỷ amoniac, có khả năng kháng khuẩn đến 99,9%, hạt khử mùi Catute được làm từ bột giấy, cấu trúc bông xốp hoàn toàn không độc hại với thú cưng. An toàn sử dụng, mức độ toả hương lâu, hiệu quả và tiết kiệm.",
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
                              image: AssetImage('assets/shoppe_express.png'),
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
                                for (int i = 0; i < 9; i++)
                                  IconButton(
                                    icon: Image.asset('assets/product.png'),
                                    iconSize: 60,
                                    onPressed: () {},
                                  ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
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
                        _modalBottomSheetMenu();
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

  void _modalBottomSheetMenu() {
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
                            children: [
                              Image(
                                  width: 80,
                                  image: AssetImage('assets/product.png')),
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
                              for (int i = 0; i < 5; i++)
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
                                      children: [
                                        Image(
                                          image: AssetImage('assets/product.png'),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Số lượng',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                              child: Row(children: [
                            IconButton(
                                icon: Icon(Icons.remove), onPressed: () {}),
                            Text('1'),
                            IconButton(icon: Icon(Icons.add), onPressed: () {})
                          ]
                              )
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
