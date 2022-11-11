import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../services/api/product_service.dart';
import '../../services/utilities/colors.dart';


class PromotionNotice extends StatelessWidget {
  var title;

  PromotionNotice({this.title = 'Thông báo'});
  @override
  Widget build(BuildContext context) {
    NoticeProvider noticeProvider = NoticeProvider();

    // TODO: implement build
    //var size = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color.fromRGBO(31, 29, 72, 1),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(title, style: TextStyle(fontSize: 20)),
          ),
          body:  FutureBuilder(
              future: noticeProvider.getNoticeList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return Text("loading");
                }else{
                  return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index){
                        return _showNotice(context, snapshot.data![index]);
                      });
                }
              },
            ),
          )
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // Add your onPressed code here!
          //   },
          //   backgroundColor: PRIMARY_COLOR,
          //   child: const Icon(Icons.chat),
          // ),
        );
  }
  Widget _showNotice (context, item){

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10 ),
            child: ListTile(
                title:  Text(item!["title"].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),),
                subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(item!["content"].toString()),
                      SizedBox(height: 10,),
                      Text(item!["date_updated"].toString()),
                    ],
                  ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: horizon_color,
            height: 1,
          )
        ],
      )
    );
  }
}


