import 'package:flutter/material.dart';
import 'package:travel_androidx/flight_ticket.dart';
import 'package:travel_androidx/login_page.dart';
import 'package:travel_androidx/user_model.dart';
import 'flight_card.dart';
import 'flight_model.dart';

class FlightDetailScreen extends StatelessWidget{

  final String passengerName;
  final Flight flight;

  FlightDetailScreen({
    this.passengerName,
    this.flight
  });

  @override
  Widget build(BuildContext context) {



    getRichText(title, name){
      return RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: name, style: TextStyle(color: Colors.grey)),
            ]
        ),
      );
    }


    final _passengerDetailsCard =  Card(
      elevation: 5.0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getRichText("Passenger ", passengerName),
            SizedBox(height: 10.0,),
            getRichText("Date ", "24/05/21"),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRichText("Flight ", "INDIGO042B"),
                SizedBox(width: 10.0,),
                getRichText("Class ", "Business")
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRichText("Seat ", "21B"),
                SizedBox(width: 10.0,),
                getRichText("Gate ", "17A")
              ],
            ),
            SizedBox(height: 10.0,),
            GestureDetector(
                          onTap: () { 

                            if(mainUser == null){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                            }
                            else{
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FlightHomeScreen(
                                  "Business", // to be given by the provider
                                  flight.from,
                                  flight.to,
                                  mainUser.getFullName(), 
                                  "2 Aug, 2020", // today's date
                                  flight.flightNumber,
                                  "D", // provided by the provider
                                  "13B", // provider by the provider
                              
                            )));
                          }},
                          child: Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.lightBlueAccent,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  'Checkout',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )
                          ),
                    ),
          ],
        ),
      ),
    );


    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //color: Colors.black,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.30,
                color: Colors.amber,
              ),
              Positioned(
                top: MediaQuery.of(context).size.width*0.30,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    children: <Widget>[
                      FlightCard(
                        flight: flight,
                        isClickable: false,
                      ),
                      SizedBox(height: 20.0,),
                      _passengerDetailsCard,
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}