import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project1/src/services/utilities/app_url.dart';
import 'package:project1/src/services/utilities/colors.dart';
import 'package:project1/src/ui/history/history.dart';
import 'package:shimmer/shimmer.dart';

import 'package:vnpay_flutter/vnpay_flutter.dart';
import '../../services/api/order_service.dart';

import '../payment/After_Pay.dart';

class HistoryDetail extends StatefulWidget {
  int order_id;

  HistoryDetail({required this.order_id});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  int is_paymented = 0;
  final f = NumberFormat("###,###.###", "tr_TR");
  final List<String> reasons = [
    'Muốn thay địa chỉ giao hàng',
    'Thủ tục thanh toán quá rắc rối',
    'Muốn đổi/nhập mã Voucher',
    'Đổi ý, không mua nữa'
  ];
  RxString reason = 'Muốn thay địa chỉ giao hàng'.obs;

  void cancelOrder(String orderId, String reason) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppUrl.postCancelOrder),
          body: {'reason': reason, 'order_code': orderId});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${data['message']}")));

        setState(() {});
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Hủy đơn hàng thất bại")));
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
              title: const Text("Chi tiết hoá đơn",
                  style: TextStyle(fontSize: 20)),
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
                                        ]),
                                    const Expanded(child: SizedBox()),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => buildBottomSheet(
                                                "${snapshot.data!['info']['order_code']}"));
                                      },
                                      child: const Text(
                                        'Hủy đơn',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
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
                        isPayment(snapshot.data)
                    ],
                  );
                }
              },
            )));
  }

  Widget buildBottomSheet(String orderCode) {
    return Obx(() => Container(
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                const Center(
                    child: Text(
                  "Chọn lý do hủy",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffffecdf),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Row(
                    children: const [
                      SizedBox(width: 10),
                      Icon(
                        Icons.warning_amber_sharp,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Vui lòng chọn lý do hủy. Với lý do này, bạn sẽ hủy tất cả sản phẩm trong đơn hàng và không thể thay đổi sau đó.",
                          style: TextStyle(color: Colors.orange, fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: reasons
                              .map((e) => RadioListTile(
                                  title: Text(e),
                                  value: e,
                                  groupValue: reason.value,
                                  activeColor: Colors.red,
                                  onChanged: (vl) {
                                    reason.value = vl!;
                                  }))
                              .toList(),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                cancelOrder(orderCode.toString(), reason.value.toString());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Đồng ý',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ])));
  }

  Widget isPayment(data) {
    return InkWell(
      onTap: () {
        onPaymentVnPay(
            data!["info"]!["order_code"], data!["info"]!["total_payment"]);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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

  void onPaymentVnPay(order_code, total_payment) async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
      //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'F52HC9LF',
      //vnpay tmn code, get from vnpay
      txnRef: order_code,
      orderInfo: 'Thanh toán đơn hàng',
      //order info, default is Pay Order
      amount: double.tryParse(total_payment.toString()) ?? 0.0,
      returnUrl: 'http://schemas.android.com/apk/res/android',
      //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey: 'NAKQHMIIDOHWTSZSEMLFXYZNAJLSZAMS',
      //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType
          .HMACSHA512, //hash type. Default is HmacSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2
    );
    VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AfterPay(title: "Thanh toán thành công")));
        });
      },
      onPaymentError: (params) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AfterPay(title: "Thanh toán thất bại")));
        });
      },
    );
  }
}
