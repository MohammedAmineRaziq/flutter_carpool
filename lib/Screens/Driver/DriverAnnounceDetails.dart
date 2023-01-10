import 'package:carpool_app/Services/Driver_Service.dart';
import 'package:carpool_app/models/AnnounceModel.dart';
import 'package:flutter/material.dart';

import '../../models/ReservationModel.dart';

class DriverAnnounceDetails extends StatefulWidget {
  final AnnounceModel announce;
  const DriverAnnounceDetails({Key? key, required this.announce}) : super(key: key);

  @override
  State<DriverAnnounceDetails> createState() => _DriverAnnounceDetailsState();
}

class _DriverAnnounceDetailsState extends State<DriverAnnounceDetails> {
  @override
  Widget build(BuildContext context) {
    print("hello");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.announce.start.toString() + ' to ' + widget.announce.end.toString()),
      ),
      body:Center(
        child:Padding(
          padding : EdgeInsets.all(8.0),
          child:FutureBuilder(
            future: driverServices.getReservations(widget.announce.publicId.toString()),
            builder: (context, AsyncSnapshot<List<ReservationModel>> snapshot) {
              if (snapshot.hasData) {
                List<ReservationModel> reservations = snapshot.data!;
                return ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.blue, width: 2),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                        ),
                        title: Text(reservations[index].firstName.toString()+ ' ' + reservations[index].lastName.toString()),
                        subtitle: Text('Phone : ' + reservations[index].phoneNumber.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                driverServices.acceptReservation(widget.announce.publicId.toString() ,reservations[index].publicId.toString())
                                    .then((value){
                                  if(value){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Reservation accepted"),
                                            content: const Text("Reservation accepted "),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        });
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Reservation not accepted"),
                                            content: const Text("Reservation not accepted "),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                driverServices.rejectReservation(widget.announce.publicId.toString() , reservations[index].publicId.toString())
                                    .then((value){
                                      if(value){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Reservation rejected"),
                                                content: const Text("Reservation rejected "),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              );
                                            });
                                      }else{
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Reservation not rejected"),
                                                content: const Text("Reservation not rejected "),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                });
                              },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )

        )
      )
    );
  }
}
