
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Category.dart';
import 'package:get/route_manager.dart';

class CategoryService extends ChangeNotifier {
  CategoryService() {
   // This is similar to an "initState"
   fetchCategories();
 }

 List<Category> categoryData = [];
  fetchCategories() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final snapshot = await _firestore.collection('Categories').doc('njLVZNSaUqYOWZphKDaL').get();
    final data = snapshot.data();
    data!.forEach((key, value) {
      categoryData.add(Category.fromJson(value));
    });
    categoryData.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

}




class CategoryServicesssss {
  static List<Category> categoryData = categoryRawData.map((data) => Category.fromJson(data)).toList();
}

var categoryRawData = [
  {
      'featured': true,
    'icon_url': 'assets/icons/Discount.svg',
    'name': 'best offer',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/High-heels.svg',
    'name': 'woman shoes',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Woman-dress.svg',
    'name': 'woman dress',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Clothes.svg',
    'name': 'man clothes',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Pants.svg',
    'name': 'man pants',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Shoes.svg',
    'name': 'man shoes',
  },
];
