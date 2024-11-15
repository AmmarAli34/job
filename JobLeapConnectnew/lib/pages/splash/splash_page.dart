import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobleapconnectnew/pages/main/main_page/main_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {
  final Widget child;
  const SplashPage({Key? key, required this.child}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override


  void initState() {
    islogin();
    super.initState();
  }
  void islogin()async {

      SharedPreferences sp = await SharedPreferences.getInstance();
      var token = sp.getString('token');
      if(token!=null){
        Timer(Duration(seconds: 5),(){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainPage()),
                  (route) => false);
        });
      }else{
        Future.delayed(const Duration(milliseconds: 3000)).then((value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => widget.child),
                (route) => false,
          );
        });
      }

      // Navigate to MainPage only after token is stored

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linkedInWhiteFFFFFF,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 50,
              width: 50,

              image: AssetImage('images/img.png'),
            ),
            Text('JobLeap',
              style: TextStyle(fontSize: 24,
                  fontFamily: 'Rubik Medium',
                  color: Color(0xff2D3142)),
            ),
            Text('Connect',
              style: TextStyle(fontSize: 24,
                  fontFamily: 'Rubik Medium',
                  color: Color(0xffF9703B)),
            ),
          ],
        ),
      ),
    );
  }
}
