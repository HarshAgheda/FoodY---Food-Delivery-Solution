import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody/mainScreens/address_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../global/global.dart';
import '../models/address.dart';
import '../widgets/simple_app_bar.dart';

class SaveAddressScreen extends StatelessWidget
{
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;
  Position? position;


  getUserLocationAddress() async
  {
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    position = newPosition;

    placemarks = await placemarkFromCoordinates(
        position!.latitude, position!.longitude
    );

    Placemark pMark = placemarks![0];

    String fullAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    _locationController.text = fullAddress;

    _flatNumber.text = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    _city.text = '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
    _state.text = '${pMark.country}';
    _completeAddress.text = fullAddress;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(title: "Foody"),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Save Now",
        style : TextStyle(
          fontFamily:  "Quicksand",
          fontSize: 16
        )),
        onPressed: ()
        {
          //save address info
          if(formKey.currentState!.validate())
          {
            final model = Address(
              name: _name.text.trim(),
              state: _state.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
              flatNumber: _flatNumber.text.trim(),
              city: _city.text.trim(),
              lat: position!.latitude,
              lng: position!.longitude,
            ).toJson();

            FirebaseFirestore.instance.collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(model).then((value)
            {
              Fluttertoast.showToast(msg: "New Address has been saved.");
              formKey.currentState!.reset();
            });
            Navigator.push(context, MaterialPageRoute(builder: (c)=> AddressScreen()));
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 6,),
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Add New Address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    fontFamily: "Quicksand"
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "Your address",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily:  "Quicksand",
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6,),

            ElevatedButton.icon(
              label: const Text(
                "Get my Location",
                style: TextStyle(color: Colors.white, fontFamily:  "Quicksand",),
              ),
              icon: const Icon(Icons.location_on, color: Colors.white,),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              onPressed: ()
              {
                //getCurrentLocationWithAddress
                getUserLocationAddress();
              },
            ),
            const SizedBox(height: 15,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  _buildTextFieldWithIcon(
                    hint: "Name",
                    controller: _name,
                  ),
                  _buildTextFieldWithIcon(
                    hint: 'Phone Number',
                    controller: _phoneNumber,
                  ),
                  _buildTextFieldWithIcon(
                    hint: 'City',
                    controller: _city,
                  ),
                  _buildTextFieldWithIcon(
                    hint: 'State / Country',
                    controller: _state,
                  ),
                  _buildTextFieldWithIcon(
                    hint: 'Address Line',
                    controller: _flatNumber,
                  ),
                  _buildTextFieldWithIcon(
                    hint: 'Complete Address',
                    controller: _completeAddress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextFieldWithIcon({
  required String hint,
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                style: const TextStyle(color: Colors.black, fontFamily: "Quicksand",fontSize: 17),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.grey,fontFamily: "Quicksand",fontSize: 17),
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