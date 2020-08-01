
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:travel_androidx/login_page.dart';
import 'package:travel_androidx/user_model.dart';
import 'destination_model.dart';

class Review{
  double latitude;
  double longitude;
  String monument;
  double rating;
  String review;
  String timestamp;
  String userName;

  Review({
    this.latitude,
    this.longitude,
    this.monument,
    this.rating,
    this.review,
    this.timestamp,
    this.userName
  });
}
 
class ReviewBuilder extends StatefulWidget {
  
  final String monument;
  final String imageUrl;
  final String city;
  final String locality;
  final String country;
  final String description;
  final double latitude;
  final double longitude;
  final int lengthOfReviews;
  List<Review> reviews = [];
  ReviewBuilder(
    
    this.monument,
    this.imageUrl,
    this.city,
    this.locality,
    this.country,
    this.description,
    this.latitude,
    this.longitude,
    this.reviews,
    this.lengthOfReviews
    ){
      print(lengthOfReviews);
    }
    
  @override
  ReviewBuilderStatus createState() => new ReviewBuilderStatus(
    this.monument,
    this.imageUrl,
    this.city,
    this.locality,
    this.country,
    this.description,
    this.latitude,
    this.longitude,
    this.reviews,
    this.lengthOfReviews
  );
  
  
}


class ReviewBuilderStatus extends State<ReviewBuilder>{
      final String monument;
      final String imageUrl;
      final String city;
      final String locality;
      final String country;
      final String description;
      final double latitude;
      final double longitude;  
      Destination destination;
      List<Review> reviews;

      int lengthOfReviews;
      String review = "t";
      String name = "r";
      double rating = 1;

        ReviewBuilderStatus(
              this.monument,
              this.imageUrl,
              this.city,
              this.locality,
              this.country,
              this.description,
              this.latitude,
              this.longitude,
              this.reviews,
              this.lengthOfReviews
        ){
            destination =  new Destination(
            monument: this.monument,
            imageUrl: this.imageUrl,
            city: this.city,
            locality: this.locality,
            country: this.country,
            description: this.description,
            latitude: this.latitude,
            longitude: this.longitude
        );

      }

  double inputRating = 0;
  final db = Firestore.instance;
  TextEditingController reviewController = new TextEditingController();
  TextEditingController ratingController = new TextEditingController();
  
  Text _buildRatingStars(double rating) {
    String stars = '';
    for (int i = 0; i < rating; i++){
      stars += '🌟 ';
    }
    stars.trim();
    return Text(stars,
    textAlign: TextAlign.left,);
  }

Stack buildReview(int index){
          review = reviews[index].review;
          name = reviews[index].userName;
          rating = reviews[index].rating;
            return Stack(
                  children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
            height: 170.0,
            decoration: BoxDecoration(
              color: new Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(20.0),                      
            ),
            child: Column(children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildRatingStars(rating),

                ],
              ),
              SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(
                  review,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ],
              ),
            ],)
          ),
                  ],
            );
}

  @override
  Widget build (BuildContext context){
      return Scaffold(
        body: Column(
          children: <Widget>[
              Expanded(
              
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: (BuildContext context, int index){
                    return buildReview(index);
              },
              ),
      ),

      Container(
          margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 10.0),
          child: Column(
                children: <Widget>[
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,  
                  children: <Widget>[
                  Text(
                      "What's your experience!",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                ],
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        inputRating = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: inputRating,
                      size: 40.0,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.blur_on,
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                      spacing:0.0
                    ),
                  // TextField(
                  //   controller: ratingController,
                  //   decoration: InputDecoration(
                  //       labelText: 'Rating:',
                  //       labelStyle: 
                        

                        
                  //       // TextStyle(
                  //       //     fontFamily: 'Montserrat',
                  //       //     fontWeight: FontWeight.bold,
                  //       //     color: Colors.grey),
                  //       // hintText: 'EMAIL',
                  //       // hintStyle: ,
                  //       focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.green))),
                  // ),
                  
                  TextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                        labelText: 'Your Review:',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  GestureDetector(
                        onTap: (){ 
                          if(isUserLoggedIn == 1)
                              submitReview();
                          else
                              Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        child: Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
          )
      ),

          ],
        )
      );
  }

  Future <void> submitReview() async {
    print("Review submitted");
    print(inputRating);
    DocumentReference ref;
    try{
      ref = await db.collection('reviews').add({
        "latitude":destination.latitude.toString(), 
        "longitude":destination.longitude.toString(),
        "monument_name": destination.monument,
        "rating": inputRating.toString(),
        "review": reviewController.text,
        "timestamp": (new DateTime.now().millisecondsSinceEpoch).toString(),
        "username": mainUser.getFullName()
      });
      // Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewBuilder(
      //                           destination.monument,
      //                           destination.imageUrl,
      //                           destination.city,
      //                           destination.locality,
      //                           destination.country,
      //                           destination.description,
      //                           destination.latitude,
      //                           destination.longitude,
      // )));
      Navigator.pop(context);
    }catch(e){
      print(e);
  }
  }
}











