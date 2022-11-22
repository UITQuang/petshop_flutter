import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project1/src/services/utilities/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/api/order_service.dart';

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

  @override
  Widget build(BuildContext context) {
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
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/images/avatar.jpg")),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      const Text(
                                        "Rank: bronze",
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
                                    "${f.format(10000)} point",
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(8.0,8,0,10),
                                child: Text(
                                    "Giá trị đơn hàng cần để đạt hàng Gold trong tháng tiếp theo là : 500.000 đ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ),
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width * 0.93,
                                lineHeight:
                                    MediaQuery.of(context).size.width * 0.04,
                                animation: true,
                                percent: 0.6,
                                animationDuration: 2000,
                                progressColor: Colors.yellow,
                                center: const  Text("60%"),
                                barRadius: const Radius.circular(5),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0, top: 10),
                                child: Row(children: [
                                  Icon(Icons.card_membership_outlined,color: Colors.brown[200],),
                                  const Expanded(child: SizedBox()),
                                  Icon(Icons.card_membership_outlined,color: Colors.grey[400],),
                                  const Expanded(child: SizedBox()),
                                  Icon(Icons.card_membership_outlined,color: Colors.yellow[400],),
                                ],),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.6,
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                           for(int i=0;i<5;i++)(
                           voucher()
                           )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(int i=0;i<5;i++)(
                  voucher()
              )
            ],
          ),
        ),
      ),
                ],
              ))),
    );
  }
  Widget voucher(){
    return Container(
      child: Row(
        children: [
          const Icon(Icons.gif_box_outlined,size: 40,),
          const SizedBox(width: 20,),
          const Text("E-Coupon giảm 50%",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18)),
          const Expanded(child: SizedBox()),
          btnGetVoucher()
        ],
      ),
    );
  }
  Widget btnGetVoucher(){
    return GestureDetector(
      onTap: (){},
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
}
