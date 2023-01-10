import 'package:flutter/material.dart';

import '../../utils.dart';
import 'AddAnnounce.dart';
import 'DriverAnnouncesList.dart';

class DriverAccueil extends StatefulWidget {
  const DriverAccueil({Key? key}) : super(key: key);

  @override
  State<DriverAccueil> createState() => _DriverAccueilState();
}

class _DriverAccueilState extends State<DriverAccueil> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DriverAccueil'),
      ),
        body: _selectedIndex == 0 ? const AddAnnounce() : const DriverAnnounces(),
        bottomNavigationBar:BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Add Announce',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Announces List',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlueAccent,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
    );
  }
}
