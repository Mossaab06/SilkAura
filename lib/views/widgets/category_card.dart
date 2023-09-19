import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../core/model/Category.dart';
import '../../core/model/Product.dart';
import '../../core/services/CategoryService.dart';
import '../../core/services/ProductService.dart';

class CategoryCard extends StatelessWidget {
  final List<Category> data;
  final int index;
  CategoryCard({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductService>(context);
    return GestureDetector(
      onTap: () async {
        // onTap;
          for (int i = 0; i < data.length; i++) {
            if (i == index) {
              data[i].featured = true; // Make the tapped category featured
              await provider.filterProductsByName(provider.products, data[i].name );
            } else {
              data[i].featured = false; // Make other categories not featured
            }
          };



       // data[index].featured=!data[index].featured;
        },
      child: Container(
        width: 80,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          color: (data[index].featured == true) ? Colors.white.withOpacity(0.10) : Colors.transparent,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: SvgPicture.asset(
                '${data[index].iconUrl}',
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Text(
                '${data[index].name}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
