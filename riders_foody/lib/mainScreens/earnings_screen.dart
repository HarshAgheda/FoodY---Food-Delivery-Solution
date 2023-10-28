import 'package:flutter/material.dart';

import '../global/global.dart';


class EarningsScreen extends StatefulWidget
{
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}




class _EarningsScreenState extends State<EarningsScreen>
{
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
                "₹ ${previousRiderEarnings!}",
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontFamily: "Quicksand"
                ),
              ),
              SizedBox(height: 25,),
              const Text(
                "Total Earnings",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand",
                ),
              ),

              const SizedBox(
                height: 20,
                width: 200,
                // child: Divider(
                //   color: Colors.white,
                //   thickness: 1.5,
                // ),
              ),

              const SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[800],
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
