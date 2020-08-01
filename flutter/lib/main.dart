import 'package:flutter/material.dart';
import 'package:travel_androidx/hotel_model.dart';
import 'destination_model.dart';
import 'home_screen.dart';
import 'package:camera/camera.dart';
import 'review_builder.dart';
import 'package:tflite/tflite.dart';

List <CameraDescription> main_cameras_list;

loadModel() async {
  await Tflite.loadModel(
    model: 'assets/model_unquant.tflite',
    labels: 'assets/labels_new.txt'
    );
}

Future<Null> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    UpdateListOfDestination updateObject = new UpdateListOfDestination();
    await updateObject.getMonumentRecords();
    
    UpdateListOfHotels updateHotelObject = new UpdateListOfHotels();
    await updateHotelObject.getHotelRecords();
    await loadModel();
    main_cameras_list = await availableCameras();

    runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: HomeScreen(),
    );
  }
}