import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riders_foody/mainScreens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../assistantMethods/get_current_location.dart';
import '../global/global.dart';
import '../maps/map_utils.dart';

class ParcelDeliveringScreen extends StatefulWidget {
  String? purchaserId;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;
  String? sellerId;
  String? getOrderId;

  ParcelDeliveringScreen({
    this.purchaserId,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
    this.sellerId,
    this.getOrderId,
  });

  @override
  _ParcelDeliveringScreenState createState() => _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen> {

  //declaring vars
  String orderTotalAmount = "";
  bool isOtpVerified = false;
  TextEditingController otpController = TextEditingController();
  String? originalOTP;

  String getEnteredOTP() {
    String enteredOTP = '';
    for (int i = 0; i < otpControllers.length; i++) {
      enteredOTP += otpControllers[i].text;
    }
    return enteredOTP;
  }

  // Fetching OTP from Firebase
  void getOTP() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        originalOTP = data["OTP"];
        print("OTP: $originalOTP");
      } else {
        print("Document does not exist");
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }

  void verifyOTP() {
    getOTP();
    String enteredOTP = getEnteredOTP();
    if (enteredOTP == originalOTP) {
      // OTP is verified, enable the button
      setState(() {
        isOtpVerified = true;
      });
    } else {
      // Show an error or prompt the rider to enter the correct OTP
      // You can display a message or show a snackbar here.
      Fluttertoast.showToast(
        msg: "Incorrect OTP. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, // You can change the position
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  confirmParcelHasBeenDelivered(getOrderId, sellerId, purchaserId,
      purchaserAddress, purchaserLat, purchaserLng) {

    // Updating rider earnings
    String riderNewTotalEarningAmount = ((double.parse(previousRiderEarnings)) +
            double.parse(perParcelDeliveryAmount))
        .toString();

    FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
      "status": "ended",
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
      "earnings": perParcelDeliveryAmount, //pay per parcel delivery amount
    }).then((value) {
      FirebaseFirestore.instance
          .collection("riders")
          .doc(sharedPreferences!.getString("uid"))
          .update({
        "earnings": riderNewTotalEarningAmount, //total earnings amount of rider
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection("sellers")
          .doc(widget.sellerId)
          .update({
        "earnings":
            (double.parse(orderTotalAmount) + (double.parse(previousEarnings)))
                .toString(), //total earnings amount of seller
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(purchaserId)
          .collection("orders")
          .doc(getOrderId)
          .update({
        "status": "ended",
        "riderUID": sharedPreferences!.getString("uid"),
      });
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const HomeScreen()));
  }

  getOrderTotalAmount() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get()
        .then((snap) {
      orderTotalAmount = snap.data()!["totalAmount"].toString();
      widget.sellerId = snap.data()!["sellerUID"].toString();
    }).then((value) {
      getSellerData();
    });
  }

  getSellerData() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerId)
        .get()
        .then((snap) {
      previousEarnings = snap.data()!["earnings"].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    //rider location update
    UserLocation uLocation = UserLocation();
    uLocation.getCurrentLocation();

    getOrderTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/delivered.jpeg",
            width: 350,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  MapUtils.lauchMapFromSourceToDestination(
                      position!.latitude,
                      position!.longitude,
                      widget.purchaserLat,
                      widget.purchaserLng);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Go to Delivery Location",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Quicksand"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Enter OTP ",style: TextStyle(
                  fontSize: 18, // Adjust the font size
                  color: Colors.black,
                  fontFamily: "Quicksand"// Button text color
                ),),
                const SizedBox(height: 10,),
                _buildOtpInputField(),
                const SizedBox(height: 10,),
                TextButton(
                  onPressed: verifyOTP,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // Button background color
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Adjust border radius
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 16, // Adjust horizontal padding
                        vertical: 12, // Adjust vertical padding
                      ),
                    ),
                  ),
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size
                      color: Colors.white,
                        fontFamily: "Quicksand"// Button text color
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: isOtpVerified, // Show the button only when OTP is verified
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          //rider location update
                          UserLocation uLocation = UserLocation();
                          uLocation.getCurrentLocation();

                          //confirmed - that rider has picked parcel from seller
                          confirmParcelHasBeenDelivered(
                              widget.getOrderId,
                              widget.sellerId,
                              widget.purchaserId,
                              widget.purchaserAddress,
                              widget.purchaserLat,
                              widget.purchaserLng);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "Order Delivered",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand"),
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
        ],
      ),
    );
  }
  final List<TextEditingController> otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  Widget _buildOtpInputField() {
    List<Widget> otpBoxes = List.generate(4, (index) => _buildOtpBox(index));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: otpBoxes,
    );
  }
  Widget _buildOtpBox(int index) {
    return Container(
      width: 50, // Adjust the width of each box
      height: 50, // Adjust the height of each box
      margin:
      const EdgeInsets.symmetric(horizontal: 8), // Adjust the spacing between boxes
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Box border color
          width: 2, // Box border width
        ),
        borderRadius: BorderRadius.circular(8), // Box border radius
      ),
      child: Center(
        child: TextFormField(
          controller: otpControllers[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1, // Each box only allows 1 digit
          style: const TextStyle(
            fontSize: 24, // Adjust the font size of each digit
            fontWeight: FontWeight.bold,
            fontFamily: "Quicksand",// Adjust the font weight
          ),
          decoration: const InputDecoration(
            counterText: '', // Hide the character count
            border: InputBorder.none, // Hide the default text field border
          ),
          onChanged: (value) {
            if (value.length == 1) {
// Move focus to the next box when a digit is entered
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}

