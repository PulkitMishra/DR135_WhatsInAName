import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:travel_androidx/UserProfile.dart';
import 'package:travel_androidx/home_screen.dart';
import 'package:travel_androidx/login_page.dart';
import 'signup_page.dart';
import 'user_model.dart';
class ReportPage extends StatefulWidget {
  @override
  ReportPageStatus createState() => new ReportPageStatus();
}

class ReportPageStatus extends State<ReportPage> {
  TextEditingController detailsController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'We didn\'t find this place. Tell us more about it.',
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 200.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[                        
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),              
                child: Column(
                  children: <Widget>[

                    TextField(
                      controller: detailsController,
                      decoration: InputDecoration(
                          labelText: 'DETAILS ABOUT THIS PLACE.',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: urlController,
                      decoration: InputDecoration(
                          labelText: 'DO YOU HAVE A WEB LINK WE CAN VIEW?',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 50.0),
                    Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                            print("Logging in");
                      //loginUser(emailController.text, passwordController.text);
                            if(isUserLoggedIn == 1){
                                sendEmail();
                            }

                            else
                              Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        child: Center(
                          child: Text(
                            'SUBMIT ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: 
                          
                              Center(
                                child: Text('Go Back',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              ),
                          
                          
                        ),
                      ),
                    ),
                  ],
                )),
            // SizedBox(height: 15.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'New to Spotify?',
            //       style: TextStyle(
            //         fontFamily: 'Montserrat',
            //       ),
            //     ),
            //     SizedBox(width: 5.0),
            //     InkWell(
            //       child: Text('Register',
            //           style: TextStyle(
            //               color: Colors.green,
            //               fontFamily: 'Montserrat',
            //               fontWeight: FontWeight.bold,
            //               decoration: TextDecoration.underline)),
            //     )
            //   ],
            // )          
          ]),
        ));

  }

  Future <void> sendEmail () async {
      final Email email = Email(
          body: detailsController.text + "\n URL: " + urlController.text,
          subject: "Report",
          recipients: ['nimish_bt18@iiitkalyani.ac.in', 'pulkitmishra007@gmail.com'],
          isHTML: false,
    );

          await FlutterEmailSender.send(email);
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}