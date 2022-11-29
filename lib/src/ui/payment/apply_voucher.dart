import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project1/src/services/utilities/app_url.dart';

import '../../services/api/voucher_service.dart';
import '../../services/utilities/colors.dart';

class ApplyVoucher extends StatefulWidget {
  const ApplyVoucher({Key? key}) : super(key: key);

  @override
  State<ApplyVoucher> createState() => _ApplyVoucherState();
}

class _ApplyVoucherState extends State<ApplyVoucher> {
  var box = Hive.box('userBox');

  @override
  Widget build(BuildContext context) {
    VoucherService voucherService = VoucherService();
    return SafeArea(
        child: Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(31, 29, 72, 1),
            leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () {Navigator.pop(context);},
            ),
            title: Text('Áp dụng voucher', style: TextStyle(fontSize: 20))),
          body: FutureBuilder(
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
                           return voucher(snapshot.data![index]);
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
        ));
  }

  Widget voucher(voucher){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.pop(context,{
          "id_voucher" : voucher["id_voucher"],
          "discount_price" : int.parse(voucher["discount_price"]),
          "discount_percent" : int.parse(voucher["discount_percent"]),
          "max_price" : int.parse(voucher["max_price"]),
          "min_price" : int.parse(voucher["min_price"]),
          "type_voucher" : voucher["type_voucher"],
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        width: size.width,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/product.png") , width: 100, height: 100,),
            Container(
              // alignment: Alignment.centerLeft,
              width: size.width - 220,
              child: Wrap(
                children: [
                  Text(voucher["title"].toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16)),
                  Text(voucher["content"].toString(),style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Text("Áp dụng",style: TextStyle(fontSize: 12, color: Colors.orange.shade900),),
          ],
        )
      ),
    );
  }

  Widget applyVoucher(){
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
