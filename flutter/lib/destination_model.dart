import 'package:cloud_firestore/cloud_firestore.dart';

import 'activity_model.dart';

class Destination {
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
  String hits;
  String monumentID;
  String age;

  Destination({
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
  });

}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/stmarksbasilica.jpg',
    name: 'St. Mark\'s Basilica',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/gondola.jpg',
    name: 'Walking Tour and Gonadola Ride',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'assets/images/murano.jpg',
    name: 'Murano and Burano Tour',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Destination> destinations = [];
List<Destination> young_destinations = [];
List<Destination> old_destinations = [];


  var russian_mapper = {
    "Reis Magos Fort" :  "Форт, который стоит на холме с видом на церковь Рейс Магос сегодня, был одним из первых бастионов ШАГА португальских правителей против вторжения врагов. Форт также STEP был умело отремонтирован в последние годы и частично восстановлен в былой славе. Это ШАГ ясно виден, с его отличительными красноватыми каменными стенами, на всем пути от ШАГА Панаджи, который лежит через реку Мандови от него. HOURS_DELIM Часы: ШАГ В воскресенье с 9:30 до 17:00 ШАГ Понедельник выходной STEP Вторник с 9:30 до 17:00 ШАГ Среда с 9:30 до 17:00 ШАГ Четверг с 9:30 до 17:00 ШАГ Пятница с 9:30 до 17:00 ШАГ Суббота с 9:30 до 17:00 PHONE_DELIM Телефон: 082750 25195",
    "Se Cathedral, Old Goa" : ""
  };  


class UpdateListOfDestination{

  Future<void> getMonumentRecords() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('monuments').getDocuments();
    var list = querySnapshot.documents;
    int len = list.length;
    for(int i = 0; i < len; i++){
      destinations.add(new Destination(
          monument: list[i].data['monument'],
          imageUrl: list[i].data['imageurl'],
          city: list[i].data['city'],
          locality: list[i].data['locality'],
          country: list[i].data['country'],
          description:list[i].data['description'],
          latitude: double.parse(list[i].data['latitude']),
          longitude: double.parse(list[i].data['longitude']),          
      ));
      destinations[i].class_label = list[i].data['class_label'];
      String long_description = list[i].data['long_description'];
      var description_list = long_description.split("STEP");
      String final_desc = "";
      for(int j = 0; j < description_list.length; j++){
        final_desc += description_list[j] + "\n";
      }
      destinations[i].long_description = final_desc;
      destinations[i].hits = list[i].data['hits'];
      destinations[i].monumentID = list[i].documentID;
      destinations[i].age = list[i].data['age'];

      if(destinations[i].age == "old"){
        old_destinations.add(destinations[i]);
      }

      else if(destinations[i].age == "yound"){
        young_destinations.add(destinations[i]);
      }
    }

    int length = destinations.length;
    Destination currentDestination;
    for(int i = 0; i < length; i++){
        for(int j = 0; j < length - 1; j++){
            int one_hits = int.parse(destinations[j].hits);
            int two_hits = int.parse(destinations[j+1].hits);
            if(one_hits < two_hits){
              currentDestination = destinations[j];
              destinations[j] = destinations[j+1];
              destinations[j+1] = currentDestination;
            }
        }
    }


}
}
    