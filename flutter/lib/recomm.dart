// inside lib/widgets

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'destination_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'destination_model.dart';
import 'user_model.dart';

class RecommCarousel extends StatelessWidget{

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
      
      int length = destinations.length;
      

  }
  var list;

  @override
  Widget build(BuildContext context){
    
    if(mainUser != null && mainUser.age == "old"){
      list = old_destinations;
      print(mainUser.age);
    }
    else if(mainUser != null && mainUser.age == "young"){
      list = young_destinations;
      print(mainUser.age);
    }

    else{
      list = destinations;
    }
    return Column (children: <Widget>[
              Padding( 
                padding:EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text('Recommended for you', style: TextStyle(fontSize: 22.0, fontWeight:FontWeight.bold, letterSpacing:1.5
                    ), // TextStyle
                  ), // Text
                  GestureDetector(
                    onTap: () {
                      //launchMainWebpage();
                    },
                    child: Text('', style: TextStyle(
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
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index){
                  
                  Destination destination = list[index];
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
                                tag: destination.imageUrl+"recomm_carousel",
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