import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:project1/src/services/utilities/colors.dart';
import 'package:project1/src/ui/history/return_refund.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/api/order_service.dart';
import 'detail_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  TextEditingController searchController = TextEditingController();
  @override
  var box = Hive.box('userBox');
  final f = NumberFormat("###,###.###", "tr_TR");

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
                actions: [
                  Expanded(child: searchFilter()),
                  const SizedBox(
                    width: 20,
                  )
                ],
                // title: const Text("Lịch sử mua hàng", style: TextStyle(fontSize: 20)),
                bottom: const TabBar(
                  tabs: <Widget>[
                    Text(
                      "Đã thanh toán",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      "Chưa thanh toán",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                  indicatorWeight: 4,
                  indicatorColor: Color.fromRGBO(200, 198, 239, 1.0),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  listHistory(box.get('id').toString(), "1"),
                  listHistory(box.get('id').toString(), "0"),
                ],
              ))),
    );
  }

  Widget listHistory(String id, String isPaymented) {
    OrderProvider listOrder = OrderProvider();

    return Center(
      child: FutureBuilder(
        future: listOrder.getListOrder(id.toString()),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.2,
                        ),
                      );
                    }));
          } else {
            var mapsnapshot = new Map();
            int lengthMap = 0;
            for (int i = 0; i < snapshot.data!.length; i++) {
              if (snapshot.data![i]['is_paymented'] == isPaymented) {
                mapsnapshot[lengthMap] = snapshot.data![i];
                lengthMap++;
              }
            }
            return ListView.builder(
                itemCount: mapsnapshot.length,
                itemBuilder: (context, index) {
                  return _showOrder(mapsnapshot[index], isPaymented);
                });
          }
        },
      ),
    );
  }

  Widget searchFilter() {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
              // height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FB),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(5)),
              padding:
                  const EdgeInsets.symmetric(horizontal: (8), vertical: (7)),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: (12),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Nhập để tìm kiếm",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: (4), vertical: (10)),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showOrder(item, String isPaymented) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          //TODO: Change to detail history screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HistoryDetail(
                        order_id: item["order_id"],
                      )));
        },
        child: ListTile(
          tileColor: Colors.grey[100],
          title: Row(
            children: [
              Text(item["date"].toString()!="" ?item["date"].toString(): ""),
              const Expanded(child: SizedBox()),
              Text(
                '${f.format(int.parse(item['total_payment']))} VNĐ',
                style: TextStyle(
                    color: (isPaymented == "1") ? Colors.green : Colors.red),
              )
            ],
          ),
          subtitle: Text("Mã hoá đơn: ${item["order_code"].toString()!="" ?item["order_code"].toString(): ""}"),
          trailing: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => RefundPage(
                        order_id: item["order_id"],
                      )));
            },
            child:  const Icon(
              size: 25,
              Icons.report_gmailerrorred,
              color: Colors.grey,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
