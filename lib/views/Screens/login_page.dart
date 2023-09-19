import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/Screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../core/services/authentication.dart';

import '../../Utils/app_color.dart';
import 'page_switcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  String? errorMessage ='';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // Future<void> SignInWithEmailAndPassword() async {
  //   try{
  //     await Auth().signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
  //
  //   } on FirebaseAuthException catch (e){
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Sign in', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
        leading: IconButton(
          onPressed: () {
           // SignInWithEmailAndPassword();
           // Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColor.secondary.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have an account?',
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' Sign up',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 24),
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Header
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 12),
            child: Text(
              'Welcome Back Mate ! 😁',
              style: TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.w700,
                fontFamily: 'poppins',
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 32),
            child: Text(
              'Please sign in to continue.',
              style: TextStyle(color: AppColor.secondary.withOpacity(0.7), fontSize: 12, height: 150 / 100),
            ),
          ),
          // Section 2 - Form
          // Email
          TextField(
            controller: _controllerEmail,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'youremail@email.com',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Message.svg', color: AppColor.primary),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primarySoft,
              filled: true,
            ),
          ),
          SizedBox(height: 16),
          // Password
          TextField(
            controller: _controllerPassword,
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: '**********',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Lock.svg', color: AppColor.primary),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primarySoft,
              filled: true,
              //
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/Hide.svg', color: AppColor.primary),
              ),
            ),
          ),
          SizedBox(height: 10,),
          //errorMessage
          Text(errorMessage == ''? '' : 'humm ? $errorMessage'),
          // Forgot Passowrd
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password ?',
                style: TextStyle(fontSize: 12, color: AppColor.secondary.withOpacity(0.5), fontWeight: FontWeight.w700),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary.withOpacity(0.1),
              ),
            ),
          ),
          // Sign In button
          ElevatedButton(
            onPressed: () async {
              // Navig
             auth.signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
              final error = await auth.signInWithEmailAndPassword(
                email: _controllerEmail.text,
                password: _controllerPassword.text,
              );
              if (error != null) {
                // Display or handle the error message
                setState(() {
                  errorMessage = error;

                });
              }
            },
            child: Text(
              'Sign in',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'poppins'),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18), backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
