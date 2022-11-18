import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1D48),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
        brightness: Brightness.light,
        titleSpacing: 10,
        automaticallyImplyLeading: true,
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.25,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            height: (selectedIndex == index) ? 50 : 0,
                            width: 5,
                            color: Colors.blue,
                          ),
                          Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                // alignment: Alignment.center,
                                height: 50,
                                color: (selectedIndex==index)? Colors.grey:Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10,top: 10),
                              child: Text('Category $index'),
                            ),
                          )),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: 10),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
