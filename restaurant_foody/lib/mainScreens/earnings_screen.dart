import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_foody/mainScreens/home_screen.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';


class EarningsScreen extends StatefulWidget
{
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}


class _EarningsScreenState extends State<EarningsScreen>
{
  double sellerTotalEarnings = 0;

  retrieveSellerEarnings() async
  {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
      setState(() {
        sellerTotalEarnings = double.parse(snap.data()!["earnings"].toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();

    retrieveSellerEarnings();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "₹ $sellerTotalEarnings",
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontFamily: "Quicksand"
                ),
              ),

              const Text(
                "Total Earnings",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                ),
              ),

              // const SizedBox(
              //   height: 20,
              //   width: 250,
              //   child: Divider(
              //     color: Colors.white,
              //     thickness: 1.5,
              //   ),
              // ),

              const SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child:const Center(
                        child: Text(
                          "Go Back",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Quicksand"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
