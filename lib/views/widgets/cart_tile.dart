import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utils/app_color.dart';
import '../../core/model/Cart.dart';
import '../../core/services/CartService.dart';

// import 'package:pecahan_rupiah/pecahan_rupiah.dart';

class CartTile extends StatelessWidget {
  final List<Cart> cartData;
  final int index;
  final int productCount;
  CartTile({required this.cartData, required this.index, required this.productCount});
  @override
  Widget build(BuildContext context) {
     final provider =Provider.of<CartService>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 12),
      decoration: BoxDecoration(
        color: provider.selectedItems.contains(index) ?AppColor.primarySoft :Colors.white,

        //color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: AppColor.border,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: AssetImage(cartData[index].image[0]), fit: BoxFit.cover),
            ),
          ),
          // Info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${cartData[index].name}',
                      style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'poppins', color: AppColor.secondary),
                    ),
                    InkWell(
                      onTap: (){
                        provider.selectItems(index);

                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                         // color: AppColor.primarySoft,
                        ),
                        child: Icon(provider.selectedItems.contains(index) ? Icons.check_circle:Icons.check_box_outline_blank_rounded,
                          size: 24,color: Colors.black87,),
                      ),
                    )

                  ],
                ),
                // Product Price - Increment Decrement Button
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Price
                      Expanded(
                        child: Text(
                          '${cartData[index].price} \$',
                          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'poppins', color: AppColor.primary),
                        ),
                      ),

                      // Increment Decrement Button
                      Container(
                        height: 26,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.primarySoft,
                        ),
                        child: Row(
                          children: [
                            //minus
                            InkWell(
                              onTap: () {
                                print('minus');
                               // cartData[index].count--;
                                // final provider =Provider.of<CartService>(context).changeCount(index , false);
                                provider.changeCount(index , false);

                              },
                              child: Container(
                                width: 26,
                                height: 26,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.primarySoft,
                                ),
                                child: Text(
                                  '-',
                                  style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            //count
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${cartData[index].count}',
                                  style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            //plus
                            InkWell(
                              onTap: () {
                                print('plus');
                              //  cartData[index].count++;
                                provider.changeCount(index , true);
                              },
                              child: Container(
                                width: 26,
                                height: 26,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.primarySoft,
                                ),
                                child: Text(
                                  '+',
                                  style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




