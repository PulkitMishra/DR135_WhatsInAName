import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travel_androidx/google_maps.dart';
import 'package:travel_androidx/place_detail.dart';
import 'destination_model.dart';
import 'hotel_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'hotel_model.dart';
import 'user_model.dart';
import 'user_model.dart';
import 'user_model.dart';
import 'user_model.dart';
class HotelCarousel extends StatelessWidget {
  static var sortedKeys;
  static Map<double, Hotel> map;

  String buildRating(String rating){
    String ratingText = "";
    int ratingCount = int.parse(rating);
    for(int i = 0; i < ratingCount; i++){
      ratingText += "🌟 ";
    }
    return ratingText;
  }

  void refreshHotelList(){
    double userLatitude = getUserLatitude();
    double userLongitude = getUserLongitude();
    int length = hotels.length;
    double hotelLatitude;
    double hotelLongitude;
    Hotel currentHotel;
    double distance;
    map = new Map();
    for(int i = 0; i < length; i++){
      currentHotel = hotels[i];
      hotelLatitude = double.parse(currentHotel.latitude);
      hotelLongitude = double.parse(currentHotel.longitude);
      distance = sqrt( pow(userLatitude - hotelLatitude,2) + pow(userLongitude - hotelLongitude,2) );
      map[distance] = currentHotel;
    }
    sortedKeys = map.keys.toList()..sort();
  }
  
  @override
  Widget build(BuildContext context){
    refreshHotelList();
    return Column (children: <Widget>[
              Padding( 
                padding:EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text('Hotels Near You', style: TextStyle(fontSize: 22.0, fontWeight:FontWeight.bold, letterSpacing:1.5
                    ), // TextStyle
                  ), // Text
                  
                  // for manually refreshing list if need be

                  // GestureDetector(
                  //   onTap: () {
                  //     refreshHotelList();
                  //     build(context);
                  //   },
                  //   child: Text('', style: TextStyle(
                  //       color:Theme.of(context).primaryColor,
                  //       fontSize: 16.0,
                  //       fontWeight:FontWeight.w600,
                  //       letterSpacing:1.0,
                  //   ),), // TextStyle, Text
                  // ), // GestureDetector


                ], // <Widget> []
                ), // Row 
            ),//Padding
            Container(
              height: 300.0, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotels.length,
                itemBuilder: (BuildContext context, int index){
                  Hotel hotel = map[sortedKeys[index]];
                  return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Maps(double.parse(hotel.latitude), double.parse(hotel.longitude))) );
                      },
                      child: Container(
                      margin:EdgeInsets.all(10.0),
                      width: 240.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            height:120.0,
                            width:240.0,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:EdgeInsets.all(10.0),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                              Text(hotel.name, style: TextStyle(
                                fontSize:22.0, fontWeight: FontWeight.w600, letterSpacing:1.2,
                                ), //TextStyle
                              ), // Text
                              SizedBox(height: 2.0),
                              Text(hotel.address, style: TextStyle(
                                  color: Colors.grey,
                                ), // TextStyle
                              ), // Text
                              SizedBox(height: 2.0),
                              Text(buildRating(hotel.rating), style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600, 
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
                        
                        
                        child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                height: 180.0, 
                                width: 220.0,
                                image: NetworkImage(hotel.imageUrl),
                                fit: BoxFit.cover,
                              ), // Image
                            ), // ClipRRect
                            // Positioned(
                            //   left: 10.0,
                            //   bottom: 10.0,
                            //   child: Column(
                            //     crossAxisAlignment:CrossAxisAlignment.start,
                            //     children: <Widget>[
                            //       Text(destination.city, style: TextStyle(
                            //           color:Colors.white,
                            //           fontSize: 24.0,
                            //           fontWeight: FontWeight.w600,
                            //           letterSpacing: 1.2,
                            //         ),// TextStyle
                            //       ), // Text
                            //       Row(
                            //         children: <Widget>[
                            //           Icon(FontAwesomeIcons.locationArrow,
                            //           size:10.0,
                            //           color:Colors.white,
                            //           ), // Icon
                            //           SizedBox(width:5.0),
                            //           Text(destination.country, style: TextStyle(
                            //               color:Colors.white,
                            //             ), // TextStyle
                            //           ), // Text
                            //         ], // Widget
                            //       ), // row
                            //     ], // Widget
                            //   ), // column
                            // ), // Positioned
                          
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