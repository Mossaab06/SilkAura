import 'package:e_commerce/Utils/AppLayout.dart';
import 'package:e_commerce/views/Screens/cart_page.dart';
import 'package:e_commerce/views/Screens/home_page.dart';
import 'package:e_commerce/views/Screens/message_page.dart';
import 'package:e_commerce/views/Screens/page_switcher.dart';
import 'package:e_commerce/views/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Utils/app_style.dart';
import 'core/firebase_options.dart';
import 'core/services/CartService.dart';
import 'core/services/CategoryService.dart';
import 'core/services/ExploreService.dart';
import 'core/services/MessageService.dart';
import 'core/services/NotificationService.dart';
import 'core/services/ProductService.dart';
import 'core/services/SearchService.dart';
import 'core/services/authentication.dart';
import 'core/services/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 // MaterialColor color = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> Auth()),
        ChangeNotifierProvider(create: (context)=> CategoryService()),
        ChangeNotifierProvider(create: (context)=> ProductService()),
        ChangeNotifierProvider(create: (context)=> ExploreService()),
        ChangeNotifierProvider(create: (context)=> MessageService()),
        ChangeNotifierProvider(create: (context)=> CartService()),
        ChangeNotifierProvider(create: (context)=> SearchService()),
        ChangeNotifierProvider(create: (context)=> NotificationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppPrimary
        ),
         home: WelcomePage(),
      // home: CartPage(),
      ),
    );
  }
}


