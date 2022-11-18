import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/api/product_service.dart';
import '../../services/utilities/app_url.dart';
import '../../services/utilities/colors.dart';
import '../product/detail_product.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  PageController _pageController = PageController();
  int selectedIndex = 0;
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D48),

        brightness: Brightness.light,
        titleSpacing: 10,
        automaticallyImplyLeading: true,
        title: const Text("Danh mục sản phẩm"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:0),
        child: FutureBuilder(

            future: productService.getCategoryList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ListView.separated(
                              itemCount: 5,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 5,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(0)),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.width *
                                          0.15,
                                    ));
                              },
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              for (int i = 0; i < 8; i++)
                                GridView.count(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  crossAxisCount: 2,
                                  childAspectRatio: (1 / 1.5),
                                  children: List.generate(10, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, left: 8, right: 8),
                                      child: Container(
                                        color: Colors.grey,
                                      ),
                                    );
                                  }),
                                )
                            ],
                          )))
                        ],
                      )),
                );
              } else {
                final pageNumber = snapshot.data!.length;
                return Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 0,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                _pageController.jumpToPage(index);
                              });
                            },
                            child: Container(
                              color: Colors.grey[50],
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    
                                    duration: const Duration(
                                      milliseconds: 100,
                                    ),
                                    decoration: BoxDecoration(
                                        color: PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    height: (selectedIndex == index)
                                        ? MediaQuery.of(context).size.width * 0.15
                                        : 0,
                                    width: 5,

                                  ),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      color: (selectedIndex != index)
                                          ? Colors.grey[300]
                                          : Colors.transparent,
                                      borderRadius: (selectedIndex == index - 1)
                                          ? const BorderRadius.only(
                                              topRight: Radius.circular(30))
                                          : (selectedIndex == index + 1)
                                              ? const BorderRadius.only(
                                                  bottomRight: Radius.circular(30))
                                              : const BorderRadius.only(
                                                  topRight: Radius.circular(0)),
                                    ),
                                    // duration: const Duration(
                                    //   milliseconds: 500,
                                    // ),
                                    // alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.width * 0.15,

                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, top: 10, left: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data![index]['title']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: (selectedIndex==index)?15:14.5,
                                            color: (selectedIndex==index)?PRIMARY_COLOR:Colors.black54,

                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                          for (int i = 0; i < pageNumber; i++)
                            GridView.count(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1.5),
                          children: List.generate(
                              snapshot.data![i]['products'].length, (index) {
                            return itemProduct(
                              int.parse(snapshot.data![i]['products'][index]
                                  ['item_id']),
                              AppUrl.url +
                                  snapshot.data![i]['products'][index]
                                          ['picture']
                                      .toString(),
                              snapshot.data![i]['products'][index]['title']
                                  .toString(),
                              snapshot.data![i]['products'][index]['price']
                                  .toString(),
                            );
                          }),
                            )
                      ],
                    ),
                        ))
                  ],
                );
              }
            }),
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
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
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
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
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
            ],
          ),
        ),
      ),
    );
  }
}
