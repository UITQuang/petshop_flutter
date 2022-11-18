import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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

  @override
  Widget build(BuildContext context) {
    OrderProvider listOrder = OrderProvider();

    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Color.fromRGBO(31, 29, 72, 1),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [          Expanded(child: searchFilter()),
                SizedBox(width: 20,)
              ],
              // title: const Text("Lịch sử mua hàng", style: TextStyle(fontSize: 20)),
              bottom: const TabBar(
                tabs: <Widget>[
                  Text("Tất cả",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text("Chưa thanh toán",style: TextStyle(color: Colors.white,fontSize: 16),),
                ],
                indicatorWeight: 4,
                indicatorColor:  Color.fromRGBO(200, 198, 239, 1.0),
              ) ,
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: FutureBuilder(
                    future: listOrder.getListOrder(box.get("id").toString()),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child:
                          ListView.builder(
                              itemCount: 15,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0,),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: MediaQuery.of(context).size.width*0.9,
                                        height: MediaQuery.of(context).size.width*0.2,
                                  ),
                                );


                      }
                          ));}
                          else{
                        return ListView.builder(
                            itemCount: snapshot!.data!.length,
                            itemBuilder: (context, index){
                              return _showOrder(snapshot.data![index]);
                            });
                      }
                    },
                  ),
                ),
                const Center(child: Text("hi Quang"),)
              ],
            )
            )
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
              padding: const EdgeInsets.symmetric(horizontal: (8), vertical: (7)),
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

  Widget _showOrder(item){
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: InkWell(
                onTap: (){
                    //TODO: Change to detail history screen
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryDetail(order_id: item["order_id"],)));
                },
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(item["date"].toString()??""),
                  subtitle: Text("Mã hoá đơn: ${item["order_code"].toString()??""}"),
                  trailing: const Icon(
                    size: 15,
                    Icons.arrow_forward_ios_rounded,
                    color: Color.fromRGBO(152, 152, 152, 1),
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

