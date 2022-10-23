import 'package:flutter/material.dart';

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
        actions: const [Icon(Icons.notification_add_outlined)],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
        titleSpacing: 10,
        automaticallyImplyLeading: true,
        title: Text('Trang chủ'),
      ),
      body: searchFillter(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [HeaderDrawer(), ListDrawer()],
          )),
        ),
      ),
    );
  }

  Widget searchFillter() {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFF9F9FB),
                  border: Border.all(color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: (8), vertical: (7)),
              child: Row(
                children: [
                  const Icon(Icons.search_outlined),
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
                            fontSize: 18,
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
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: Icon(Icons.filter_list),
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

  Widget ListDrawer() {
    return Container(
      padding: EdgeInsets.only(top: 15),
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
