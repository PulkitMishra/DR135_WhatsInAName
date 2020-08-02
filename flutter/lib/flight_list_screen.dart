import 'package:flutter/material.dart';
import 'flights_details_screen.dart';
import 'flight_card.dart';
import 'flight_model.dart';
import 'flight_dummy.dart';

class FlightListScreen extends StatelessWidget{


  final String fullName;
  FlightListScreen({this.fullName});

  @override
  Widget build(BuildContext context) {

    Flight flight;

    return Scaffold(
      appBar: AppBar(
        title: Text("Flights"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: FlightsMockData.count,
            itemBuilder: (context, index) {
              flight = FlightsMockData.getFlights(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlightCard(
                  fullName: fullName,
                  flight: flight,
                  isClickable: true,
                ),
              );
            }
        ),
      ),
    );
  }
}
