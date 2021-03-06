import 'package:flutter/material.dart';
import 'package:flyio/FlightSearchpage/Autcomplete2.dart';
import 'package:flyio/FlightSearchpage/InputCard.dart';
import 'package:flyio/FlightSearchpage/Autocomplete.dart';



DateTime _dateTime1;
DateTime _dateTime2;
var dayy;
var monthh;
String displayfordep = "Pick a departure date";

class FlightInput extends StatefulWidget {
  @override
  _FlightInputState createState() => _FlightInputState();
}
class _FlightInputState extends State<FlightInput> {
  @override
  Widget build(BuildContext context) {
    return
//      loading
//        ? CircularProgressIndicator()
//        :
    Form(
        child: Padding(
           padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
//              child: TextFormField(
//                controller: wherefromcon,
//                decoration: InputDecoration(
//                  icon: Icon(Icons.flight_takeoff, color: Colors.blueAccent),
//                  labelText: "From",
//                ),
//              ),
            child: MyHomePage(),
                  ),
//            SearchFlights(),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
//              child: TextFormField(
//                controller: wheretocon,
//                decoration: InputDecoration(
//                  icon: Icon(Icons.flight_land, color: Colors.blueAccent),
//
//                  labelText: "To",
//                ),
//              ),

              child: Autocomlete2(),
            ),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: Padding(
//                    padding: const EdgeInsets.only(bottom: 8.0),
//                    child: TextFormField(
//                      decoration: InputDecoration(
//                        icon: Icon(Icons.flight_land, color: Colors.blueAccent),
//                        labelText: "To",
//                      ),
//                    ),
//                  ),
//                ),
//                Container(
//                  width: 64.0,
//                  alignment: Alignment.center,
//                  child: Icon(Icons.add_circle_outline, color: Colors.grey),
//                ),
//              ],
//            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TextFormField(
                onChanged: (String value){},
                controller: passcon,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.blueAccent),
                  labelText: "Passengers",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range, color: Colors.blueAccent),
                ),
                SizedBox(width: 0,),
//                Expanded(
//                  child:
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RaisedButton(
                      color: Colors.blue[300],
                      child: Text(
                          displayfordep,
                      style:
                        TextStyle(
                          fontFamily: "Indie",
                          color:Colors.white ,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: _dateTime1 == null
                                ? DateTime.now()
                                : _dateTime1,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2021)
                        ).then((date) {
                          if (date.day.toInt() < 10){setState(() {dayy = "0"+date.day.toString();});}else{dayy=date.day.toString();}
                          if (date.month.toInt() < 10){setState(() {monthh = "0"+date.month.toString();});}else{monthh=date.month.toString();}

                          setState(() {

                            _dateTime1 = date;

                            datedep = date.year.toString() + "-" + monthh + "-" +dayy;

                            displayfordep = datedep;
                          });
                        });
//                        );},
                      })
                  ),
//                ),
//                Expanded(
//                  child: Padding(
//                    padding: const EdgeInsets.only(left: 16.0),
//                    child: TextFormField(
//                      decoration: InputDecoration(labelText: "Arrival"),
//                    ),
//                  ),
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }}