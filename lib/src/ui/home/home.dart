import 'package:flutter/material.dart';
import 'package:project1/src/services/api/product_service.dart';
import 'package:project1/src/services/utilities/app_url.dart';

import '../../services/utilities/colors.dart';
import '../product/detail_product.dart';
import 'header_drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  TextEditingController searchController = TextEditingController();
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D48),
        actions: [
          Expanded(child: searchFilter()),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.shopping_bag_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
        titleSpacing: 10,
        automaticallyImplyLeading: true,
      ),
      body: bodyView(),
      drawer: Drawer(
        child: Container(
            child: Column(
          children: [
            const HeaderDrawer(),
            listDrawer(),
            footDrawer(),
          ],
        )),
      ),
    );
  }

  Widget bodyView() {
    return SafeArea(
        child: Column(
      children: [
        listFilter(),
        const Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            "Mới nhất",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        listProduct(),
      ],
    ));
  }

  Widget listProduct() {
    ProductService productService = ProductService();

    return Expanded(
        child: FutureBuilder(
            future: productService.getProductList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text("khong co gi ca"),
                      );
                    });
              } else {
                var size = MediaQuery.of(context).size;
                final double itemHeight =
                    (size.height - kToolbarHeight - 24) / 2;
                final double itemWidth = size.width / 2;
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  children: List.generate(snapshot.data!.length, (index) {
                    return itemProduct(
                      AppUrl.url + snapshot.data![index]['picture'].toString(),
                      snapshot.data![index]['title'].toString(),
                      snapshot.data![index]['price'].toString(),
                    );
                  }),
                );
              }
            }));
  }

  Widget itemProduct(
    String networkImage,
    String title,
    String price,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailProductScreen()));
        print(title + ':$price đồng');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image(
                  image: NetworkImage(networkImage),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    '₫' '$price',
                    style: const TextStyle(
                      fontSize: 18,
                      color: SECONDARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  // Text(
                  //   '₫' '$price+$price*10%',
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.w200,
                  //       fontSize: 20,
                  //       decoration: TextDecoration.lineThrough),
                  // )
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listFilter() {
    return Row(
      children: [
        itemFilter(Icons.border_all, "Tất cả"),
        itemFilter(Icons.pets_outlined, "Chó"),
        itemFilter(Icons.pets_sharp, "Mèo"),
        itemFilter(Icons.toys, "Đồ chơi")
      ],
    );
  }

  Widget itemFilter(IconData icon, String title) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Icon(icon), Text(title)],
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget searchFilter() {
    return Padding(
      padding: EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 0, 5),
              // height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFF9F9FB),
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(horizontal: (8), vertical: (7)),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: (12),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Tìm kiếm sản phẩm",
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

  Widget listDrawer() {
    return Container(
      child: Column(
        children: [
          menuItem(1, "Trang chủ", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Danh mục sản phẩm", Icons.list,
              currentPage == DrawerSections.category ? true : false),
          menuItem(3, "Thông báo", Icons.notifications,
              currentPage == DrawerSections.notification ? true : false),
          menuItem(4, "Lịch sử mua hàng", Icons.history,
              currentPage == DrawerSections.history ? true : false),
          menuItem(5, "Thông tin thành viên", Icons.account_circle,
              currentPage == DrawerSections.information ? true : false),
          menuItem(6, "Thẻ thành viên", Icons.card_membership_sharp,
              currentPage == DrawerSections.membershipCard ? true : false),
          menuItem(7, "Đăng xuất", Icons.logout,
              currentPage == DrawerSections.logOut ? true : false),
          menuItem(8, "Hotline", Icons.phone,
              currentPage == DrawerSections.hotline ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey : Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.category;
            } else if (id == 3) {
              currentPage = DrawerSections.notification;
            } else if (id == 4) {
              currentPage = DrawerSections.history;
            } else if (id == 5) {
              currentPage = DrawerSections.information;
            } else if (id == 6) {
              currentPage = DrawerSections.membershipCard;
            } else if (id == 7) {
              currentPage = DrawerSections.logOut;
            } else if (id == 8) {
              currentPage = DrawerSections.hotline;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(flex: 1, child: Icon(icon)),
              Expanded(flex: 3, child: Text(title))
            ],
          ),
        ),
      ),
    );
  }

  Widget footDrawer() {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(top: 50, left: 30),
      child: Column(
        children: const [
          Text(
            "Thông tin liên hệ:",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Số điện thoại: 0853685806",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Email: mewmewpetshop@.gmail.com",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Địa chỉ: KTX khu B, TP Thủ Đức, TP HCM",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

enum DrawerSections {
  home,
  category,
  notification,
  history,
  information,
  membershipCard,
  logOut,
  hotline,
}
