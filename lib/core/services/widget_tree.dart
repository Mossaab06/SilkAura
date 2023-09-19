import 'package:e_commerce/views/Screens/home_page.dart';
import 'package:e_commerce/views/Screens/login_page.dart';
import 'package:e_commerce/views/Screens/page_switcher.dart';
import 'package:e_commerce/views/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/authentication.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    if(auth.currentUser!=null){
          return PageSwitcher();
        } else {
          return LoginPage();

          }

  }
}
