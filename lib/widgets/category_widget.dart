import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  final String imgUrl, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          // fit: BoxFit.fitHeight,

          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
