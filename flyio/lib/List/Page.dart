import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flyio/FlightSearchpage/HomePage.dart';
import 'package:flyio/FlightSearchpage/InputCard.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flyio/InfoScreen/screen.dart';
import 'package:flyio/List/Filter.dart';
import 'package:flyio/List/FetchInfo.dart';
import 'package:flyio/List/Getairlineclasses.dart';
import 'package:flyio/List/Getairlinename.dart';
import 'package:flyio/List/classes.dart';
import 'package:flyio/Globals.dart';

//import 'package:main/Loading.dart';

import 'package:http/http.dart' as http;

void main() => runApp(Api4());

String priceC;
String durationC;
String companyC;
String flightnumberC;
String iatacode;

class Api4 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cards page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Api(title: 'Flutter cards Page'),
    );
  }
}

class Api extends StatefulWidget {
  Api({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Api createState() => _Api();
}

class _Api extends State<Api> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
//      loading.load
//        ? CircularProgressIndicator()
//        :
        Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.lightBlue,
                title: Text('Flights',
                    style: TextStyle(
                      color: Colors.black,
                    )),
//                actions: <Widget>[
//                  PopupMenuButton<String>(
//                    icon: Icon(
//                      Icons.filter_list,
//                      color: Colors.black,
//                    ),
//                    onSelected: choiceAction,
//                    itemBuilder: (BuildContext context) {
//                      return Filter.choices.map((String choice) {
//                        return PopupMenuItem<String>(
//                          value: choice,
//                          child: Text(choice),
//                        );
//                      }).toList();
//                    },
//                  )
//                ],
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                )),
            body: Center(
                child: FutureBuilder<Info>(
                    future: futureInfo,
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          addAutomaticKeepAlives: true,
                          cacheExtent: 1000,
                          itemBuilder: (context, index) {
                            return FutureBuilder<Airline>(
                              future: Getname(getairlinehttp(snapshot
                                  .data
                                  .data[index]
                                  .itineraries[0]
                                  .segments[0]
                                  .carrierCode)),
                              builder: (context, snapshot1) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      priceC =
                                          snapshot.data.data[index].price.total;
                                      durationC = snapshot.data.data[index]
                                          .itineraries[0].duration;
                                      companyC = snapshot
                                          .data
                                          .data[index]
                                          .itineraries[0]
                                          .segments[0]
                                          .carrierCode;

                                      flightnumberC = snapshot
                                              .data
                                              .data[index]
                                              .itineraries[0]
                                              .segments[0]
                                              .carrierCode +
                                          " " +
                                          snapshot
                                              .data
                                              .data[index]
                                              .itineraries[0]
                                              .segments[0]
                                              .number;
                                      iatacode =
                                          snapshot1.data.data[0].iataCode;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecondScreen()));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 160,
                                            height: 100,
//                                        color: Colors.blueAccent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                'https://daisycon.io/images/airline/?width=300&height=150&color=ffffff&iata=' +
                                                    snapshot1
                                                        .data.data[0].iataCode,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
//                                          color: Colors.blueAccent,
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data.data[index]
                                                        .price.total,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),

                                                  Text(
                                                    (snapshot
                                                            .data
                                                            .data[index]
                                                            .itineraries[0]
                                                            .duration)
                                                        .replaceAll(
                                                            RegExp('P'), '')
                                                        .replaceAll(
                                                            RegExp('T'), '')
                                                        .replaceAll(RegExp('H'),
                                                            ' hours ')
                                                        .replaceAll(RegExp('M'),
                                                            ' minutes'),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blue.shade600),
                                                  ),
                                                  Text(
                                                    snapshot1.data.data[0]
                                                        .businessName,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data
                                                        .data[index]
                                                        .travelerPricings[0]
                                                        .fareDetailsBySegment[0]
                                                        .cabin,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
//                                        RaisedButton(
//                                          onPressed: () {
//                                            setState(() {
//                                              priceC =
//                                                  snapshot.data.data[index].price
//                                                      .total;
//                                              durationC = snapshot.data.data[index]
//                                                  .itineraries[0].duration;
//                                              companyC = snapshot.data.data[index]
//                                                  .itineraries[0].segments[0]
//                                                  .carrierCode;
//
//                                              flightnumberC =
//                                                  snapshot.data.data[index]
//                                                      .itineraries[0].segments[0]
//                                                      .aircraft.code;
//                                            });
//
//
////                                  Navigator.push(context,
////                                      MaterialPageRoute(
////                                          builder: (context) => SecondScreen())
////                                  );
//                                          },
//                                          child: Text(
//                                              'Purchase',
//                                              style: TextStyle(
//                                                  fontSize: 15,
//                                                  fontWeight: FontWeight.bold
//                                              )
//                                          ),
//                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              //how many cards we want to display
                            );
                          },
                          itemCount: snapshot.data.meta.count,
//                  itemCount: 10,
                        );
                      }
                    })));
  }

  void choiceAction(String choice) {
    print("Working");
  }
}
