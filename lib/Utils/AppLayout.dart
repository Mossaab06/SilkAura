
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class AppLayout {
  static getScreenHeight() {
    return Get.height;
  }

  static getSceenWidth() {
    return Get.width;
  }

  static getHeight(double pixels) {
    double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static getWidth(double pixels) {
    double x = getSceenWidth() / pixels;
    return getSceenWidth() / x;
  }


}