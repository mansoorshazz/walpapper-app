import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:walpapper_api/model/category_model.dart';
import 'package:walpapper_api/views/categories.dart';
import 'package:walpapper_api/views/category_page.dart';
import 'package:walpapper_api/views/image_view.dart';

import '../widgets/category_widget.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  List? walpappers;

  getTrendWalpappers() async {
    final url = Uri.parse(
      'https://api.pexels.com/v1/search?per_page=100&query=coding',
    );

    var response = await http.get(url, headers: {"Authorization": apiKey});

    Map jsonData = jsonDecode(response.body);
    walpappers = jsonData['photos'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          key: key,
          semanticLabel: 'Mansoor',
          backgroundColor: Colors.black.withOpacity(0.5),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'CATEGORIES',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Get.to(
                          CategoryPage(index: index),
                        );
                      },
                      title: Text(
                        categories[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 0,
                    ),
                    itemCount: categories.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Walpapper app'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getTrendWalpappers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Scrollbar(
                    child: GridView.builder(
                      itemCount: walpappers!.length,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.3 / 2.2,
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        child: CategoriesWidget(
                          imgUrl: walpappers![index]['src']['portrait'],
                          title: '',
                        ),
                        onTap: () {
                          Get.to(
                            ImageView(
                              index: index,
                              imagePath: walpappers![index]['src']['portrait'],
                              category: [],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                      color: Colors.grey,
                      radius: 25,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }

  SizedBox buildCategories() {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 12, right: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoriesWidget(
          imgUrl:
              'https://www.shaadidukaan.com/vogue/wp-content/uploads/2019/08/hug-kiss-images.jpg',
          title: 'Photography',
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        itemCount: 10,
      ),
    );
  }

  Padding buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: TextField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
          fillColor: Colors.grey,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Search',
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
