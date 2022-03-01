// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:get/get.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ImageView extends StatelessWidget {
  ImageView({
    Key? key,
    required this.index,
    required this.imagePath,
    required this.category,
  }) : super(key: key);

  int index;
  String imagePath;
  List category;

  Color iconColor = Colors.white;
  TextStyle textStyle = TextStyle(color: Colors.white);

  Future<void> setWalpapper(int location) async {
    var file = await DefaultCacheManager().getSingleFile(imagePath);

    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  downloadImage() async {
    var file = await DefaultCacheManager().getSingleFile(imagePath);
    GallerySaver.saveImage(file.path, albumName: 'Walpapper App');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            buildWalpapperImage(),
            buildSetWalpapperWidget(context),
          ],
        ),
      ),
    );
  }

  Container buildWalpapperImage() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imagePath,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  TouchFeedback buildSetWalpapperWidget(context) {
    return TouchFeedback(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.black45,
            actions: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.screen_lock_portrait,
                  color: iconColor,
                ),
                title: Text(
                  'Home Screen',
                  style: textStyle,
                ),
                onTap: () {
                  Get.back();
                  setWalpapper(WallpaperManager.HOME_SCREEN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add_to_home_screen,
                  color: iconColor,
                ),
                title: Text(
                  'Lock Screen',
                  style: textStyle,
                ),
                onTap: () {
                  setWalpapper(WallpaperManager.LOCK_SCREEN);
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.phone_android_sharp,
                  color: iconColor,
                ),
                title: Text(
                  'Home screen and lock Screen',
                  style: textStyle,
                ),
                onTap: () {
                  setWalpapper(WallpaperManager.BOTH_SCREEN);
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                iconColor: iconColor,
                title: Text(
                  'Download',
                  style: textStyle,
                ),
                onTap: () {
                  downloadImage();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
      rippleColor: Colors.white,
      child: Container(
        height: 50,
        color: Colors.black45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.done,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Set Walpapper',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
