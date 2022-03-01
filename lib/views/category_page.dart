// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walpapper_api/views/categories.dart';
import 'package:http/http.dart' as http;
import 'package:walpapper_api/views/image_view.dart';

import '../model/category_model.dart';
import '../widgets/category_widget.dart';
import 'home.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key, required this.index}) : super(key: key);

  List category = [];
  int index;



  getTrendWalpappers() async {
    final url = Uri.parse(
      'https://api.pexels.com/v1/search?per_page=100&query=${categories[index]}',
    );

    var response = await http.get(url, headers: {"Authorization": apiKey});

    Map jsonData = jsonDecode(response.body);
    category = jsonData['photos'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(categories[index]),
      ),
      body: FutureBuilder(
        future: getTrendWalpappers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scrollbar(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: category.length,
                padding: EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 2,
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  child: CategoriesWidget(
                    imgUrl: category[index]['src']['portrait'],
                    title: '',
                  ),
                  onTap: () {
                    Get.to(
                      ImageView(
                        index: index,
                        imagePath: category[index]['src']['portrait'],
                        category: category,
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
                color: Colors.grey,
                radius: 25,
              ),
            );
          }
          return Container(
            height: 70,
            color: Colors.red,
          );
        },
      ),
    );
  }
}
