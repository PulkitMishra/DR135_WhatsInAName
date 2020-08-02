import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'place_detail.dart';

const kGoogleApiKey = "AIzaSyBFMEAay9M2yMaN2J5IRw9taT8-yqqUhmY";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


class Maps extends StatefulWidget {
  final double monument_latitude;
  final double monument_longitude;
  Maps(this.monument_latitude, this.monument_longitude);
  @override
  State<StatefulWidget> createState() {
    return HomeState(monument_latitude, monument_longitude);
  }
}

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


class HomeState extends State<Maps> {
  final double monument_latitude;
  final double monument_longitude;
  
  HomeState(this.monument_latitude, this.monument_longitude);

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String errorMessage;
  List<Activity> activityList = [];
  
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
      act.add("1"); act.add("2"); act.add("3");
      
      activityList.add(new Activity(
          "https://media-cdn.tripadvisor.com/media/photo-s/01/6e/af/b6/bougainvillea-guest-house.jpg",
          "Bougainvillea Guest House Goa",
          "type",
          act,
          3,
          1500
      ));

  }



  Widget destinationWidget(BuildContext context) {
    print("called");
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
                      height: 170.0,
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
                                      '{activity.price}',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '/ head',
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
                          image: AssetImage(
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




  @override
  Widget build(BuildContext context) {
    
    // Widget expandedChild;
   
    // expandedChild = Center(
    //     child: destinationWidget(context),
    //   );
    
      //expandedChild = buildPlacesList();

    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("Location"),
          actions: <Widget>[
            isLoading
                ? IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      refresh();
                    },
                  ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: 200.0,
                  child: GoogleMap(
                      onMapCreated: _onMapCreated,                      
                          myLocationEnabled: true,
                          initialCameraPosition:
                              const CameraPosition(target: LatLng(0.0, 0.0)),
                      markers: Set<Marker>.of(markers.values),       
                      )),
            ),
            // Expanded(
            //   child: expandedChild
            // ),
          ],
        ));
  }

  void refresh() async {
    final center = LatLng(this.monument_latitude, this.monument_longitude);

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  LatLng getUserLocation() {

    try {
      final center = LatLng(monument_latitude, monument_longitude);      
      return center;
    } on Exception {
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {

          final MarkerId markerId = MarkerId(DateTime.now().toString());
          final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(f.geometry.location.lat, f.geometry.location.lng),
          infoWindow: InfoWindow(
          title: "${f.name}", snippet: "${f.types?.first}"),
              onTap: (){
        //_onMarkerTapped(markerId),
      },
    );
        setState(() {
          markers[markerId] = marker;
    });
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
    //   );
     }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
}