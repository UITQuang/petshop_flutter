import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:project1/src/services/utilities/app_url.dart';
import 'package:project1/src/services/utilities/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/cart_provider/CartProvider.dart';
import '../../services/api/order_service.dart';
import '../updateProfile/profile.dart';
import '../payment/components/PaymentItem.dart';

class HistoryDetail extends StatefulWidget {
  int order_id;

  HistoryDetail({required this.order_id});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  int is_paymented = 0;
  final f = NumberFormat("###,###.###", "tr_TR");

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = OrderProvider();
    return SafeArea(
        child: Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: PRIMARY_COLOR,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("Chi tiết hoá đơn", style: TextStyle(fontSize: 20)),
            ),
            body: FutureBuilder(
              future: orderProvider.getDetailOrder(widget.order_id.toString()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            color: Colors.white,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 80,
                            color: Colors.white,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 80,
                            color: Colors.white,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 150,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, -1), // changes position of shadow
                            ),
                          ],
                        ),

                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: snapshot.data!['info']["is_paymented"] == "1"
                            ? AlertPaymented(snapshot.data!)
                            : AlertNonPaymented(snapshot.data!),

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Container(
                                          width: 30,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: const Icon(
                                            Icons.place_outlined,
                                            color: Colors.black,
                                            size: 30,
                                          ))
                                    ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Địa chỉ nhận hàng',


                                              style: TextStyle(fontSize: 14)),
                                          Text(
                                              '${snapshot.data!['info']['title']} | ${snapshot.data!['info']['phone']}',
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            child: Wrap(children: [
                                              Text(
                                                  'Địa chỉ: ${snapshot.data!['info']['address']}',
                                                  style: const TextStyle(
                                                      fontSize: 14)),
                                            ]),
                                          )
                                        ])
                                  ]),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Container(
                                        width: 30,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const Icon(
                                          CupertinoIcons.doc_plaintext,
                                          size: 25.0,
                                        ),
                                      )
                                    ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Mã hoá đơn: ${snapshot.data!['info']['order_code']} ",
                                          ),
                                          Text(
                                            "Ngày đặt: ${snapshot.data!['info']['date']} ",
                                          ),
                                        ])
                                  ]),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.grey,
                              ),
                              for (int i = 0;
                                  i < snapshot.data!['details'].length;
                                  i++)
                                showProductItem(
                                    context, snapshot.data!['details'][i])
                            ],
                          )),
                      if (snapshot.data!['info']!["is_paymented"] == "0")
                        IsPayment()
                    ],
                  );
                }
              },
            )));
  }

  Widget IsPayment() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: PRIMARY_COLOR,
        ),
        child: const Text(
          "Thanh toán",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget AlertPaymented(data) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
      Text(
        "Đơn hàng đã thanh toán",
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        CupertinoIcons.chevron_down_circle,
        color: Colors.green,
        size: 25.0,
      ),
    ]);
  }

  Widget AlertNonPaymented(data) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
      Text(
        "Đơn hàng chưa thanh toán",
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        CupertinoIcons.exclamationmark_circle,
        color: Colors.orange,
        size: 25.0,
      ),
    ]);
  }

  Widget showProductItem(context, item) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,

        padding: const EdgeInsets.only(bottom: 10),

        child: Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.25,
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                color: Colors.red[100],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(AppUrl.url + item["picture"].toString()))),
          ),

          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(item["title"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Phân loại: ${item["classify"].toString()}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('${f.format(int.parse(item['price']))} VNĐ',
                              style: const TextStyle(

                                  fontSize: 20, fontWeight: FontWeight.w400)),
                          Text('x${item["quantity"].toString()}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                        ]),
                  ),
                ]),
          )
        ]));
  }

}
