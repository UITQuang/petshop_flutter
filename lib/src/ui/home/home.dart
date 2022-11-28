import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project1/src/providers/cart_provider/CartProvider.dart';
import 'package:project1/src/services/api/product_service.dart';
import 'package:project1/src/services/utilities/app_url.dart';
import 'package:project1/src/ui/history/history.dart';
import 'package:project1/src/ui/membership/membership.dart';
import 'package:project1/src/ui/updateProfile/profile.dart';

import 'package:project1/src/ui/cart/Cart.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/utilities/colors.dart';
import '../category/category.dart';
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
  final f = NumberFormat("###,###.###", "tr_TR");
  var colorizeColors = [
    Colors.red,
    Colors.yellow,
    PRIMARY_COLOR,
  ];

  var colorizeTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D48),
        actions: [
          Expanded(child: searchFilter()),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Cart()));
                    },
                    icon: const Icon(Icons.shopping_bag_outlined)),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      color: SECONDARY_COLOR, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      context.watch<CartProvider>().items.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(5),
        //   child: Container(
        //     color: Colors.grey[200],
        //     height: 1.0,
        //   ),
        // ),
        titleSpacing: 10,
        automaticallyImplyLeading: true,
      ),
      body: bodyView(),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              const HeaderDrawer(),
              listDrawer(),
              footDrawer(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget bodyView() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.8, 1),
            colors: <Color>[
              PRIMARY_COLOR,
              Color(0xff3921a1),
              Color(0xff7948ce),
              Color(0xffbda3ec),
              Color(0xffc7afd5),
              Color(0xffd5bcf3),
              Color(0xffe8d8f5),
              Color(0xfff5f3f8),
            ],
            // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            carouselSlider(),
            const SizedBox(
              height: 10,
            ),
            listHotProduct(),
            listSaleProduct(),
            listPopularProduct()
          ],
        ),
      ),
    ));
  }

  Widget carouselSlider() {
    NoticeProvider noticeProvider = NoticeProvider();
    return FutureBuilder(
        future: noticeProvider.getBannerList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("");
          } else {
            int countBanner =
                int.parse(snapshot.data["count_banner"].toString());
            return CarouselSlider(
              items: [
                for (int i = 0; i < countBanner; i++)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: Image.network(
                        AppUrl.url + snapshot.data["list_banner"][i]["picture"],
                        fit: BoxFit.fill),
                  ),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.5,
                aspectRatio: 4,
                initialPage: countBanner,
              ),
            );
          }
        });
  }

  Widget listHotProduct() {
    ProductService productService = ProductService();
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          headerSlideProduct("Sản phẩm ", 'HOT '),
          FutureBuilder(
            future: productService.getProductHotList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 6; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                        ],
                      )),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 6; i++)
                          itemHotProduct(
                              snapshot.data![i]['id'],
                              AppUrl.url +
                                  snapshot.data![i]['picture'].toString(),
                              snapshot.data![i]['price'])
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget listSaleProduct() {
    ProductService productService = ProductService();
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          headerSlideProduct("Dành cho ", 'BẠN'),
          FutureBuilder(
            future: productService.getProductReduceList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 6; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                        ],
                      )),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 6; i++)
                          itemSaleProduct(
                              snapshot.data![i]['id'],
                              AppUrl.url +
                                  snapshot.data![i]['picture'].toString(),
                              snapshot.data![i]['percent_discount'])
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget headerSlideProduct(String first, String last) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 8, 5),
      child: Row(
        children: [
          Text(
            first,
            style: const TextStyle(
                color: PRIMARY_COLOR,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                last,
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
              ColorizeAnimatedText(
                last,
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            repeatForever: true,
            isRepeatingAnimation: true,
          ),
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Xem thêm",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget listPopularProduct() {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Column(
        children: [
          listFilter(),
          listProduct(),
        ],
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.3,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, bottom: 5),
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
                var mapsnapshot = Map();
                int lengthSearch = 0;
                for (int i = 0; i < snapshot.data!.length; i++) {
                  String name = snapshot.data![i]['title'];

                  if (name
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase())) {
                    mapsnapshot[lengthSearch] = snapshot.data![i];
                    lengthSearch++;
                  }
                }
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.45),
                  children: List.generate(mapsnapshot.length, (index) {
                    return itemProduct(
                      mapsnapshot[index]['id'],
                      AppUrl.url + mapsnapshot[index]['picture'].toString(),
                      mapsnapshot[index]['title'].toString(),
                      mapsnapshot[index]['price'].toString(),
                    );
                  }),
                );
              }
            }));
  }

  Widget itemHotProduct(
    int id,
    String networkImage,
    String price,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailProductScreen(
                  id: id,
                )));
        ProductService().addViewProduct('$id');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.33,
          height: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(networkImage),
                    ),
                    const Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(
                            child: Icon(
                          Icons.hotel_class_outlined,
                          color: Color(0xfffa1a1a),
                          size: 20,
                        )))
                  ],
                ),
              ),
              Text(
                f.format(int.parse(price)),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.orange,
                  fontWeight: FontWeight.w400,
                ),
              ),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.3,
                lineHeight: MediaQuery.of(context).size.width * 0.03,
                backgroundColor: Colors.red[100],
                animation: true,
                percent: 0.6,
                animationDuration: 2000,
                progressColor: Colors.red[400],
                alignment: MainAxisAlignment.center,
                center: Text(
                  'Đã bán ${id * 2}',
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                ),
                barRadius: const Radius.circular(5),
                linearStrokeCap: LinearStrokeCap.roundAll,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget itemSaleProduct(
      int id,
      String networkImage,
      String percent,
      ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailProductScreen(
              id: id,
            )));
        ProductService().addViewProduct('$id');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(networkImage),
                    ),
                     Positioned(
                        top: 0,
                        right: 0,
                     
                          child: Container(
                            height: 35,
                            width: 32,
                            decoration: const BoxDecoration(
                              gradient:   LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[

                              Colors.orangeAccent,
                              Colors.yellow,
                              Colors.yellowAccent,
                                ],
                                // Gradient from https://learnui.design/tools/gradient-generator.html
                                tileMode: TileMode.mirror,
                              ),
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                            ),
                          ),
                     ),

                    Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              shadows: [
                                Shadow(
                                  blurRadius: 7.0,
                                  color: Colors.white70,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: AnimatedTextKit(
                              pause: const Duration(milliseconds:0 ),
                              repeatForever: true,
                              isRepeatingAnimation: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                FlickerAnimatedText(' $percent%\nGiảm'),
                                FlickerAnimatedText(' $percent%\nGiảm'),
                              ],

                            ),
                          ),
                        )
                    )
                        // Center(child: Text(' $percent%\nGiảm',style: TextStyle(fontSize: 12,color: Colors.grey),)))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
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
        ProductService().addViewProduct('$id');
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                '₫' '$price',
                style: const TextStyle(
                  fontSize: 18,
                  color: SECONDARY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listFilter() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20, bottom: 8),
          child: Row(children: const [
            Text(
              "Sản phẩm phổ biến",
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(child: SizedBox()),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              itemFilter(Icons.border_all, "Tất cả"),
              itemFilter(Icons.pets_outlined, "Chó"),
              itemFilter(Icons.pets_sharp, "Mèo"),
              itemFilter(Icons.toys_outlined, "Đồ chơi")
            ],
          ),
        ),
      ],
    );
  }

  Widget itemFilter(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        searchController.clear();
        if (title != "Tất cả") {
          searchController.text = title;
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: const Color(0xffffecdf),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xfff59c89),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black87),
                  ),
                )
              ],
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
        menuItem(6, "Điểm tích lũy", Icons.card_membership_sharp,
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

          if (currentPage == DrawerSections.information) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          } else if (currentPage == DrawerSections.home) {
            Navigator.pop(context);
          } else if (currentPage == DrawerSections.history) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const History()));
          } else if (currentPage == DrawerSections.membershipCard) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MembershipPage()));
          } else if (currentPage == DrawerSections.logOut) {
            Navigator.pop(context);
          } else if (currentPage == DrawerSections.notification) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PromotionNoticePage()));
          } else if (currentPage == DrawerSections.hotline) {
            launch('tel://0853685806');
          } else if (currentPage == DrawerSections.category) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CategoryPage()));
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
      color: Colors.white,
      margin: const EdgeInsets.only(top: 50, left: 30),
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
