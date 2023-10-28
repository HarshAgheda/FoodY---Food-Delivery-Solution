import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/error_dialog.dart';
import '../widgets/progress_bar.dart';

class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({Key? key}) : super(key: key);

  @override
  _MenusUploadScreenState createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.purple[400],
        ),
        title: const Text(
          "Add Menus",
          style: TextStyle(fontSize: 23, fontFamily: "GeneralSans"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fastfood,
              color: Colors.black26,
              size: 125,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    takeImage(context);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: MediaQuery.of(context).size.width - 200,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Add Menu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Quicksand",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Menu Image",
            style: TextStyle(color: Colors.black, fontFamily: "GeneralSans"),
          ),
          children: [
            SimpleDialogOption(
              onPressed: captureImageWithCamera,
              child: const Row(
                children: [
                  Icon(Icons.camera_alt, size: 20, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Capture with Camera",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: "Quicksand"),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Row(
                children: [
                  Icon(Icons.photo, size: 20, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Select from Gallery",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: "Quicksand"),
                  ),
                ],
              ),
            ),
            // SimpleDialogOption(
            //   child: Container(
            //     color: Colors.red.withOpacity(0.2),
            //     child: const Center(
            //       heightFactor: 1,
            //       child: Text(
            //       "Cancel",
            //       style: TextStyle(color: Colors.red,fontFamily: "Quicksand"),
            //     ),
            //     ),
            //   ),
            //   onPressed: ()=> Navigator.pop(context),
            // ),
            SimpleDialogOption(

              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 70.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // width: MediaQuery.of(context).size.width - 200,
                    height: 25,
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                           fontSize: 16,
                          fontFamily: "Quicksand",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  captureImageWithCamera() async {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      //for real time state updation (for stateful widget)
      imageXFile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  menusUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: const Text(
          "New Menu",
          style: TextStyle(fontSize: 25, fontFamily: "GeneralSans"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            clearMenusUploadForm();
          },
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : () => validateUploadForm(),
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: "GeneralSans",
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const SizedBox(),
          const SizedBox(height: 20,),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,

                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                      image: FileImage(File(imageXFile!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          _buildTextFieldWithIcon(
            icon: Icons.title,
            hintText: "Menu Title",
            controller: titleController,
          ),
          const SizedBox(height: 10.0),
          _buildTextFieldWithIcon(
            icon: Icons.info_outline,
            hintText: "Short Info",
            controller: shortInfoController,
          ),
        ],
      ),

    );
  }

  Widget _buildTextFieldWithIcon({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
  }) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                icon,
                color: Colors.purple[200],
                size: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black, fontFamily: "Quicksand",fontSize: 18),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(color: Colors.grey,fontFamily: "Quicksand",fontSize: 18),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  clearMenusUploadForm() {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        //upload image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        //save info to firestore
        saveInfo(downloadUrl);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Please write title and info for menu.",
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please pick an image for menu.",
            );
          });
    }
  }

  saveInfo(String downloadUrl) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    });

    clearMenusUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("menus");

    storageRef.UploadTask uploadTask =
        reference.child("$uniqueIdName.jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
  }
}
