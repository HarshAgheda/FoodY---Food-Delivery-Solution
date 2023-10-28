import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../assistantMethods/assistant_methods.dart';
import '../global/global.dart';
import '../widgets/error_dialog.dart';
import 'home_screen.dart';

class PlacedOrderScreen extends StatefulWidget {
  String? addressID;
  double? totalAmount;
  String? sellerUID;
  final DateTime? selectedDateTime;
  final DateTime? selectedEndDate;

  PlacedOrderScreen({
    this.sellerUID,
    this.totalAmount,
    this.addressID,
    this.selectedDateTime,
    this.selectedEndDate,
  });

  @override
  _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  @override
  void initState() {
    super.initState();
    // Call the function when the page loads
    getImgURL();
  }
  bool isOnlinePayment = false;
  String  paymentMode = "";
  String? otp;
  String? QRimageUrl;
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  String generateOTP() {
    // Define the length of the OTP (e.g., 4 digits)
    const otpLength = 4;

    // Generate a random OTP using digits (0-9)
    final random = Random();
    final otp =
        List.generate(otpLength, (index) => random.nextInt(10)).join('');

    return otp;
  }

  XFile? paymentProofImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage() async {
    paymentProofImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      paymentProofImage;
    });
  }

  Future<void> formValidation() async {
    if (paymentProofImage == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please select an image.",
            );
          });
    } else {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("orders").child(fileName);
        fStorage.UploadTask uploadTask = reference.putFile(File(paymentProofImage!.path));
        fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String url = await taskSnapshot.ref.getDownloadURL();
        setState(() {
          paymentMode = url; // Update paymentMode with the URL
          print(paymentMode);
        });
        // Continue with saving other details
      } catch (error) {
        print("Error uploading image and getting URL: $error");
        // Handle the error as needed
      }
      addOrderDetails();

      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      // fStorage.Reference reference = fStorage.FirebaseStorage.instance
      //     .ref()
      //     .child("orders")
      //     .child(fileName);
      // fStorage.UploadTask uploadTask =
      //     reference.putFile(File(paymentProofImage!.path));
      // fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      // await taskSnapshot.ref.getDownloadURL().then((url) {                           //TODO-------------------------
      //   setState(() {
      //     paymentMode = url;
      //     print(paymentMode);// Update paymentMode if online payment is selected
      //   });
      //   // Continue with saving other details
      // });

    }
  }

  // Replace with your OTP
  getImgURL()
  {
    FirebaseFirestore.instance.collection("sellers").doc(widget.sellerUID).get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        QRimageUrl= data["QR"];
        // print("OTP: $originalOTP");
      } else {
        print("Document does not exist");
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }

  addOrderDetails() {
    otp = generateOTP();
    writeOrderDetailsForUser({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": paymentMode,
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
      "DeliveryDandT":
          DateFormat("dd/MM/yyyy HH:mm").format(widget.selectedDateTime!),
      if (widget.selectedEndDate != null)
        "DeleveryEndDate":
            DateFormat("dd/MM/yyyy").format(widget.selectedEndDate!),
      "OTP": otp
    });

    writeOrderDetailsForSeller({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": paymentMode,
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
      "DeliveryDandT":
          DateFormat("dd/MM/yyyy HH:mm").format(widget.selectedDateTime!),
      if (widget.selectedEndDate != null)
        "DeleveryEndDate":
            DateFormat("dd/MM/yyyy").format(widget.selectedEndDate!),
      "OTP": otp,
    }).whenComplete(() {
      clearCartNow(context);
      setState(() {
        orderId = "";
        Fluttertoast.showToast(msg: "Order has been placed successfully!");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Place order now ?",
                style: TextStyle(
                  fontFamily: "GeneralSans",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              Image.asset("images/thumbsup.jpg"),

              const SizedBox(
                height: 12,
              ),

              // Radio button for Cash on Delivery
              ListTile(
                title: const Text("Cash on Delivery",style: TextStyle(fontFamily: "Quicksand",fontSize: 18),),
                leading: Radio(
                  value: false,
                  groupValue: isOnlinePayment,
                  onChanged: (value) {
                    setState(() {
                      isOnlinePayment = value!;
                    });
                  },
                ),
              ),

              // Radio button for Online Payment
              ListTile(
                title: const Text("Online Payment",style: TextStyle(fontFamily: "Quicksand",fontSize: 18),),
                leading: Radio(
                  value: true,
                  groupValue: isOnlinePayment,
                  onChanged: (value) {
                    setState(() {
                      isOnlinePayment = value!;
                    });
                  },
                ),
              ),
// Replace the InkWell and CircleAvatar with a FlatButton or ElevatedButton
              // ElevatedButton(
              //   onPressed: () {
              //     _getImage(); // Call your method for image selection here
              //   },
              //   child: Column(
              //     children: [
              //       if (paymentProofImage != null)
              //         Image.file(
              //           File(paymentProofImage!.path),
              //           width: MediaQuery.of(context).size.width * 0.30,
              //           height: MediaQuery.of(context).size.width * 0.30,
              //           fit: BoxFit.cover,
              //         ),
              //       // Icon(
              //       //   Icons.add_photo_alternate,
              //       //   size: MediaQuery.of(context).size.width * 0.10,
              //       //   color: Colors.grey,
              //       // ),
              //       const SizedBox(height: 8),
              //       const Text(
              //         "Add Payment Screenshot",
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ],
              //   ),
              // )
              const SizedBox(
                height: 15,
              ),
              if (isOnlinePayment == true)
                paymentProofImage == null
                    ? Column(
                      children: [
                        QRimageUrl!=null ? Image.network(
                          QRimageUrl!,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.cover,
                        ):Container(),
                        const SizedBox(height: 20,),
                        InkWell(
                            onTap: () {
                              _getImage();
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              child: const Text(
                                "Add Payment Screenshot",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                    : Image.file(
                        File(paymentProofImage!.path),
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.width * 0.48,
                        fit: BoxFit.cover,
                      )
              else
                Container(),
              const SizedBox(
                height: 20,
              ),
              // InkWell(
              //   onTap: () {
              //     _getImage();
              //   },
              //   child: CircleAvatar(
              //     radius: MediaQuery
              //         .of(context)
              //         .size
              //         .width * 0.15,
              //     backgroundColor: Colors.white,
              //     backgroundImage: paymentProofImage == null ? null : FileImage(
              //         File(paymentProofImage!.path)),
              //     child: paymentProofImage == null
              //         ?
              //     Icon(
              //       Icons.add_photo_alternate,
              //       size: MediaQuery
              //           .of(context)
              //           .size
              //           .width * 0.10,
              //       color: Colors.grey,
              //     ) : null,
              //   ),
              // ):Container(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // if (isOnlinePayment) {
                  // Handle online payment logic here
                  // Set isOnlinePayment to true if online payment is selected

                  //  set string to COD otherwise
                  //TODO------------------------------SHOW QR
                  // InkWell(
                  //   onTap: ()
                  //   {
                  //     _getImage();
                  //   },
                  //   child: CircleAvatar(
                  //     radius: MediaQuery.of(context).size.width * 0.15,
                  //     backgroundColor: Colors.white,
                  //     backgroundImage: paymentProofImage==null ? null : FileImage(File(paymentProofImage!.path)),
                  //     child: paymentProofImage == null
                  //         ?
                  //     Icon(
                  //       Icons.add_photo_alternate,
                  //       size: MediaQuery.of(context).size.width * 0.10,
                  //       color: Colors.grey,
                  //     ) : null,
                  //   ),
                  // );
                  // }
                  // addOrderDetails();
                  formValidation();
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 105, vertical: 14),
                  child: const Text(
                    "Yes!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Quicksand",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 73, vertical: 14),
                  child: const Text(
                    "No, Go Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Quicksand",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
// Widget build(BuildContext context)
// {
//   return Material(
//     child: Container(
//       // decoration: const BoxDecoration(
//       //   color: Colors.orange,
//       // ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("Place order now ?",
//           style: TextStyle(
//             fontFamily: "GeneralSans",
//             fontSize: 30,
//           fontWeight: FontWeight.bold,
//             color: Colors.purple,
//           )),
//           Image.asset("images/thumbsup.jpg"),
//
//           const SizedBox(height: 12,),
//
//           InkWell(
//             onTap: () {
//               addOrderDetails() ;
//             },
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 105, vertical: 14),
//               child: const Text(
//                 "Yes!",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: "Quicksand",
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.redAccent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 73, vertical: 14),
//               child: const Text(
//                 "No, Go Back",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: "Quicksand",
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
