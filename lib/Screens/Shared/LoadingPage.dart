
import 'package:carpool_app/Screens/Driver/DriverAccueil.dart';
import 'package:carpool_app/Screens/Shared/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Passenger/PassengerAccueil.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;
  bool isDriver = true;
  bool isAuthenticated = false;

  @override
  void initState() {
    checkUserAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: AssetImage("images/logo.png"),
            ),
          ),
        ),
      ),
    )
        : Container(
      child: isAuthenticated
          ? Container(
        child: isDriver
            ? const DriverAccueil()
            : const PassengerAccueil(),
      )
          : const LoginPage(),
    );
  }

  Future<void> checkUserAuthentication() async {
    const storage = FlutterSecureStorage();
    await storage.read(key: "role").then((role) {
      if (role == null) {
        setState(() {
          print("not authenticated");
          isLoading = false;
          isDriver = false;
          isAuthenticated = true;
        });
      } else {
        if (role == "DRIVER") {
          setState(() {
            print("authenticated as Driver");
            isLoading = false;
            isDriver = true;
            isAuthenticated = true;
          });
        } else {
          setState(() {
            print("authenticated as Passenger");
            isLoading = false;
            isDriver = false;
            isAuthenticated = true;
          });
        }
      }
    });
  }

}