import 'package:flutter/material.dart';
import 'package:foody/mainScreens/address_screen.dart';
import 'package:foody/mainScreens/history_screen.dart';
import 'package:foody/mainScreens/home_screen.dart';
import 'package:foody/mainScreens/my_orders_screen.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../mainScreens/search_screen.dart';


class MyDrawer extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Header drawer
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Column(
              children: [
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Quicksand",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // const Divider(
          //   color: Colors.grey,
          //   thickness: 1,
          // ),
          _buildDrawerItem(
            icon: Icons.home,
            title: "Home",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          _buildDrawerItem(
            icon: Icons.outdoor_grill_rounded,
            title: "My Orders",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => MyOrdersScreen()));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          _buildDrawerItem(
            icon: Icons.access_time,
            title: "Order History",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => HistoryScreen()));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          _buildDrawerItem(
            icon: Icons.search,
            title: "Search",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => SearchScreen()));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          _buildDrawerItem(
            icon: Icons.add_location,
            title: "Add New Address",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => AddressScreen()));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          _buildDrawerItem(
            icon: Icons.exit_to_app,
            title: "Sign Out",
            onTap: () {
              firebaseAuth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
              });
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 25),
      leading: Icon(icon, color: Colors.black ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: "GeneralSans",
        ),
      ),
      onTap: onTap,
    );
  }

}
