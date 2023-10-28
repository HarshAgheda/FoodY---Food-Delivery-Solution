import 'dart:async';

import 'package:flutter/material.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../mainScreens/home_screen.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer(const Duration(seconds: 1), () async
    {
      // if seller is logged in already
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      //if seller is NOT logged in already
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/splash.jpg"),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Foody",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.purple[400],     //red[700],
                      fontFamily: "Quicksand",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Baseline(
                    baseline: 45,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      "Partners",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple[400],     //red[700],
                        fontFamily: "Quicksand",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Go Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,     //red[700],
                    color: Color(0XFFAB47BC),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget build(BuildContext context) {
  //   return Material(
  //     child: Container(
  //       color: Colors.white,
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //
  //             Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Image.asset("images/splash.png"),
  //             ),
  //
  //             const SizedBox(height: 10,),
  //
  //             const Padding(
  //               padding: EdgeInsets.all(18.0),
  //               child: Text(
  //                 "Go Online",
  //                 //"Expand your reach, satisfy appetites."
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.orange,
  //                   fontSize: 40,
  //                   fontFamily: "Montserrat",
  //                   letterSpacing: 3,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
