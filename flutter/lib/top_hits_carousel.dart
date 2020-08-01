// inside lib/widgets

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'destination_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'destination_model.dart';
import 'user_model.dart';

class TopHitsCarousel extends StatelessWidget{
  static var sortedKeys;
  static Map<double, Destination> map;
  Future<void> launchMainWebpage() async {
      const url = 'https://goa-tourism.com';
      if (await canLaunch(url)) {
        await launch(url);
      } 
      
      else {
        throw 'Could not launch $url';
      }
  }

    void refreshDestinationList(){
      double userLatitude = getUserLatitude();
      double userLongitude = getUserLongitude();
      int length = destinations.length;
      double hotelLatitude;
      double hotelLongitude;
      Destination currentDestination;
      double distance;
      map = new Map();
      for(int i = 0; i < length; i++){
        currentDestination = destinations[i];
        hotelLatitude = currentDestination.latitude;
        hotelLongitude = currentDestination.longitude;
        distance = sqrt( pow(userLatitude - hotelLatitude,2) + pow(userLongitude - hotelLongitude,2) );
        map[distance] = currentDestination;
    }
      sortedKeys = map.keys.toList()..sort();
  }

  @override
  Widget build(BuildContext context){
    refreshDestinationList();
    return Column (children: <Widget>[
              Padding( 
                padding:EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text('Near You', style: TextStyle(fontSize: 22.0, fontWeight:FontWeight.bold, letterSpacing:1.5
                    ), // TextStyle
                  ), // Text
                  GestureDetector(
                    onTap: () {
                      launchMainWebpage();
                    },
                    child: Text('See All', style: TextStyle(
                        color:Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight:FontWeight.w600,
                        letterSpacing:1.0,
                    ),), // TextStyle, Text
                  ), // GestureDetector
                ], // <Widget> []
                ), // Row 
            ),//Padding
            Container(
              height: 300.0, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (BuildContext context, int index){
                  
                  Destination destination = map[sortedKeys[index]];
                  return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationScreen(
                            destination: destination,
                          )
                        )
                        ),
                                      child: Container(
                      margin:EdgeInsets.all(10.0),
                      width: 210.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            height:120.0,
                            width:200.0,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:EdgeInsets.all(10.0),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text(destination.monument, style: TextStyle(
                                fontSize:  (destination.monument == 'Our Lady of the Immaculate Conception Church' || destination.monument == 'Chapel Of Jesus Of Nazareth' || destination.monument == 'Shree Nagesh Maharudra Mandir')? 16.0:24.0, fontWeight: FontWeight.w600, letterSpacing:1.2,
                                ), //TextStyle
                              ), // Text
                              Text(destination.description, style: TextStyle(
                                  color: Colors.grey,
                                ), // TextStyle
                              ), // Text
                            ], // Widget
                            ), //Column
                            ), // Padding
                          ), // Container
                        ), // Positioned
                        Container(decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset:Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ), // BoxShadow
                            ], // boxShadow
                        ), // Box decoration
                        child: Stack(
                          children: <Widget>[
                            Hero(
                                tag: destination.imageUrl,
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 180.0, 
                                  width: 180.0,
                                  image: NetworkImage(destination.imageUrl),
                                  fit: BoxFit.cover,
                                ), // Image
                              ),
                            ), // ClipRRect
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(destination.city, style: TextStyle(
                                      color:Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),// TextStyle
                                  ), // Text
                                  Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.locationArrow,
                                      size:10.0,
                                      color:Colors.white,
                                      ), // Icon
                                      SizedBox(width:5.0),
                                      Text(destination.locality, style: TextStyle(
                                          color:Colors.white,
                                        ), // TextStyle
                                      ), // Text
                                    ], // Widget
                                  ), // row
                                ], // Widget
                              ), // column
                            ), // Positioned
                          ],//Widget
                        ), // Stack
                        ), // Container

                      ], // Widget
                      ), // Stack
                    ),
                  ); // container
                }, 
              ), // ListView.builder
              
            ),// Container

        ], // <Widget>[]
     ); // Column
  }
}