import 'package:e_commerce/views/Screens/page_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/app_color.dart';
import '../../core/services/authentication.dart';



class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _isVerified = false;

  Future<void> _checkVerificationStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      setState(() {
        _isVerified = user.emailVerified;
      });

      if (_isVerified) {
        // Navigate to a success page
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageSwitcher()));

      }
    }
  }

  Future <void> verifyEmail()async {
    bool? emailVerified = await Auth().currentUser?.emailVerified;
    if  (emailVerified==false && Auth().currentUser != null) {
      // Send verification email
      Auth().currentUser?.sendEmailVerification();
      // Navigate to email verification page or show a message
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailVerificationPage()));

    }
  }


  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email Verification'),backgroundColor: AppColor.primary,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isVerified
                ? Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 80),
                SizedBox(height: 20),
                Text('Email Verified', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 80),
                SizedBox(height: 20),
                Text(
                  'Email Not Verified',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'We have sent you a verification email.\nPlease check your inbox and follow the instructions to verify your email address.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed:
                        verifyEmail,
                        // SignInWithEmailAndPassword();
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageSwitcher()));

                        child: Text(
                          'Resend Email',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'poppins'),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18), backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed:
                        _checkVerificationStatus,
                        // SignInWithEmailAndPassword();
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageSwitcher()));

                        child: Text(
                          'Refresh Status',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'poppins'),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18), backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 80),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

