 import 'package:carpool_app/Screens/Driver/DriverAccueil.dart';
import 'package:carpool_app/Screens/Shared/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Screens/Passenger/PassengerAccueil.dart';

bool isValideEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  void redirectUser(BuildContext context) async {
 const storage = FlutterSecureStorage();
 await storage.read(key: "role").then((role) {
 if (role == null) {
 Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => const LoginPage()),
 );
 } else {
 if (role == "DRIVER") {
 Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => const DriverAccueil()),
 );
 } else {
 Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => const PassengerAccueil()),
 );
 }
 }
 });
 }
 void logOut(BuildContext context){
  const storage = FlutterSecureStorage();
  storage.deleteAll();
  Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => const LoginPage()),
  );
 }