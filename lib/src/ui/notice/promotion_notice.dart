import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/api/product_service.dart';
import '../../services/utilities/colors.dart';

class PromotionNoticePage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var box = Hive.box('userBox');

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
                // title: const Text("Thông báo", style: TextStyle(fontSize: 20)),
                bottom: const TabBar(
                  tabs: <Widget>[
                    Text(
                      "Khuyến mãi",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      "Hệ thống",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                  indicatorWeight: 4,
                  indicatorColor: Color.fromRGBO(200, 198, 239, 1.0),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  listNoticeSale(),
                  listNoticeRefund(box.get("id").toString())
                ],
              ))),
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
                      onChanged: (value) {},
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

  Widget listNoticeRefund(String id) {
    NoticeProvider noticeProvider = NoticeProvider();

    return Center(
      child: FutureBuilder(
        future: noticeProvider.getNoticeRefund(id.toString()),
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
            print(snapshot.data!.length);
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _showNotice(context, snapshot.data![index]);
                });
          }
        },
      ),
    );
  }

  Widget listNoticeSale() {
    NoticeProvider noticeProvider = NoticeProvider();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FutureBuilder(
        future: noticeProvider.getNoticeList(),
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
            return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _showNotice(context, snapshot.data![index]);
                });
          }
        },
      ),
    );
  }

  Widget _showNotice(context, item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(
              item['title'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["content"].toString()),

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
    );
  }
}
