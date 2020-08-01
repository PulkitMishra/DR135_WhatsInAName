import 'package:cloud_firestore/cloud_firestore.dart';
class Hotel {
  String imageUrl;
  String name;
  String placeId;
  String address;
  String rating;
  String latitude;
  String longitude;


  Hotel({
    this.imageUrl,
    this.name,
    this.placeId,
    this.address,
    this.rating,
    this.latitude,
    this.longitude
  });
}

List<Hotel> hotels = [];



class UpdateListOfHotels{ 

  Future<void> getHotelRecords() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('hotels').getDocuments();
    var list = querySnapshot.documents;
    int len = list.length;
    for(int i = 0; i < len; i++){
        Hotel hotel = new Hotel(
          imageUrl: list[i].data['imageurl'],
          name: list[i].data['name'],
          placeId: list[i].data['placeid'],
          address: list[i].data['address'],
          rating: list[i].data['rating'],
          latitude: list[i].data['latitude'],
          longitude: list[i].data['longitude']
        );
        hotels.add(hotel);
    }

    //   for(int i = 0; i < len; i++){
    //     print("******************");
    //     print(hotels[i].name);
    //     print(hotels[i].address);
    //     print(hotels[i].imageUrl);
    //     print(hotels[i].placeId);
    //     print(hotels[i].rating);
    //     print(hotels[i].latitude);
    //     print(hotels[i].longitude);
    // }
  }
}