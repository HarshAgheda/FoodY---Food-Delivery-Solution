import 'package:flutter/material.dart';
import 'package:restaurant_foody/mainScreens/earnings_screen.dart';
import 'package:restaurant_foody/mainScreens/history_screen.dart';
import 'package:restaurant_foody/mainScreens/home_screen.dart';
import 'package:restaurant_foody/mainScreens/new_orders_screen.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';


class MyDrawer extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Column(
                  children: [
                    Text(
                      sharedPreferences!.getString("name")!,
                      style: const TextStyle(color: Colors.black, fontSize: 24, fontFamily: "Quicksand"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10,),
          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 8,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black,),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "GeneralSans"),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
                ),
                // const Divider(
                //   height: 8,
                //   color: Colors.grey,
                //   thickness: 2,
                // ),
                // ListTile(
                //   leading: const Icon(Icons.reorder, color: Colors.black,),
                //   title: const Text(
                //     "My Orders",
                //     style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "GeneralSans"),
                //   ),
                //   onTap: ()
                //   {
                //
                //   },
                // ),
                const Divider(
                  height: 8,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.currency_rupee, color: Colors.black,),
                  title: const Text(
                    "Earnings",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "GeneralSans"),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  EarningsScreen()));
                  },
                ),
                const Divider(
                  height: 8,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.black,),
                  title: const Text(
                    "New Orders",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "GeneralSans"),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  NewOrdersScreen()));
                  },
                ),
                const Divider(
                  height: 8,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.outdoor_grill_sharp, color: Colors.black,),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "GeneralSans"),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 8,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.black,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "GeneralSans"),
                  ),
                  onTap: ()
                  {
                    firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                    });
                  },
                ),
                const Divider(
                  height: 8,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
