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

var monument_description_map = {
    "Reis Magos Fort" : "The fort which stands on the hill overlooking the Reis Magos Church today, was one of the first bastions of the Portuguese rulers against enemy invasion. The fort has also been skilfully repaired in recent years and partly restored to its former glory. It is clearly visible, with its distinctive reddish stone walls, all the way from Panaji which lies across the Mandovi River from it\nAddress: Verem, Bardez, Goa 403114\nHours:\nSunday	9:30am\-5pm\nMonday	Closed\nTuesday	9:30am\-5pm\nWednesday	9:30am\-5pm\nThursday	9:30am\-5pm\nFriday	9:30am\-5pm\nSaturday	9:30am\-5pm\nPhone: 082750 25195",                        

    "Se Cathedral, Old Goa" : "One of the most ancient and celebrated religious buildings of Goa, this magnificent 16th\ncentury monument to the Roman Catholic rule in Goa under the Portuguese is the\nlargest church in Asia.  The Cathedral is dedicated to St. Catherine of Alexandria on\nwhose feast day in 1510 Alfonso Albuquerque defeated the Muslim army and took\npossession of the city of Goa. \nAddress: Velha, Goa 403402\nHours:\nSunday	7am–6:30pm\nMonday	7am–6:30pm\nTuesday	7am–6:30pm\nWednesday	7am–6:30pm\nThursday	7am–6:30pm\nFriday	7am–6:30pm\nSaturday	7am–6:30pm\nArchitectural style: Portuguese Gothic architecture\nPhone: 0832 228 4710\nArchitect: Julião Simão",

    "Ramnathi Temple, Ponda": "The original temple of Ramnathi in Goa, was located in Loutolim, Goa. The Idol of Ramnathi\nwas shifted to the present site in the 16th century to prevent its destruction\nby the then Portuguese authorities. In May 2011, the Ramnathi temple\ncompleted 450 years at its present location\nShree Ramnath Devasthan\nRamnathim\nPonda Goa\n403401\nPhone: 91-832-2335174 / 2335281",

    "Safa Masjid , Ponda": "The Shahouri Masjid in Ponda taluka, the biggest and most famous of the mosques in Goa,\nwas built in 1560 by Ibrahim Adilshah of Bijapur. Adjacent to the mosque is a well\nconstructed masonry tank with small chambers with \‘meharab\’ designs.\nAddress:\nSafa (Mulam/Mulla Family) Masjid Committe Shapur, Ponda, Goa 403401\nPhone: 094233 13666\nArchitectural style: Islamic architecture",

    "Fort Aguada, Sinquerim":   "The old Portuguese lighthouse, which stands in the middle of Fort Aguada, was built in\n1864 and once housed the great bell from the Church of St Augustine in Old Goa, before\nit was moved to the Church of Our Lady of the Immaculate Conception in Panaji.\nIt’s the oldest of its sort in Asia, but is usually not open to the public.\nAddress:\nFort Aguada Rd, Aguada Fort Area, Candolim, Goa 403515\nHours:\nSunday	8:30am–5:30pm\nMonday	8:30am–5:30pm\nTuesday	8:30am–5:30pm\nWednesday	8:30am–5:30pm\nThursday	8:30am–5:30pm\nFriday	8:30am–5:30pm\nSaturday	8:30am–5:30pm\nState Party: India\nYear built: 1612\nFunction: Fortification\nArchitect: Julião Simão",

    "Nagueshi Temple, Ponda": "Nagueshi Temple is an ancient Lord Shiva temple built in the 15th Century near Mangeshi\ntemple. Situated in Bandora Village, this temple lies 4 kms to the east of\nPonda. Unlike many other Hindu temples of Goa which were shifted out of the Velha\nConquistas the Nagueshi Temple is at its original place.\nAddress: Bandiwade, Donshiwado, Ponda, Goa 403401\nPhone: 0832 233 5039",

    "St. Cajetan Church, Old Goa": "The large Church of St. Cajetan, lies about half a kilometer away to the north east of the\nSe Cathedral, and quite near the ruins of the Viceregal Palace. This church\nconstructed in corinthian style is one of the most beautiful churches in Old Goa. \nAddress: Goa Velha, Goa 403402\nOpened: 1661\nArchitectural style: Corinthian order\nStatus: Church",

    "St. Augustine Tower, Old Goa": "The church was constructed in 1602 by Augustinian friars who had arrived in Old Goa in\n1587 and was abandoned in 1835. You can see the ruins of eight chapels, four altars\nand extensive convent with numerous cells here.\nAddress: Church of St. Augustine\nRuins,, Goa Velha, Goa 403402\nOpened: 1602\nHours:\nSunday	9am–5pm\nMonday\n9am–5pm\nTuesday	9am–5pm\nWednesday	9am–5pm\nThursday	9am–5pm\nFriday	9am–5pm\nSaturday	9am–5pm\nArchitectural style: Portuguese colonial\narchitecture\nStatus: Church",

    "Sinquerim Fort": "The Sinquerim fort covers a wider area and is guarded by fortified walls on both sides.\nDuring its younger days, the fort served as a landmark for passing ships and also\ndoubled up as a stopover for replenishing fuel and food supplies. Taj Vivanta has\noccupied the nearby property now but the major portion of the fort is still intact\nand open for public.\nRemains of an old coastal fortress popular for scenic views of the ocean & sunsets.\nAddress: Candolim, Goa\nHours:\nSunday	Open 24 hours\nMonday	Open 24 hours\nTuesday	Open 24 hours\nWednesday	Open 24 hours\nThursday	Open 24 hours\nFriday	Open 24 hours\nSaturday	Open 24 hours",

    "Three Kings Church, Cansaulim": "Located on a hill off the coastal road that goes from Velsao all the way to Cavelossim\nthis place is truly off the beaten path though not all that difficult to find\nreally. This location is visited by locals and the odd tourist only. It is a great\nplace to enjoy the fantastic views of hills in peace and quite famous for the feast\nof three kings, celebrated with great fervour. \nSmall, historic chapel boasting a ghostly legend & a picturesque view in a serene setting.\nAddress: Muder, Cansaulim, Goa 403712",

    "Corjuem Fort, Aldona": "Located at a stone’s throw from the village of Aldona, the fort’s small size is covered up\nby its prime location atop the island of Corjuem, North Goa. The fort offers\nbreathtaking views of the Goan landscape and the Mapusa river from its ancient\nramparts. On your visit, make sure to learn about the fort’s unique history.\nAddress: Off Aldona-Corjuem Road, Corjuem, Goa 403508\nHours:\nSunday	Open 24 hours\nMonday	Open 24 hours\nTuesday	Open 24 hours\nWednesday	Open 24 hours\nThursday	Open 24 hours\nFriday	Open 24 hours\nSaturday	Open 24 hours\nPhone: 0832\n243 8755\nYear built: 1705\nBuilt by: Caetano de Melo e Castro",

    "Our Lady of the Immaculate Conception Church, Panjim": "Not all of Goa’s ancient churches are concentrated in Velha Goa. A notable exception is\nthe Our Lady of Immaculate Conception Church which is located in Panjim. True to its\nname, the façade of this church is painted an immaculate, sparkling white. To the\nuntrained eye, this might even believe the actual age and antiquity of this church\nthat goes back to 500+ years.\nAddress: Rua Emídio Garcia, Altinho, Panaji, Goa 403001\nOpened: 1609\nHours:\nSunday	Closed\nMonday	9am–12:30pm, 3–5:30pm\nTuesday	9am–12:30pm, 3–5:30pm\nWednesday	9am–12:30pm, 3–5:30pm\nThursday	9am–12:30pm, 5:30pm\nFriday	9am–12:30pm, 3–5:30pm\nSaturday	9am–12:30pm\nArchitectural style: Baroque architecture\nPhone: 0832 242 6939",

    "Mae De Deus Church, Saligao": "The Mae de Deus or Mother of God Church is a breath-taking site with Gothic spires and\npristine white walls. It was built in 1873 by the efforts of Parishioners and is a\nnice place to get some peaceful time off the busy streets.\nImposing Neo-Gothic\nCatholic church with grand spires & gilded interior ornamentation.\nAddress: Chogm Rd, Muddavaddi, Saligao, Goa 403511\nHours:\nSunday	9am–12:30pm, 3–5pm\nMonday	9am–12:30pm, 3–5pm\nTuesday	9am–12:30pm, 3–5pm\nWednesday	9am–12:30pm, 3–5pm\nThursday	9am–12:30pm, 3–5pm\nFriday	9am–12:30pm, 3–5pm\nSaturday	9am–12:30pm, 3–5pm",

    "Chapel of Jesus Nazareth, Siridao": "It is a small chapel located along the shore of Siridao Beach, with a bell at the top of\nthe structure. The church building is surrounded by greenery on all sides. Behind the\nmain building is a huge dome structure, which is also part of the chapel. This shrine\nis famous for the Feast of Jesus of Nazareth, which is celebrated there during the\nfirst week of Easter.\nAddress: Unnamed Road, Siridao, Goa 403108",

    "Shantadurga Temple, Ponda": "Located at the foothills of Kavlem village in Ponda district of Goa, the Shree Shantadurga\ntemple is one of the popular pilgrimage centers in Goa. The temple was\ninitially located at Cavelossim but when it was being destroyed by the Portuguese in\n1564, the deity was shifted to Kavlem. A small laterite mud shrine was built and the\ndeity was installed here and was converted into a beautiful temple in the next few years. \nAddress: Kapileswari - Kavlem Rd, Donshiwado, Ponda, Goa 403401\nHours:\nSunday	7am–9:30pm\nMonday	7am–9:30pm\nTuesday	7am–9:30pm\nWednesday	7am–9:30pm\nThursday	7am–9:30pm\nFriday	7am–9:30pm\nSaturday	7am–9:30pm\nPhone:\n0832 231 9900\nFestivals: Magh Shuddha Panchmi (Jatrautsav), Navaratri.",

    "Tiracol Fort":   "Fort Tiracol was a symbolic location where freedom fighters from Goa demonstrated from\ntime to time. A Church for the Holy Trinity was constructed in the fort courtyard by\nde Almeida after its capture. This later became the century old Church of St.\nAnthony. Now, in a state of ruins, Fort Tiracol has been converted into a hotel, the\nFort Tiracol Heritage. The church is not open to the general public except on certain\noccasions, such as the annual feast that is usually held in May. \nAddress:\nPernem Taluka, Tiracol, 403524\nPhone: 077200 56799",

    "Basilica of Bom Jesus" : "Add desc. here",

    "Chapora Fort" : "Add desc. here"

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
    