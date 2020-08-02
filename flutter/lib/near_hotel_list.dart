import 'package:flutter/material.dart';
import 'destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


List<Activity> activityList = [];

class Activity {
  String imageUrl;
  String name;
  String type;
  List<String> startTimes;
  int rating;
  int price;

  Activity(
    this.imageUrl,
    this.name,
    this.type,
    this.startTimes,
    this.rating,
    this.price,
  ); 
}

class HotelDestinationScreen extends StatefulWidget {


  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}



class _DestinationScreenState extends State<HotelDestinationScreen>  {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  void buildActivityList(){
      // url, name, type, List<String> start time, rating, price
      
      List<String> act = [];
      act.add("Free wifi"); act.add("Free parking"); act.add("Free breakfast"); act.add("Community");
      
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/hotels%2Fbour.jpg?alt=media&token=f01a000f-cba6-4122-89eb-aae4d9d0b24c",
          "Bougainvillea Guest House Goa",
          "3.1 km",
          act,
          3,
          1500
      ));

      act = [];
      act.add("Spa"); act.add("Pool"); act.add("Nightlife"); act.add("Community");
      
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/hotels%2Ftaj.jpg?alt=media&token=cebfca13-f2c8-40c7-9687-0b21194efce2",
          "Taj Fort Aguada Resort & Spa, Goa",
          "3.7 km",
          act,
          4,
          2500
      ));

            act.add("Free wifi"); act.add("Free parking"); act.add("Free breakfast"); act.add("Community");
      
      act = [];
      act.add("Free wifi"); act.add("Bar"); act.add("Free breakfast"); act.add("Community");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/hotels%2Fhangover.jpg?alt=media&token=4688fb35-b733-427e-8dcd-459ea7d337ed",
          "Hangover Resort",
          "3.1 km",
          act,
          4,
          1900
      ));

      act = [];
      act.add("Free wifi"); act.add("Free parking"); act.add("Outdoor Pool"); act.add("Bar");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/hotels%2Fsinq2.jpg?alt=media&token=c8b7dd8f-0dbd-497d-b62c-c90b1fe7e1f9",
          "SinQ Party hotel",
          "3.2 km",
          act,
          5,
          3000
      ));

      act = [];
      act.add("Free wifi"); act.add("Free parking"); act.add("Pool"); act.add("Bar");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/hotels%2Flui.jpg?alt=media&token=f2f6e4de-6618-4f39-94ba-ad1d6f890fff",
          "Lui Beach Resort",
          "3.5 km",
          act,
          4,
          3500
      ));


      act = [];
      act.add("Free parking"); act.add("Outdoor pool"); act.add("Parties"); act.add("Bar");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/hotels%2Fdon.jpg?alt=media&token=a5e87f09-c688-4d93-9b00-a01f581eaee1",
          "Don Hill Beach Resort",
          "3.5 km",
          act,
          5,
          4000
      ));

  }



  Widget build(BuildContext context) {
    buildActivityList();
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Stack(
          //   children: <Widget>[
          //     Container(
          //       height: MediaQuery.of(context).size.width,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30.0),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black26,
          //             offset: Offset(0.0, 2.0),
          //             blurRadius: 6.0,
          //           ),
          //         ],
          //       ),
          //       child: Hero(
          //         tag: widget.destination.imageUrl,
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(30.0),
          //           child: Image(
          //             image: NetworkImage(widget.destination.imageUrl),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           IconButton(
          //             icon: Icon(Icons.arrow_back),
          //             iconSize: 30.0,
          //             color: Colors.black,
          //             onPressed: () => Navigator.pop(context),
          //           ),
          //           Row(
          //             children: <Widget>[
          //               IconButton(
          //                 icon: Icon(Icons.search),
          //                 iconSize: 30.0,
          //                 color: Colors.black,
          //                 onPressed: () => Navigator.pop(context),
          //               ),
          //               IconButton(
          //                 icon: Icon(FontAwesomeIcons.sortAmountDown),
          //                 iconSize: 25.0,
          //                 color: Colors.black,
          //                 onPressed: () => Navigator.pop(context),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Positioned(
          //       left: 20.0,
          //       bottom: 20.0,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text(
          //             widget.destination.city,
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 35.0,
          //               fontWeight: FontWeight.w600,
          //               letterSpacing: 1.2,
          //             ),
          //           ),
          //           Row(
          //             children: <Widget>[
          //               Icon(
          //                 FontAwesomeIcons.locationArrow,
          //                 size: 15.0,
          //                 color: Colors.white70,
          //               ),
          //               SizedBox(width: 5.0),
          //               Text(
          //                 widget.destination.country,
          //                 style: TextStyle(
          //                   color: Colors.white70,
          //                   fontSize: 20.0,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Positioned(
          //       right: 20.0,
          //       bottom: 20.0,
          //       child: Icon(
          //         Icons.location_on,
          //         color: Colors.white70,
          //         size: 25.0,
          //       ),
          //     ),
          //   ],
          // ),
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              itemCount: activityList.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = activityList[index];
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  child: Text(
                                    activity.name,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Rs. ${activity.price}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'adult',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              activity.type,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            _buildRatingStars(activity.rating),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes[0],
                                    style: TextStyle(
                                      fontSize: 10
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes[1],
                                    style: TextStyle(
                                      fontSize: 10
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes[2],
                                    style: TextStyle(
                                      fontSize: 10
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes[3],
                                    style: TextStyle(
                                      fontSize: 10
                                    ),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      bottom: 15.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          width: 110.0,
                          image: NetworkImage(
                            activity.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}