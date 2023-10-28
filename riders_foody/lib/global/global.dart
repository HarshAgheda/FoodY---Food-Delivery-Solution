import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String completeAddress = "";
late List<Placemark> placeMarks;  // TODO ------LATE--------IF ERROR
Position? position;

String perParcelDeliveryAmount = "";
String previousEarnings = ""; //seller old total earnings
String previousRiderEarnings = ""; //rider old total earnings