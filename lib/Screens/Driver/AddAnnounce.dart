import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../Services/Driver_Service.dart';

class AddAnnounce extends StatefulWidget {
  const AddAnnounce({Key? key}) : super(key: key);

  @override
  State<AddAnnounce> createState() => _AddAnnounceState();
}

class _AddAnnounceState extends State<AddAnnounce> {
  final _formKey = GlobalKey<FormState>();
  String _start = '';
  String _end = '';
  DateTime _date = DateTime.now();
  int _price = 0;
  int _availableSeats = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text("New Announce",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Text("fill up this form in order to add a new announce",style: TextStyle(fontSize: 15),),
                  const SizedBox(height: 20,),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Departure',
                              labelText: 'Departure',
                              suffixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your departure';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _start = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Destination',
                              labelText: 'Destination',
                              suffixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your destination';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _end = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'available seats',
                              labelText: 'available seats',
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _availableSeats = int.parse(value);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'price',
                              labelText: 'price',
                              suffixIcon: Icon(Icons.money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _price = int.parse(value);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DateTimePicker(
                            decoration: const InputDecoration(
                                labelText: 'Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            type: DateTimePickerType.date,
                            dateMask: 'd MMM, yyyy',
                            firstDate: _date,
                            lastDate: DateTime(2100),
                            dateLabelText: 'Date',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter date';
                              }
                              return null;
                            },
                            onChanged: (val) => setState(() {
                              _date = DateTime.parse(val);
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              minimumSize: const Size(200, 50),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                driverServices.addNewAnnounce(_start, _end, _date.toString().substring(0, 10), _price, _availableSeats).then((value) {
                                  if (value) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Announce added successfully"),
                                          content: Lottie.asset(
                                              "lottie/success.json",
                                              width: 100,
                                              height: 100,
                                              repeat: false,
                                              animate: true,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  else{
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Announce not added"),
                                          content: Lottie.asset(
                                            "lottie/error.json",
                                            width: 100,
                                            height: 100,
                                            repeat: false,
                                            animate: true,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                });
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                      ),
                  ),
                ],
              ),
            ),
            ),
        ),
        ),
    );
  }
}
