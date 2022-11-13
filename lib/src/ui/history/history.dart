import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../services/api/order_service.dart';
import 'detail_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  var box = Hive.box('userBox');
  void initState() {
  }
  @override
  Widget build(BuildContext context) {
    OrderProvider listOrder = OrderProvider();

    return SafeArea(
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
            title: Text("Lịch sử mua hàng", style: TextStyle(fontSize: 20)),
          ),
          body: FutureBuilder(
              future: listOrder.getListOrder(box.get("id").toString()),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return Text("loading");
                }else{
                  return ListView.builder(
                      itemCount: snapshot!.data!.length,
                      itemBuilder: (context, index){
                        return _showOrder(snapshot.data![index]);
                      });
                }
              },
            ),
          )
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
                    side: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
  }
}

