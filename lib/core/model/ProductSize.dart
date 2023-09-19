import 'package:flutter/cupertino.dart';

class ProductSize {
  num size;
  String name;

  ProductSize({required this.size, required this.name});

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
      name: json['name'],
      size: json['size'],
    );
  }
}

