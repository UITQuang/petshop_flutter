import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project1/src/services/api/voucher_service.dart';
import 'package:project1/src/services/utilities/colors.dart';
import 'package:project1/src/ui/home/home.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/api/order_service.dart';
import '../../services/utilities/app_url.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  State<MembershipPage> createState() => _MembershipPage();
}

class _MembershipPage extends State<MembershipPage> {
  TextEditingController searchController = TextEditingController();
  @override
  var box = Hive.box('userBox');
  final f = NumberFormat("###,###.###", "tr_TR");
  File? image;
  String point = "0";


  @override
  Widget build(BuildContext context) {

    VoucherService voucherService = VoucherService();
    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                backgroundColor: PRIMARY_COLOR,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text("Khách hàng thân thiết",
                    style: TextStyle(fontSize: 20)),
                bottom: const TabBar(
                  tabs: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Điểm tích lũy",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Voucher của bạn",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                  indicatorWeight: 4,
                  indicatorColor: Color.fromRGBO(200, 198, 239, 1.0),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Column(
                    children: [
                      FutureBuilder(
                          future: voucherService.getInfoRank(box.get("id").toString()),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Text("Chưa có dữ liệu");
                            }else {
                              point = snapshot.data!["point"].toString();
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.width * 0.55,
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                                                child: SizedBox(
                                                  height:
                                                  MediaQuery.of(context).size.width *
                                                      0.15,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.15,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    // Image border
                                                    child: SizedBox.fromSize(
                                                        child: image != null
                                                            ? Image.file(
                                                          image!,
                                                          fit: BoxFit.contain,
                                                        )
                                                            : Image.network(AppUrl.url + box.get("picture"))),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snapshot.data!["name"].toString()}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Rank: ${snapshot.data!["rank"].toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Image.asset(
                                                    "assets/images/membership.png",
                                                    height:
                                                    MediaQuery.of(context).size.width *
                                                        0.3,
                                                    width:
                                                    MediaQuery.of(context).size.width *
                                                        0.5,
                                                  )),
                                              Text(
                                                "${point} point",
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.width * 0.4,
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Quá trình tích lũy",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(8.0, 8, 0, 10),
                                            child: Text(
                                                snapshot.data!["text_next_rank"] ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                          LinearPercentIndicator(
                                            width: MediaQuery.of(context).size.width * 0.93,
                                            lineHeight:
                                            MediaQuery.of(context).size.width * 0.04,
                                            animation: true,
                                            percent: double.parse(snapshot.data!["percent"].toString()),
                                            animationDuration: 2000,
                                            progressColor: Colors.yellow,
                                            center:  Text(
                                                "${(double.parse(snapshot.data!["percent"].toString()) * 100).roundToDouble().toString()}%"
                                            ),
                                            barRadius: const Radius.circular(5),
                                            linearStrokeCap: LinearStrokeCap.roundAll,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0, top: 10),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.card_membership_outlined,
                                                  color: Colors.brown[200],
                                                ),
                                                const Expanded(child: SizedBox()),
                                                Icon(
                                                  Icons.card_membership_outlined,
                                                  color: Colors.grey[400],
                                                ),
                                                const Expanded(child: SizedBox()),
                                                Icon(
                                                  Icons.card_membership_outlined,
                                                  color: Colors.yellow[400],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
                          ),
                      FutureBuilder(
                        future: voucherService.getVoucherList(),
                          builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return Text("Đang load");
                          }else{
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: MediaQuery.of(context).size.width * 0.6,
                                width: MediaQuery.of(context).size.width * 0.95,
                                decoration: BoxDecoration(
                                  color: BACKGROUND_COLOR,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return voucher(snapshot.data![index] , "đổi");
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          })
                    ],
                  ),
                  FutureBuilder(
                    future: voucherService.getVoucherUser(box.get('id').toString()),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData){
                        return Text("Chưa có dữ liệu");
                      }else{
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.6,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              color: BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return voucher(snapshot.data![index], "");
                                  },
                                )
                                // for(int i = 0 ; i< snapshot.data!.length ; i++)(
                                //     voucher()
                                //    )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ))),
    );
  }

  Widget voucher(voucher, type){
    var size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        width: size.width,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: NetworkImage(AppUrl.url + voucher["picture"]) , width: 100, height: 100,),
            Container(
              // alignment: Alignment.centerLeft,
              width: size.width - 220,
              child: Wrap(
                children: [
                  Text(voucher["title"].toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16)),
                  type != "đổi" ?
                  Text(voucher["content"].toString(),style: TextStyle(fontSize: 12))
                      : Text('Điểm để đổi: ${voucher["point"].toString()}',style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            if(type == "đổi")
              applyVoucher(voucher)
            else
              InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: Column(
                    children: [
                      Text("Áp dụng",style: TextStyle(fontSize: 12, color: Colors.orange.shade900),),
                      Text('x${voucher["quantity"]}')
                    ],
                  )),
          ],
        )
    );
  }

  Widget applyVoucher(voucher){
    VoucherService voucherService = VoucherService();

    return GestureDetector(
      onTap: () async {
          //TODO:: Trừ số điểm khách - thêm voucher vào danh sách
          bool is_succes = await voucherService.redeemVoucher(box.get("id").toString() , voucher["id_voucher"].toString());
          //TODO:: Đổi thành công xuất thông báo
          if(is_succes){
            setState(() {
              point = (int.parse(point) - int.parse(voucher["point"])).toString();
            });
            _showDialog(context, "Đổi voucher thành công");
          }else{
            _showDialog(context, "Đổi voucher thất bại");
          }
        },
      child: Container(
        width: MediaQuery.of(context).size.width*0.2,
        height: MediaQuery.of(context).size.width*0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: PRIMARY_COLOR
        ),
        child: const Center(child: Text("Đổi",style: TextStyle(color: Colors.white,fontSize: 16),),),
      ),
    );
  }

  _showDialog(BuildContext context, String textAlert) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Thông báo"),
            content: Text(textAlert),
          );
        });
  }
}
