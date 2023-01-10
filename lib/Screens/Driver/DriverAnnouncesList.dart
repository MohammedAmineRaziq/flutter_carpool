import 'package:carpool_app/Services/Driver_Service.dart';
import 'package:flutter/material.dart';

import '../../models/AnnounceModel.dart';
import 'DriverAnnounceDetails.dart';

class DriverAnnounces extends StatefulWidget {
  const DriverAnnounces({Key? key}) : super(key: key);

  @override
  State<DriverAnnounces> createState() => _DriverAnnouncesState();
}

class _DriverAnnouncesState extends State<DriverAnnounces> {

  late List<AnnounceModel> announces;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: driverServices.getAnnounces(),
            builder: (context, AsyncSnapshot<List<AnnounceModel>> snapshot) {
              if (snapshot.hasData) {
                announces = snapshot.data!;
                return ListView.builder(
                  itemCount: announces.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Colors.blue, width: 2),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                                Icons.directions_car,
                                color: Colors.lightBlueAccent,
                            ),
                            title: Row(
                              children: [
                                Text(announces[index].start.toString()),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.lightBlueAccent,
                                ),
                                Text(announces[index].end.toString()),
                              ],
                            ),
                            subtitle: Text('Departure date : ' + announces[index].date.toString().substring(0,10)),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlueAccent,
                                fixedSize: const Size(80, 40),

                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DriverAnnounceDetails(announce : announces[index]),
                                  ),
                                );
                              },
                              child: const Text('Details'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    'Number of seats : ' + announces[index].places.toString() ,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                      'Price : ' + announces[index].price.toString() + ' DH',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          )
          /*Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 ListTile(
                  leading: const Icon(Icons.emoji_transportation,
                  color: Colors.lightBlueAccent,),
                  title: Row(
                    children: const [
                      Text('Casablanca    '),
                      Icon(Icons.arrow_right_alt),
                      Text('   El jadida'),
                    ],
                  ),
                  subtitle: Text('Departure time : 2022-01-01'),
                ),
                Row(
                  children : [
                    Text('      '),
                    Row(
                      children: [
                        Text('Price : 100'),
                        const Icon(Icons.money),
                      ],
                    ),
                    Text('      '),
                    Text('Number of seats : 4'),
                    Text('      '),
                  ]
                ),
                SizedBox( height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: const Text('See more'),
                      onPressed: () {
                      },
                    ),
                    const SizedBox(width: 8)
                  ],
                ),
                SizedBox( height: 10),
              ],
            ),
          ),*/
        ),
    );
  }
}
