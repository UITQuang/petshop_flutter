import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/src/ui/payment/After_Pay.dart';
import 'package:provider/provider.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:flutter/foundation.dart';

import '../../providers/cart_provider/CartProvider.dart';
import 'components/PaymentItem.dart';
import 'method_payment.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);
  @override
  State<Payment> createState() => _PaymentState();
}

//vnpay
class _PaymentState extends State<Payment> {
  var title;
  _PaymentState({this.title = 'Giỏ hàng'});

  @override
  String responseCode = '';
  String vnp_TxnRef = '';
  String method = "Thanh toán bằng Momo"; //1:momo 2:vnpay 3:cod

  //momo
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  // ignore: non_constant_identifier_names
  late String _paymentStatus;
  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final cartItemsData = Provider.of<CartProvider>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
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
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
          children: <Widget>[
            Row(children: <Widget>[showInfoBuyer()]),
            Column(children: <Widget>[
              for (int i = 0; i < cartItemsData.items.length; i++)
                showProductItem(context, cartItemsData.items.values.toList()[i])
            ]),
            Row(children: <Widget>[
              Container(
                  width: size.width,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text('Tin nhắn:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          child: const Text('Lưu ý cho người bán...',
                              style: TextStyle(
                                  color: Color.fromRGBO(152, 152, 152, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        )
                      ]))
            ]),
            Row(children: <Widget>[
              Container(
                  //width: x,
                  width: size.width,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text('Tổng số tiền:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          child: Text('₫${cartItemsData.totalProductCost()}',
                              style: TextStyle(
                                  color: Color.fromRGBO(31, 29, 72, 1),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                        )
                      ]))
            ]),
            Row(children: <Widget>[
              Container(
                  width: size.width,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(22.0, 15.0, 15.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Chi tiết thanh toán',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                                width: size.width * 0.85,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text('Tổng tiền hàng',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Container(
                                        child: Text(
                                            '₫${cartItemsData.totalProductCost()}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                                width: size.width * 0.85,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text('Tổng tiền vận chuyển',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Container(
                                        child: const Text('₫20.000',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ]),
                              ),
                              Container(
                                width: size.width * 0.89,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text('Tổng thanh toán',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Container(
                                        child: Text('₫${cartItemsData.totalPay(20)}',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    31, 29, 72, 1),
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ]),
                              ),
                            ]),
                      ]))
            ]),
            Row(children: <Widget>[
              InkWell(
                onTap: () async {
                  final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MethodPayment()));
                  setState(() {
                    method = result;
                  });
                },
                child: Container(
                    //width: x,
                    width: size.width,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('Hình thức thanh toán',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(method ?? "",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Color.fromRGBO(152, 152, 152, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                Icon(
                                  size: 15,
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromRGBO(152, 152, 152, 1),
                                )
                              ]),
                        ])),
              )
            ])
          ]),
      bottomNavigationBar: Material(
        color: Color.fromRGBO(31, 29, 72, 1),
        child: InkWell(
          onTap: () {
            //Gửi thông tin đơn hàng lên server -> tạo đơn hàng

            if (method == "Thanh toán bằng Momo") {
              // print("Thanh toán bằng Momo");
              onPaymentMomo();
            } else if (method == "Thanh toán bằng Vnpay") {
              // print("Thanh toán bằng Vnpay");
              onPaymentVnPay();
            } else {
              print("COD");
            }
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'MUA HÀNG',
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
    );
  }

  Widget showInfoBuyer() {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                    width: 30,
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.place,
                      color: Colors.black,
                      size: 30,
                    ))
              ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('Địa chỉ nhận hàng',
                          style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      child: Text('Nguyễn Quang Linh | 0388888888',
                          style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Wrap(children: [
                        Text(
                            'Ktx khu b, đại học quốc gia, phường Đông Hoà, Dĩ An, Bình Dương',
                            style: TextStyle(fontSize: 14)),
                      ]),
                    )
                  ])
            ]));
  }

  //thanh toán vnpay
  void onPaymentVnPay() async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url:
          'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'F52HC9LF', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Pay 30.000 VND', //order info, default is Pay Order
      amount: 30000,
      returnUrl:
          'http://schemas.android.com/apk/res/android', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey:
          'NAKQHMIIDOHWTSZSEMLFXYZNAJLSZAMS', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType
          .HMACSHA512, //hash type. Default is HmacSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2
    );
    VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        setState(() {
          responseCode = params['vnp_ResponseCode'];
          vnp_TxnRef = params['vnp_TxnRef'];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AfterPay(title: "Đặt hàng thành công")));
        });
      },
      onPaymentError: (params) {
        setState(() {
          responseCode = 'Error';
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AfterPay(title: "Đặt hàng thất bại")));
        });
      },
    );
  }

  //thanh toán bằng momo
  @override
  void onPaymentMomo() async {
    MomoPaymentInfo options = MomoPaymentInfo(
        merchantName: "MoMo",
        appScheme: "pet_shop",
        merchantCode: 'MOMOIQA420180417',
        partnerCode: 'pet_shop',
        amount: 60000,
        orderId: '0123',
        orderLabel: 'Thanh toán đơn hàng',
        merchantNameLabel: "Thanh toán MoMo",
        fee: 10,
        description: 'Thanh toán đơn hàng',
        username: '01234567890',
        partner: 'merchant',
        extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
        isTestMode: true
        //    pet_shop
        );
    try {
      _momoPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterPay(title: "Đặt hàng thành công")));
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterPay(title: "Đặt hàng thất bại")));
    }
    print(_paymentStatus);
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
  }
}
