import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project1/src/providers/cart_provider/CartProvider.dart';
import 'package:project1/src/services/api/product_service.dart';
import 'package:project1/src/services/utilities/app_url.dart';
import 'package:project1/src/ui/history/history.dart';
import 'package:project1/src/ui/home/profile.dart';

import 'package:project1/src/ui/cart/Cart.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/utilities/colors.dart';
import '../notice/promotion_notice.dart';
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
          Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Cart()));
                      },
                      icon: Icon(Icons.shopping_bag_outlined)),
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      color: SECONDARY_COLOR, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      context.watch<CartProvider>().items.length.toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )
            ],
          )
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
        child: SingleChildScrollView(
      child: Column(
        children: [
          carouselSlider(),
          listFilter(),
          listProduct(),
        ],
      ),
    ));
  }

  Widget carouselSlider() {
    return CarouselSlider(
      items: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Image.asset("assets/images/chovameo.jpg", fit: BoxFit.fill),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Image.asset(
            "assets/images/meo.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
        aspectRatio: 2.8,
        initialPage: 2,
      ),
    );
  }

  Widget listProduct() {
    ProductService productService = ProductService();
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder(
            future: productService.getProductList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              var mapsnapshot=new Map();
              int lengthSearch=0;
              for (int i=0; i<snapshot.data!.length;i++){
                String name = snapshot.data![i]['title'];

                if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                  mapsnapshot[lengthSearch]=snapshot.data![i];
                  lengthSearch++;

                }
              }
              if (!snapshot.hasData) {
                return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 0.8),
                    children: List.generate(10, (index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                width:
                                    MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.width * 0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5),
                                child: Container(
                                  color: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: Container(
                                  color: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.5),
                  children: List.generate(mapsnapshot.length, (index) {

                      return itemProduct(
                        mapsnapshot[index]['id'],
                        AppUrl.url +
                            mapsnapshot[index]['picture'].toString(),
                        mapsnapshot[index]['title'].toString(),
                        mapsnapshot[index]['price'].toString(),
                      );

                  }
                  // children: List.generate(snapshot.data!.length, (index) {
                  //   String name = snapshot.data![index]['title'];
                  //   if (searchController.text.isEmpty) {
                  //     return itemProduct(
                  //       snapshot.data![index]['id'],
                  //       AppUrl.url +
                  //           snapshot.data![index]['picture'].toString(),
                  //       snapshot.data![index]['title'].toString(),
                  //       snapshot.data![index]['price'].toString(),
                  //     );
                  //   } else if (name
                  //       .toLowerCase()
                  //       .contains(searchController.text.toLowerCase())) {
                  //     return itemProduct(
                  //       snapshot.data![index]['id'],
                  //       AppUrl.url +
                  //           snapshot.data![index]['picture'].toString(),
                  //       snapshot.data![index]['title'].toString(),
                  //       snapshot.data![index]['price'].toString(),
                  //     );
                  //   } else {
                  //     return Container();
                  //   }
                  // }
                  ),
                );
              }
            }));
  }

  Widget itemProduct(
    int id,
    String networkImage,
    String title,
    String price,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailProductScreen(
                  id: id,
                )));
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
                ],
              ),
              const SizedBox(
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
      mainAxisAlignment: MainAxisAlignment.center,
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
      onTap: (){
        searchController.clear();
        if(title!="Tất cả"){
          searchController.text=title;
        }
        setState(() {

        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Icon(icon), Text(title)],
            ),
          ),
        ),
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
              margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
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

  Widget listDrawer() {
    return Column(
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
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {


    return Material(
      color: selected ? Colors.grey : Colors.white,
      child: InkWell(
        onTap: () {
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

            if(currentPage==DrawerSections.information){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            }
            else if(currentPage==DrawerSections.home){
              Navigator.pop(context);
            }
            else if(currentPage==DrawerSections.history){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const History()));
            }
            else if(currentPage==DrawerSections.membershipCard){
              Navigator.pop(context);
            }
            else if(currentPage==DrawerSections.logOut){
              Navigator.pop(context);
            }
            else if(currentPage==DrawerSections.notification){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  PromotionNotice()));
            }
            else if(currentPage==DrawerSections.hotline){
              launch('tel://0853685806');
            }
else if(currentPage==DrawerSections.category){
  Navigator.pop(context);
            }



        },
        child: Padding(
          padding: const EdgeInsets.all(10),
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
