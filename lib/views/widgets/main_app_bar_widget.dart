import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Utils/app_color.dart';
import '../../core/services/CartService.dart';
import '../Screens/cart_page.dart';
import '../Screens/empty_cart_page.dart';
import '../Screens/message_page.dart';
import '../Screens/search_page.dart';
import 'custom_icon_button_widget.dart';
import 'dummy_search_widget2.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int cartValue;
  final int chatValue;

  MainAppBar({
    required this.cartValue,
    required this.chatValue,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartService>(context);
    final cartData = provider.cartData;
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColor.primary,
      elevation: 0,
      title: Row(
        children: [
          DummySearchWidget2(
            onTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage(),),);
            },
          ),
          CustomIconButtonWidget(
            onTap: (){
              if(cartData.isEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EmptyCartPage()));
              }else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartPage()));
              }
            },
            value: widget.cartValue,
            margin: EdgeInsets.only(left: 16),
            icon: SvgPicture.asset(
              'assets/icons/Bag.svg',
              color: Colors.white,
            ),
          ),
          CustomIconButtonWidget(
            onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagePage()));
                },

            value: widget.chatValue,
            margin: EdgeInsets.only(left: 16),
            icon: SvgPicture.asset(
              'assets/icons/Chat.svg',
              color: Colors.white,
            ),
          ),
        ],
      ), systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
