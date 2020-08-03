import 'package:flutter/material.dart';
import 'blog.dart';
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

class SeasonalList extends StatefulWidget {


  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}



class _DestinationScreenState extends State<SeasonalList>  {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text("");
  }

  void buildActivityList(){
      // url, name, type, List<String> start time, rating, price
      
      List<String> act = [];
      act.add("Anjuna beach"); act.add("Baga beach"); act.add("Majorda beach"); act.add("Candolim beach");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/parasailing.jpg?alt=media&token=b441f6fa-076a-481e-ac0a-201042f350e8",
          "Parasailing",
          "Summer",
          act,
          3,
          1500
      ));

      act = [];
      act.add("Palolem Beach"); act.add("Coco Beach"); act.add("Sinquerim Beach"); act.add("Morjim Beach");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/dolphin.jpg?alt=media&token=dfef40b5-f683-410b-bbb2-2a504a136e51",
          "Dolphin Watching",
          "Summer",
          act,
          4,
          2500
      ));

      
      
      act = [];
      act.add("Beverage"); act.add("Shiva Valley"); act.add("Burning the Old Man"); act.add("Arjuna beach");
      activityList.add(new Activity(
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/new_year_party.jpg?alt=media&token=4db8865f-5f09-4e58-94e7-193f01a327f1",
          "New Year Parties",
          "Winter",
          act,
          4,
          1900
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
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => BlogDestinationScreen(
                      activityList[index].imageUrl,
                      activityList[index].name,
                      activityList[index].type
                    )));
                  },
                  child: Stack(
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
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}