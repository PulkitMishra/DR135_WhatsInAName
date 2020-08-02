import 'package:cloud_firestore/cloud_firestore.dart';

import 'flight_model.dart';


List<Flight> flightsList = [];

class FlightsMockData {

  static var count;
  

  static var from = ["BBI", "CCU", "HYD", "BOM", "JAI"];
  static var to = ["BLR", "JAI", "BBI", "CCU", "AMD"];
  static var fromCity = ["Bhubaneshwar", "Kolkata", "Hyderabad", "Mumbai", "Jaipur"];
  static var toCity = ["Bangalore", "Jaipur", "Bhubaneshwar", "Kolkata", "Ahmedabad"];
  static var departTime = ["5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM"];
  static var arriveTime = ["8:40 AM", "7:25 PM", "4:00 PM", "8:21 AM", "3:25 PM"];
  static var flightNumber = ["6E-633", "6E-652", "6E-433", "6E-133", "6E-100"];

  getFlightsList() async{
    
    QuerySnapshot querySnapshot = await Firestore.instance.collection('flights').getDocuments();
    var list = querySnapshot.documents;
    int len = list.length;
    count = len;
    for(int i = 0; i < len; i++){
        Flight flights = new Flight(list[i].data['from'], list[i].data['to'], list[i].data['fromCity'], list[i].data['toCity'], 
        list[i].data['departTime'], list[i].data['arriveTime'], list[i].data['flightNumber']);
        flightsList.add(flights);
    }
    
  }

  static Flight getFlights(int position) {

      return flightsList[position];

  }

}