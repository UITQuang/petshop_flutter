import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/api/order_service.dart';
import '../../services/utilities/app_url.dart';

class RefundPage extends StatefulWidget {
  int order_id = 0;

  RefundPage({required this.order_id});

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  TextEditingController detailController = TextEditingController();
  late String codeOder;
  var box = Hive.box('userBox');

  File? image;
  final _picker = ImagePicker();
  _showDialog(String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Thông báo"),
            content: Text(content),
            actions: <Widget>[
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"))
            ],
          );
        });
  }

  Future getImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      return;
    }
  }

  Future<void> postRefund(String orderCode, String id) async {
    var uri = Uri.parse(AppUrl.postRefund);
    var request = http.MultipartRequest('POST', uri);
    request.fields['user_id'] = id;

    request.fields['order_code'] = orderCode;
    request.fields['note'] = detailController.text.toString();
    if ((detailController.text.isEmpty)||(image==null) ){
      setState(() {_showDialog("Bạn cần thêm đầy đủ thông tin!");});
    } else {
      request.files.add(http.MultipartFile(
          'picture', image!.readAsBytes().asStream(), image!.lengthSync(),
          filename: image!.path.split('/').last));
      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          print("thanh cong");
        });
      } else {
        setState(() {
          print("false");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: const Color(0xff1F1D48),
            brightness: Brightness.light,
            titleSpacing: 10,
            automaticallyImplyLeading: true,
            title: const Text("Yêu cầu trả hàng"),
          ),
          bottomNavigationBar: Material(
            color: const Color(0xff1F1D48),
            child: InkWell(
              onTap: () {
                postRefund(codeOder, box.get("id").toString());
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Gửi yêu cầu ",
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                headerRefund(),
                codeOrder(),
                lineAcross(),
                detailProblem(),
                imageAttach()
              ],
            ),
          )),
    );
  }

  Widget headerRefund() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2))
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              child: SizedBox(
                height: 70,
                width: 70,
                child: (box.get("picture").toString() != "")
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            AppUrl.url + box.get("picture").toString()),
                      )
                    : const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.jpg"),
                      ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${box.get("name")}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${box.get("email")}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget codeOrder() {
    OrderProvider orderProvider = OrderProvider();

    return FutureBuilder(
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
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    height: 80,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        } else {
          codeOder = snapshot.data!['info']['order_code'];

          return Container(
            padding: EdgeInsets.fromLTRB(8, 15, 0, 15),
            child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                          width: 30,
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            CupertinoIcons.doc_plaintext,
                            size: 25.0,
                          ),
                        )
                      ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mã hoá đơn: ${snapshot.data!['info']['order_code']} ",
                            ),
                            const SizedBox(height: 8,),
                            Text(
                              "Ngày đặt: ${snapshot.data!['info']['date']} ",
                            ),
                          ])
                    ]),
              ],
            ),
          );
        }
      },
    );
  }

  Widget detailProblem() {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 15),
            child: Text(
              "Mô tả chi tiết về sản phẩm",
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextFormField(
            controller: detailController,
            maxLines: 5,
          )
        ],
      ),
    );
  }

  Widget imageAttach() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
            child: Row(
              children: [
                const Text(
                  "Hình ảnh đính kèm",
                  style: TextStyle(fontSize: 16),
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: const Icon(Icons.camera_alt_outlined),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            height: MediaQuery.of(context).size.width * 0.4,
            child: (image == null)
                ? const Center(child: Icon(Icons.image_outlined))
                : Center(
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
          )
        ],
      ),
    );
  }
  Widget lineAcross(){
    return  Container(
      margin:
      const EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.grey,
    );
  }
}
