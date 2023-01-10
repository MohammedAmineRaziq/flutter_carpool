import 'package:flutter/material.dart';
import '../../Services/auth_service.dart';
class PassengerAccueil extends StatefulWidget {
  const PassengerAccueil({Key? key}) : super(key: key);

  @override
  State<PassengerAccueil> createState() => _PassengerAccueilState();
}

class _PassengerAccueilState extends State<PassengerAccueil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PassengerAccueil')
      ),
    );
  }
}

