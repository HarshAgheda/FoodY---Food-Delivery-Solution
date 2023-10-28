import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            color: Colors.orange[600],
          ),
          automaticallyImplyLeading: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Foody",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontFamily: "Quicksand",
                ),
              ),
              SizedBox(width: 8),
              Baseline(
                baseline: 45,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  "Riders",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: "Quicksand",
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white),
                text: "Sign Up",
              ),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 4,
          ),
        ),
        body: Container(
          child: const TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}


// class _AuthScreenState extends State<AuthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           flexibleSpace: Container(
//             color: Colors.orange[600],
//           ),
//           automaticallyImplyLeading: false,
//           title: const Text(
//             "Foody",
//             style: TextStyle(
//               fontSize: 45,
//               color: Colors.white,
//               fontFamily: "Quicksand",
//             ),
//           ),
//           centerTitle: true,
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.lock,color: Colors.white,) ,
//                 text: "Login",
//               ),
//               Tab(
//                 icon: Icon(Icons.person,color: Colors.white,) ,
//                 text: "Sign Up",
//               ),
//             ],
//             indicatorColor: Colors.white,
//             indicatorWeight: 4 ,
//           ),
//         ),
//         body: Container(
//           child: TabBarView (
//             children: [
//               LoginScreen(),
//               RegisterScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }