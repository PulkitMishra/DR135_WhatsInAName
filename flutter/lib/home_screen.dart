import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_androidx/UserProfile.dart';
import 'package:travel_androidx/nearby_places.dart';
import 'package:travel_androidx/user_model.dart';
import 'camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'destination_carousel.dart';
import 'hotel_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_page.dart';
import 'destination_model.dart';
import 'user_model.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget{
  List<CameraDescription> cameras;
  HomeScreen(){
    cameras = main_cameras_list;
  }
  @override
  // The main.dart is configured so it comes here at the start of the application.
  // And this goes to _HomeScreenState constructor
  _HomeScreenState createState() => _HomeScreenState();
}

 
class _HomeScreenState extends State<HomeScreen>{
  
 


  int _selectedIndex = 0; // a state variable to monitor what has been clicked so far
  int _currentTab = 0;
  // create a list of icons to be displayed at the top of the bar
  List<IconData> _icons = [
    FontAwesomeIcons.airbnb,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.biking,
  ];

  // a function to wrap the icon and display it. It returns the widget to be displayed
  // Widget _buildIcon(int index){
    
  //   return GestureDetector(
  //     onTap: () {
  //       setState((){ 
  //         _selectedIndex = index; // set the global state variable to the parameter passed in the function
  //       });
  //     }, // onTap ends here

  //     child: Container(
  //       height:60.0,
  //       width:60.0,
  //       decoration: BoxDecoration(    // the surrounding of the icon
  //         color: _selectedIndex == index ? Theme.of(context).accentColor: Color(0xFFE7EBEE), // defined in the main.dart
  //         borderRadius: BorderRadius.circular(30.0),
  //       ), // Box Decoration

  //       child: Icon(
  //         _icons[index],  // _icons is a list; so I am just choosing an icon here given the index
  //         size: 25.0,
  //         color: _selectedIndex == index ? Theme.of(context).primaryColor:Color(0xFFB4C1C4),
  //       ), // Icon
  //     ), // container
  //   ); // Gesture Detector
  // }

  void call() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('misc').getDocuments();
    var list = querySnapshot.documents;
    for(int i = 0; i < list.length; i++){
      try{
        String number = list[i].data['sos_number'];
        launch("tel:$number");
      }

      catch (e){
        print(e.toString());
      }
    }
    
  
  }

  Future<void> launchBusWebpage() async {
      const url = 'https://goa-tourism.com/tour_menu';
      if (await canLaunch(url)) {
        await launch(url);
      } 
      
      else {
        throw 'Could not launch $url';
      }
  }

  Future<void> launchFlightsWebpage() async {
      const url = 'https://www.google.com/flights/flights-from-*-to-goa.html';
      if (await canLaunch(url)) {
        await launch(url);
      } 
      
      else {
        throw 'Could not launch $url';
      }
  }

  Future<void> launchBikingWebpage() async {
      const url = 'https://goa-tourism.com/Appln/UIL/ActivitiesHome?__Mode=AC002';
      if (await canLaunch(url)) {
        await launch(url);
      } 
      
      else {
        throw 'Could not launch $url';
      }
  }

  

  
  @override
  Widget build (BuildContext context){ // builds the things you want to
    return Scaffold(
      body:SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0), 
          children: <Widget>[
            // We have a ListView here and several of its children. Like Padding
            // and SizedBox
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'What would you do here?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ), // TextStyle
              ), // Text
            ), // Padding

            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // ensures equal spacing to fill the entire row
              // What do you want to space around: place in this children of the same
              // Here the list of icons is being mapped to entries (or indexes) the keys of which can then be passed to the _buildIcon function that actually builds them
              children: _icons
                .asMap()
                .entries
                .map(
                  (MapEntry map) {
                    int index = map.key;
                    return GestureDetector(
                        onTap: () {
                          setState( (){ 
                            _selectedIndex = index; // set the global state variable to the parameter passed in the function
                        });

                        if(_selectedIndex == 0){
                          print("Airbnb");
                        }

                        else if(_selectedIndex == 1){
                          launchBusWebpage();
                        }

                        else if(_selectedIndex == 2){
                          launchFlightsWebpage();
                        }

                        else if(_selectedIndex == 3){
                          launchBikingWebpage();
                        }
                          
                        }, // onTap ends here

                        child: Container(
                            height:60.0,
                            width:60.0,
                            decoration: BoxDecoration(    // the surrounding of the icon
                              color: _selectedIndex == index ? Theme.of(context).accentColor: Color(0xFFE7EBEE), // defined in the main.dart
                              borderRadius: BorderRadius.circular(30.0),
                            ), // Box Decoration

                            child: Icon(
                              _icons[index],  // _icons is a list; so I am just choosing an icon here given the index
                              size: 25.0,
                              color: _selectedIndex == index ? Theme.of(context).primaryColor:Color(0xFFB4C1C4),
                            ), // Icon
                          ), // container
                        );
                  },
                )
                .toList(),
            ), // Row
            SizedBox(height: 20.0),
            DestinationCarousel(),
            SizedBox(height: 20.0),
            HotelCarousel(),
          ], // <Widget>[]
        ), // List View
      ), // SafeArea
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (int value) {
            setState( () {
              _currentTab = value;
            });
            if(_currentTab == 0){
              call();
            }

            if(_currentTab == 1){
                print("Launching camera");
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CameraScreen(widget.cameras)
                        )
                        );
            }

            if(_currentTab == 2 && isUserLoggedIn == 0){
                print("Initiating Login");
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage()
                        )
                        );
            }

            else if(_currentTab == 2 && isUserLoggedIn == 1){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserProfilePage(
                      mainUser.getFullName(),
                      mainUser.getUserStatus(),
                      mainUser.getUserBio(),
                      mainUser.getUserFollowers(),
                      mainUser.getUserPosts(),
                      mainUser.getUserScores()
                  )
                  )
              );
            } 
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_active,
                size: 30.0,
              ), // Icon
              title: SizedBox.shrink(),
            ), // BottomNavigationBarItem
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                size: 30.0,
              ), // Icon
              title: SizedBox.shrink(),
            ), // BottomNavigationBarItem
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundImage: NetworkImage(( isUserLoggedIn==1? mainUser.getImageUrl() : mainUserAvatarImageUrl))
              ), // CircleAvatar
              title: SizedBox.shrink(),
            ) // BottomNavigationBarItem
          ], // items
        ), // BottomNavigationBar
    ); // Scaffold
  } 

}
