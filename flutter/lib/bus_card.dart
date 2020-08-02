import 'package:flutter/material.dart';
import 'package:travel_androidx/bus_details.dart';
import 'package:travel_androidx/bus_model.dart';
import 'package:travel_androidx/destination_model.dart';
import 'package:travel_androidx/login_page.dart';
import 'package:travel_androidx/user_model.dart';
import 'flight_model.dart';

class BusCard extends StatelessWidget{
  final Bus bus;
  final String fullName;
  final bool isClickable;

  BusCard({this.bus, this.fullName, @required this.isClickable});

  _cityStyle(code, cityName, time){
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(code, style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
          ),),
          Text("Attractions: " + cityName, style: TextStyle(fontSize: 14.0),),
          SizedBox(height: 10.0,),
          Text("Tour time: " + time, style: TextStyle(color: Colors.grey, fontSize: 14.0),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        if(mainUser == null){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        }
        // else{
        //   isClickable?
        //   Navigator.of(context).push(
        //       MaterialPageRoute(
        //           builder: (context)
        //           => BusDetailScreen(
        //             passengerName: fullName,
        //             destination: destination,
        //           )
        //       )
        //   ):null;
        // }
      },

      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical:20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _cityStyle(bus.busName, bus.city, bus.departTime),
                Icon(Icons.directions_bus),
              ],
            ),
          ),
        ),
      ),
    );
  }

}