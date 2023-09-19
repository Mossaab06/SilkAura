import 'dart:async';
import 'package:e_commerce/views/Screens/cart_page.dart';
import 'package:e_commerce/views/Screens/page_switcher.dart';
import 'package:e_commerce/views/Screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import '../../Utils/app_color.dart';
import '../../core/model/Category.dart';
import '../../core/model/Product.dart';
import '../../core/services/CartService.dart';
import '../../core/services/CategoryService.dart';
import '../../core/services/ProductService.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_icon_button_widget.dart';
import '../widgets/dummy_search_widget_1.dart';
import '../widgets/flashsale_countdown_tile.dart';
import '../widgets/item_card.dart';
import 'empty_cart_page.dart';
import 'message_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Timer? flashsaleCountdownTimer=null;
  Duration flashsaleCountdownDuration = Duration(
    hours: 24 - DateTime.now().hour,
    minutes: 60 - DateTime.now().minute,
    seconds: 60 - DateTime.now().second,
  );

  @override
  void initState() {
      super.initState();
      // Fetch data from the provider as soon as the app starts
      //CategoryWithProvider().fetchCategories();
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (_) {
      setCountdown();
    });
  }

  void setCountdown() {
    if (this.mounted) {
      setState(() {
        final seconds = flashsaleCountdownDuration.inSeconds - 1;

        if (seconds < 1) {
          flashsaleCountdownTimer!.cancel();
        } else {
          flashsaleCountdownDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void dispose() {
    if (flashsaleCountdownTimer != null) {
      flashsaleCountdownTimer!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String seconds = flashsaleCountdownDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String minutes = flashsaleCountdownDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String hours = flashsaleCountdownDuration.inHours
        .remainder(24)
        .toString()
        .padLeft(2, '0');

    final provider = Provider.of<CategoryService>(context);
    final categoryData = provider.categoryData;

    final provider2 =  Provider.of<ProductService>(context);
    final products = provider2.CategoryProducts;
   // final products = provider2.products;

    final provider3 =  Provider.of<CartService>(context);
    final cartData = provider3.cartData;

    return ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColor.primary
              // image: DecorationImage(
              //   image: AssetImage('assets/images/background.jpg'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 26),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find the best \noutfit for you.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          height: 150 / 100,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          CustomIconButtonWidget(
                            onTap: () {
                              if(cartData.isEmpty) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EmptyCartPage()));
                              }else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartPage()));
                              }
                            },
                            value: cartData.length,
                            icon: SvgPicture.asset(
                              'assets/icons/Bag.svg',
                              color: Colors.white,
                            ),
                          ),
                          CustomIconButtonWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                    //  PageSwitcher()
                                  MessagePage()
                              ));
                            },
                            value: 2,
                            margin: EdgeInsets.only(left: 16),
                            icon: SvgPicture.asset(
                              'assets/icons/Chat.svg',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DummySearchWidget1(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                       // PageSwitcher()
                            SearchPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Section 2 - category with provide
         Container(
              width: MediaQuery.of(context).size.width,
              color: AppColor.secondary,
              padding: EdgeInsets.only(top: 12, bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () {
                          //  CategoryService.fetchCategories();
                          //  CaPr.fetchCategories();
                            print(categoryData.isEmpty);
                           // ProductService.fetchProduct();
                          },
                          child: Text(
                            'View More',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w400),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Category list
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    height: 96,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categoryData.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 16);
                      },
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          data: categoryData,
                          index:index
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),



          // Section 3 - banner
          // Container(
          //   height: 106,
          //   padding: EdgeInsets.symmetric(vertical: 16),
          //   child: ListView.separated(
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 3,
          //     separatorBuilder: (context, index) {
          //       return SizedBox(width: 16);
          //     },
          //     itemBuilder: (context, index) {
          //       return Container(
          //         width: 230,
          //         height: 106,
          //         decoration: BoxDecoration(color: AppColor.primarySoft, borderRadius: BorderRadius.circular(15)),
          //       );
          //     },
          //   ),
          // ),

          // Section 4 - Flash Sale

          // flash sale with provider
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Flash Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: hours[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: hours[1],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: minutes[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: minutes[1],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: seconds[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: seconds[1],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 310,
                        child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            products.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemCard(
                                    product: products[index],
                                    titleColor: AppColor.primarySoft,
                                    priceColor: AppColor.accent,
                                  ),
                                  Container(
                                    width: 180,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: LinearProgressIndicator(
                                                minHeight: 10,
                                                value: 0.4,
                                                color: AppColor.accent,
                                                backgroundColor:
                                                    AppColor.border,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.local_fire_department,
                                          color: AppColor.accent,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         color: Colors.amber,
                                  //         height: 10,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Section 5 - product list Provider

          Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Todays recommendation...',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                products.length,
                (index) => ItemCard(
                  product: products[index],
                ),
              ),
            ),
          )
        ],
    );
  }
}
