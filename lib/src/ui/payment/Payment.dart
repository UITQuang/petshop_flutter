import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:project1/src/services/api/order_service.dart';
import 'package:project1/src/services/api/voucher_service.dart';
import 'package:project1/src/ui/payment/After_Pay.dart';
import 'package:provider/provider.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../providers/cart_provider/CartProvider.dart';
import '../../services/utilities/app_url.dart';
import '../updateProfile/profile.dart';

import 'apply_voucher.dart';

import 'components/PaymentItem.dart';
import 'method_payment.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);
  @override
  State<Payment> createState() => _PaymentState();
}

//vnpay
class _PaymentState extends State<Payment> {
  var box = Hive.box('userBox');
  var title;
  int feeShip = 20000;
  _PaymentState({this.title = 'Giỏ hàng'});

  String responseCode = '';
  String vnp_TxnRef = '';
  String method = "Thanh toán bằng Vnpay"; //1:momo 2:vnpay 3:cod
  //voucher
  String voucher = "";
  int discount_price = 0;
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

    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      if(box.get("address").toString() == ""){
        _showDialog(context);
      }else{
        print(box.get("address").toString());
      }
    });
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }
  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Nhắc nhở"),
            content: const Text("Bạn chưa thiết lập địa chỉ, vui lòng cập nhật địa chỉ!"),
            actions: <Widget>[
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
                },
                  child: const Text("Cập nhật"))
            ],
          );
        });
  }


  Widget build(BuildContext context) {

    // TODO: implement build
    final cartItemsData = Provider.of<CartProvider>(context);
    var size = MediaQuery.of(context).size;
    VoucherService voucherService = VoucherService();
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(31, 29, 72, 1),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(title, style: const TextStyle(fontSize: 20)),
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
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text('Tin nhắn:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text('Lưu ý cho người bán...',
                                style: TextStyle(
                                    color: Color.fromRGBO(152, 152, 152, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ]))
                ]),
                Row(children: <Widget>[
                  Container(
                    //width: x,
                      width: size.width,
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>  [
                            const Text('Tổng số tiền:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text('₫${cartItemsData.totalProductCost()}',
                                style: const TextStyle(
                                    color: Color.fromRGBO(31, 29, 72, 1),
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold))
                          ]))
                ]),
                Row(children: <Widget>[
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const ApplyVoucher()));
                      setState(() {
                        if(result == null){
                          voucher = "";
                          discount_price = 0;
                        }else{
                          voucher = result["id_voucher"];
                          discount_price = calcVoucher(result, cartItemsData.totalPay(feeShip));
                        }
                      });
                    },
                    child: Container(
                      //width: x,
                        width: size.width,
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Áp dụng voucher',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500)),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(voucher,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Color.fromRGBO(152, 152, 152, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    const Icon(
                                      size: 15,
                                      Icons.arrow_forward_ios_rounded,
                                      color: Color.fromRGBO(152, 152, 152, 1),
                                    )
                                  ]),
                            ])),
                  )
                ]),

                Row(children: <Widget>[
                  Container(
                      width: size.width,
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.fromLTRB(22.0, 15.0, 15.0, 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Chi tiết thanh toán',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                                    width: size.width * 0.85,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text('Tổng tiền hàng',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          Text(
                                              '₫${cartItemsData.totalProductCost().roundToDouble()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                                    width: size.width * 0.85,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text('Áp dụng voucher',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          Text('-₫${discount_price.roundToDouble()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                                    width: size.width * 0.85,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text('Tổng tiền vận chuyển',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          Text('₫${feeShip.roundToDouble()}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.89,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text('Tổng thanh toán',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          Text('₫${cartItemsData.totalPay(feeShip) - discount_price}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      31, 29, 72, 1),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold)),
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
                        method =  result ?? "Thanh toán bằng Vnpay";
                      });
                    },
                    child: Container(
                      //width: x,
                        width: size.width,
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Hình thức thanh toán',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500)),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(method!="" ?method: "",
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Color.fromRGBO(152, 152, 152, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    const Icon(
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
            color: const Color.fromRGBO(31, 29, 72, 1),
            child: InkWell(
              onTap: () {
                if(box.get("address").toString() == ""){
                  _showDialog(context);
                }else{
                  voucherService.removeVoucher(box.get("id").toString(), voucher);
                  int total = cartItemsData.totalPay(feeShip).round() - discount_price;

                  createOrder(
                      order_code: DateTime.now().millisecondsSinceEpoch.toString(),
                      o_name: box.get("name"),
                      o_email: box.get("email"),
                      o_phone: box.get("phone"),
                      o_address: box.get("address"),
                      user_id: box.get("id").toString(),
                      order_description: "",
                      total_payment: total.toString(),
                      amount: cartItemsData.totalProductCost().toString() ,
                      arr_product: cartItemsData.generalItems()
                  );
                  cartItemsData.removeAll();
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
        ));
  }

  Widget showInfoBuyer() {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: const EdgeInsets.all(15.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                    width: 30,
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.place,
                      color: Colors.black,
                      size: 30,
                    ))
              ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Địa chỉ nhận hàng',
                        style: TextStyle(fontSize: 14)),
                    Text('${box.get("name") ?? ''} | ${box.get("phone")??''} ',
                        style: TextStyle(fontSize: 14)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Wrap(children: [
                        Text(
                            '${box.get("address")}',
                            style: const TextStyle(fontSize: 14)),
                      ]),
                    )
                  ])
            ]));
  }

  //thanh toán vnpay
  void onPaymentVnPay(orderCode,totalPayment) async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url:
          'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'F52HC9LF', //vnpay tmn code, get from vnpay
      txnRef: orderCode,
      orderInfo: 'Thanh toán đơn hàng', //order info, default is Pay Order
      amount: double.tryParse(totalPayment.toString())?? 0.0,
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
          Navigator.push(context,MaterialPageRoute( builder: (context) =>AfterPay(title: "Đặt hàng thành công")));
        });
      },
      onPaymentError: (params) {
        setState(() {
          responseCode = 'Error';
         Navigator.push( context,MaterialPageRoute( builder: (context) => AfterPay(title: "Đặt hàng thất bại")));
        });
      },
    );
  }

  //thanh toán bằng momo
  void onPaymentMomo(orderCode,totalPayment) async {
    MomoPaymentInfo options = MomoPaymentInfo(
        merchantName: "MoMo",
        appScheme: "pet_shop",
        merchantCode: 'MOMOIQA420180417',
        partnerCode: 'pet_shop',
        amount: int.parse(totalPayment.toString()),
        orderId: orderCode.toString() ,
        orderLabel: 'Thanh toán đơn hàng',
        merchantNameLabel: "Thanh toán MoMo",
        fee: feeShip,
        description: 'Thanh toán đơn hàng',
        username: box.get("name"),
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

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";

      Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterPay(title: "Đặt hàng thành công")));
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterPay(title: "Đặt hàng thất bại")));
    }
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

  // ignore: non_constant_identifier_names
  void createOrder({String? order_code, String? o_name, String? o_phone ,String? o_email,String? amount,String? total_payment, String?  o_address,String? user_id,String? order_description,List<dynamic>? arr_product}) async {
    try {
      http.Response response = await http.post(Uri.parse(AppUrl.createOrder),
          body:{
            'order_code': order_code,
            'o_name': o_name,
            'o_phone': o_phone,
            'o_email': o_email,
            'amount': amount,
            'total_payment' : total_payment,
            'o_address' :  o_address,
            'user_id' : user_id,
            'order_description' : '',
            'arr_product' : json.encode(arr_product)
          }
          );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data.toString());
        String orderCode = data["order_code"].toString();
        int totalPayment = data["total_payment"];

        if (method == "Thanh toán bằng Momo") {
          // print("Thanh toán bằng Momo");
          OrderProvider orderProvider = new OrderProvider();
          print(orderCode);
          orderProvider.handlePaymentStatus(orderCode);
          onPaymentMomo(orderCode,totalPayment);

        } else if (method == "Thanh toán bằng Vnpay") {
          // print("Thanh toán bằng Vnpay");
          onPaymentVnPay(orderCode,totalPayment);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterPay(title: "Đặt hàng thành công")));
        }
      } else {
        print('tạo đơn thành thất bại - do đường truyền mạng');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  int calcVoucher(voucher, totalPayment){
    int discountPrice = 0;
    int discountPercent = 0;
    int maxPrice = 0;
    String typeVoucher = "";
    typeVoucher = voucher["type_voucher"];

    if(typeVoucher == "price"){
      discountPrice = voucher["discount_price"];
    }else if(typeVoucher == "percent"){
      discountPercent = voucher["discount_percent"];
      maxPrice = voucher["max_price"];
      double result = 0;
      result = totalPayment * discountPercent/100;
      discountPrice  = result.round();
      if(discountPrice > maxPrice){
        discountPrice = maxPrice;
      }
    }else{
      discountPrice = 0;
    }
    return discountPrice;
  }
}
