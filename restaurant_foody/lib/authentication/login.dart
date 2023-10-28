import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_foody/authentication/auth_screen.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //login
      loginNow();
    }
    else
    {
      showDialog(
        context: context,
        builder: (c)
        {
          return ErrorDialog(
            message: "Please fill in both email and password fields.",
          );
        }
      );
    }
  }


  // loginNow() async {
  //   showDialog(
  //     context: context,
  //     builder: (c) {
  //       return LoadingDialog(
  //         message: "Checking credentials",
  //       );
  //     },
  //   );
  //
  //   User? currentUser;
  //   try {
  //     final authResult = await firebaseAuth.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //     currentUser = authResult.user!;
  //
  //     if (currentUser != null) {
  //       await readDataAndSetDataLocally(currentUser);
  //
  //     }
  //   } catch (error) {
  //     Navigator.pop(context);
  //     String errorMessage = "An error occurred. Please try again.";
  //
  //     if (error is FirebaseAuthException) {
  //       if (error.code == 'user-not-found' || error.code == 'wrong-password') {
  //         errorMessage = "Invalid email or password. Please check your credentials.";
  //       }
  //     }
  //
  //     showDialog(
  //       context: context,
  //       builder: (c) {
  //         return ErrorDialog(
  //           message: errorMessage,
  //         );
  //       },
  //     );
  //   }
  // }

  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Checking credentials",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null)
    {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
          if(snapshot.exists) {
            await sharedPreferences!.setString("uid", currentUser.uid);
            await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
            await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
            await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          }
          else
          {
            firebaseAuth.signOut();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
            showDialog(
              context: context,
              builder: (c) {
                return ErrorDialog(
                  message: "No record found",
                );
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObsecre: true,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }

}

