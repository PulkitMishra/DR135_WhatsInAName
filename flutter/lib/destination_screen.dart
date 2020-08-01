import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'camera.dart';
import 'google_maps.dart';
import 'login_page.dart';
import 'review_builder.dart';
import 'destination_model.dart';
import 'package:image/image.dart' as im;


class DestinationScreen extends StatefulWidget {
  Destination destination;

  // Destination fields
  String monument;
  String imageUrl;
  String city;
  String locality;
  String country;
  String description;
  double latitude;
  double longitude;
  String class_label;
  String long_description;

  DestinationScreen({this.destination});
  DestinationScreen.fieldConstructor(
      this.monument,
      this.imageUrl,
      this.city,
      this.locality,
      this.country,
      this.description,
      this.latitude,
      this.longitude,
      this.class_label,
      this.long_description
      ) {
    destination = new Destination(
        monument: this.monument,
        imageUrl: this.imageUrl,
        city: this.city,
        locality: this.locality,
        country: this.country,
        description: this.description,
        latitude: this.latitude,
        longitude: this.longitude,
        class_label: this.class_label,
        long_description: this.long_description
    );
  }
  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}


class _DestinationScreenState extends State<DestinationScreen> {
  List<Review> reviews = [];
  int lengthOfReviews;

  Future <void> sendEmail() async {
    String imagePath = new CameraScreenState().getStoredImageURL();
    Email email;
    print(imagePath);
    if(imagePath != "DEFAULT"){
      email = Email(
        body: "Hi. I think the attached image is incorrectly identified as " + widget.destination.class_label + ".\n \n --------- details below ----------",
        subject: "Report on wrong identification " + widget.destination.class_label,
        recipients: ['nimish_bt18@iiitkalyani.ac.in'],
        isHTML: false,
        attachmentPath: imagePath,
      );
      await FlutterEmailSender.send(email);
    }
  }

  Future <void> sendInfoEmail() async {
    Email email = Email(
      body: "Hi. Here's additional information about " + widget.destination.class_label + ".\n --------- write below ----------",
      subject: "Information: " + widget.destination.class_label,
      recipients: ['nimish_bt18@iiitkalyani.ac.in'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }


  String getMainText(){
    String delimiter = "HOURS_DELIM";
    return widget.destination.long_description.substring(0, widget.destination.long_description.indexOf(delimiter));
  }

  String getHourTimings(){
    String delimiter = "HOURS_DELIM";
    String phone_delimiter = "PHONE_DELIM";
    return widget.destination.long_description.substring(widget.destination.long_description.indexOf(delimiter) + delimiter.length, widget.destination.long_description.indexOf(phone_delimiter));
  }

  String getPhoneNumber(){
    String delimiter = "PHONE_DELIM";
    return widget.destination.long_description.substring(widget.destination.long_description.indexOf(delimiter) + delimiter.length);
  }

  @override
  Widget build(BuildContext context) {
    int _currentTab = 0;
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
          flex:1,
          child: Stack(children: <Widget>[
            Container(width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color:Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRect(
                child: Image(
                  image: NetworkImage(widget.destination.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                )
              ],),
            ),
            Positioned(
              left:20.0,
              bottom:20.0,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.destination.monument, style: TextStyle(
                    color:Colors.white,
                    fontSize:  (widget.destination.monument == 'Our Lady of the Immaculate Conception Church' || widget.destination.monument == 'Chapel Of Jesus Of Nazareth' || widget.destination.monument == 'Shree Nagesh Maharudra Mandir')? 12:30.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),// TextStyle
                  ), // Text
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.locationArrow,
                        size:15.0,
                        color:Colors.white,
                      ), // Icon
                      SizedBox(width:5.0),
                      Text(widget.destination.locality, style: TextStyle(
                          color:Colors.white,
                          fontSize: 20.0
                      ), // TextStyle
                      ), // Text
                    ], // Widget
                  ), // row
                ], // Widget
              ),
            ), // column
            Positioned(
              right: 20.0,
              bottom: 20.0,
              child: IconButton(
                icon: Icon(Icons.location_on),
                color: Colors.white70,
                iconSize: 25.0,
                onPressed: () {
                  print(widget.destination.latitude);
                  print(widget.destination.longitude);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Maps(widget.destination.latitude, widget.destination.longitude)
                      )
                  );
                },
              ),
            ),

          ],),
        ),
        new Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex:5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue[100],
                      boxShadow: [
                        BoxShadow(color: Colors.black, spreadRadius: 3),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: SingleChildScrollView(
                      child: Text(
                        getMainText(),
                        style: new TextStyle(
                          fontFamily: 'Spectral',
                          fontWeight: FontWeight
                              .w600, //try changing weight to w500 if not thin
//                      fontStyle: FontStyle.italic,
                          //color: Color(0x000000),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),

                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex:5,
                  child: Row(
                    children: <Widget>[Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(color: Colors.red, spreadRadius: 3),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: SingleChildScrollView(
                          child: Text(
                            getHourTimings(),
                            style: new TextStyle(
                              fontFamily: 'Spectral',
                              fontWeight: FontWeight
                                  .w600, //try changing weight to w500 if not thin
//                      fontStyle: FontStyle.italic,
                              //color: Color(0x000000),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex:1,
                  child: Row(
                    children: <Widget>[Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(color: Colors.red, spreadRadius: 3),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: SingleChildScrollView(
                          child: Text(
                            getPhoneNumber(),
                            style: new TextStyle(
                              fontFamily: 'Spectral',
                              fontWeight: FontWeight
                                  .w600, //try changing weight to w500 if not thin
//                      fontStyle: FontStyle.italic,
                              //color: Color(0x000000),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    ],
                  ),
                ),
              ],
            ),
          ),

        ),




        // working code for previous display of reviews

        // Container(
        //           margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
        //           height: 40.0,
        //           color: Colors.transparent,
        //           child: Container(
        //             decoration: BoxDecoration(
        //                 border: Border.all(
        //                     color: Colors.black,
        //                     style: BorderStyle.solid,
        //                     width: 1.0),
        //                 color: Colors.transparent,
        //                 borderRadius: BorderRadius.circular(20.0)),
        //             child: InkWell(
        //               onTap: () {
        //                 loadReviews();
        //               },
        //               child:
        //                   Center(
        //                     child: Text('Reviews',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             fontFamily: 'Montserrat')),
        //                   ),


        //             ),
        //           ),
        //         ),

      ],
      ),

      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
          if(_currentTab == 0){
            loadReviews();
          }
          if(_currentTab == 1){
            sendInfoEmail();
          }
          if(_currentTab == 2){
            sendEmail();
          }
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rate_review,
              size: 30.0,
            ), // Icon
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
              size: 30.0,
            ), // Icon
            title: SizedBox.shrink(),
          ), // BottomNavigationBarItem
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              size: 30.0,
            ), // Icon
            title: SizedBox.shrink(),
          ), // BottomNavigationBarItem
        ], // items
      ),

    );
  }

  Future <void> loadReviews() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('reviews').getDocuments();
    var list = querySnapshot.documents;
    reviews = [];
    int len = list.length;

    for(int i = 0; i < len; i++){
      if(widget.destination.monument == list[i].data['monument_name']){
        reviews.add(new Review(
            latitude: double.parse(list[i].data['latitude']),
            longitude: double.parse(list[i].data['longitude']),
            monument: list[i].data['monument_name'],
            rating: double.parse(list[i].data['rating']),
            review: list[i].data['review'],
            timestamp: list[i].data['timestamp'],
            userName: list[i].data['username']
        ));
      }
    }
    lengthOfReviews = reviews.length;
    for(int i = 0; i < reviews.length; i++){

      print(
          "Loaded: "
              + reviews[i].latitude.toString() + " " +
              reviews[i].longitude.toString() + " " +
              reviews[i].monument + " " +
              reviews[i].rating.toString() + " " +
              reviews[i].review + " " +
              reviews[i].timestamp
      );

    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewBuilder(
        widget.destination.monument,
        widget.destination.imageUrl,
        widget.destination.city,
        widget.destination.locality,
        widget.destination.country,
        widget.destination.description,
        widget.destination.latitude,
        widget.destination.longitude,
        reviews,
        lengthOfReviews
    )));
  }
}