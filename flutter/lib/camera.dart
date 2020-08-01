import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' show basename, join;
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
// import 'package:starflut/starflut.dart';
import 'package:tflite/tflite.dart';
import 'dart:convert';
import 'package:travel_androidx/destination_model.dart';
import 'package:travel_androidx/destination_screen.dart';
import 'package:travel_androidx/report.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  
  List<CameraDescription> cameras; // a list of the cameras
  CameraScreen(this.cameras); // calling the constructor here and storing the list sent before


  @override
    CameraScreenState createState() {
      return new CameraScreenState();
    }
}

class CameraScreenState extends State<CameraScreen> {
  final String url_API = "http://1bb989e7.ngrok.io/predict";
  CameraController _controller;
  Future <void> _initializeControllerFuture;
  Destination final_destination;
  static String storedImageURL = "DEFAULT";
  @override
  String getStoredImageURL(){
    return storedImageURL;
  }

  void setStoredImageURL(String update){
    storedImageURL = update;
  }

  void initState() {
    super.initState();
    _controller = new CameraController(widget.cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  
  }

  @override

  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final String path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Future<int> status = predictMonument(path, context);

          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }

  var server_side_mapper = {
    "0" : "Fort Aguada, Sinquerim",
    "1" : "Basilica of Bom Jesus",
    "2" : "Chapora Fort",
    "3" : "Church and Convent...",
    "4" : "Corjuem Fort, Aldona",
    "5" : "Mae De Deus Church, Saligao",
    "6"   : "Shantadurga Temple, Ponda",
    "7" : "Ponda Fort",
    "8" : "Reis Magos Fort",
    "9" : "Safa Masjid , Ponda",
    "10" : "Yashwantgad",
    "11" : "Our Lady of the Immaculate Conception Church, Panjim",
    "12" : "Se Cathedral, Old Goa",
    "13" : "Ramnathi Temple, Ponda",
    "14" : "St. Augustine Tower, Old Goa"
  };  


    var tflite_side_mapper = {
    0 : "Our Lady of the Immaculate Conception Church, Panjim",
    1 : "Se Cathedral, Old Goa",
    2 : "Fort Aguada, Sinquerim",
    3 : "Basilica of Bom Jesus",
    4 : "Chapora Fort",
    5 : "Church and Convent...",
    6   : "Corjuem Fort, Aldona",
    7 : "Mae De Deus Church, Saligao",
    8 : "Shantadurga Temple, Ponda",
    9 : "Ponda Fort",
    10 : "Ramnathi Temple, Ponda",
    11 : "Reis Magos Fort",
    12 : "Safa Masjid , Ponda",
    13 : "St. Augustine Tower, Old Goa",
    14 : "Yashwantgad"
  };  

  // Future<void> testCallPython () async{
  //   print("am here");
  //   StarCoreFactory starcore = await Starflut.getFactory();
  //   StarServiceClass service = await starcore.initSimple("main_file", "123", 0, 0, []);

  //   await starcore.regMsgCallBackP(
  //       (int serviceGroupID, int uMsg, Object wParam, Object lParam) async{
  //     print("$serviceGroupID  $uMsg   $wParam   $lParam");
  //     return null;
  //   });
  

  //   bool isAndroid = await Starflut.isAndroid();
  //   String libraryDir = await Starflut.getNativeLibraryDir();
  //     String docPath = await Starflut.getDocumentPath();
  //   if( isAndroid == true ){
  //     if( libraryDir.indexOf("arm64") > 0 ){
  //       Starflut.unzipFromAssets("lib-dynload-arm64.zip", docPath, true);
  //     }else if( libraryDir.indexOf("x86_64") > 0 ){
  //       Starflut.unzipFromAssets("lib-dynload-x86_64.zip", docPath, true);
  //     }else if( libraryDir.indexOf("arm") > 0 ){
  //       Starflut.unzipFromAssets("lib-dynload-armeabi.zip", docPath, true);
  //     }else{  //x86
  //       Starflut.unzipFromAssets("lib-dynload-x86.zip", docPath, true);
  //     }
  //     await Starflut.copyFileFromAssets("python3.6.zip", "flutter_assets/starfiles",null);  //desRelatePath must be null 
  //     await Starflut.copyFileFromAssets("main_file.py", "flutter_assets/starfiles",null);  //desRelatePath must be null 
  //   }
  
  //   StarSrvGroupClass srvGroup = await service["_ServiceGroup"];
  //   dynamic rr1 = await srvGroup.initRaw("python36", service);
  //   String resPath = await Starflut.getResourcePath();
  //   var result = await srvGroup.loadRawModule("python", "", resPath + "/flutter_assets/starfiles/" + "main_file.py", false);
  //   print("loadRawModule = $result");
  //   dynamic python = await service.importRawContext("python", "", false, "");
  //   print("python = "+ await python.getString());
  //   StarObjectClass retobj = await python.call("function", ["hello"]);
  //   print(await retobj[0]);
  //}

  Future<int> predictMonument(String imagePath, BuildContext context) async {  
     
    setStoredImageURL(imagePath);



    //  Dio dio = new Dio();                                 
    // print("Sending request");
    // var _image =  File(imagePath);                         
    // var uploadURL = url_API; 
    //  var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    // var length = await _image.length();

    // var uri = Uri.parse(uploadURL);

    // var request = new http.MultipartRequest("POST", uri);
    // var multipartFile = new http.MultipartFile('data', stream, length,
    //     filename: basename(_image.path));
    // //contentType: new MediaType('image', 'png'));
    // request.files.add(multipartFile);
    // print("Request sent, waiting for response");
    // var response = await request.send();
    // print("Response received: ");
    // response.stream.transform(utf8.decoder).listen((value){      
    //   print(value);
    //   int colonIndex = value.indexOf(':');
    //   String modifiedValue = value.substring(colonIndex + 1);
    //   modifiedValue = modifiedValue.substring(2, modifiedValue.length - 4).trim();
    //   });




    File file;
    file = File(imagePath);
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;
    String url = "https://sih-backend.satyamtg.usw1.kubesail.org/";
    
    Map data = {'data': base64Image};

    String body = json.encode(data);
    String response;

    http.post(url, headers: {"Content-Type": "application/json"},body:body).then((res) {
     response = res.body;
      String class_label = response.substring(response.indexOf("predicted_class\":") + "predicted_class\":".length);
      class_label = class_label.substring(0, class_label.length - 1);
      // print(mapper[class_label]);
      for (int i = 0; i < destinations.length; i++){
        print(destinations[i].class_label);
        if( server_side_mapper[class_label] == destinations[i].class_label){
          print("Got it. Navigate to: " + destinations[i].class_label);
          final_destination =  destinations[i];
          Navigator.push(context, MaterialPageRoute(builder: (_) => DestinationScreen.fieldConstructor(
                      final_destination.monument,
                      final_destination.imageUrl,
                      final_destination.city,
                      final_destination.locality,
                      final_destination.country,
                      final_destination.description,
                      final_destination.latitude,
                      final_destination.longitude,
                      final_destination.class_label,
                      final_destination.long_description
            )));
          
          return 1;
        }
      }
    
      Navigator.push(context, MaterialPageRoute(builder: (_) => ReportPage()));
      return -1;



   }).catchError((err) {
     response = "NULL";
   });
 

    var output = await Tflite.runModelOnImage(
      path: imagePath,
      imageMean: 1,
      imageStd: 127.5
    );

    int index = output[0]['index'];  
    
      for (int i = 0; i < destinations.length; i++){
        if( tflite_side_mapper[index] == destinations[i].class_label){
          print("Got it. Navigate to: " + destinations[i].class_label);
          final_destination =  destinations[i];
          Navigator.push(context, MaterialPageRoute(builder: (_) => DestinationScreen.fieldConstructor(
                      final_destination.monument,
                      final_destination.imageUrl,
                      final_destination.city,
                      final_destination.locality,
                      final_destination.country,
                      final_destination.description,
                      final_destination.latitude,
                      final_destination.longitude,
                      final_destination.class_label,
                      final_destination.long_description
            )));
          
          return 1;
        }
      }
    
      Navigator.push(context, MaterialPageRoute(builder: (_) => ReportPage()));
      return -1;
    
      
    
  }
  

}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}