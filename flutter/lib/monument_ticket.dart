import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:travel_androidx/UserProfile.dart';
import 'monument_ticket_display.dart';
import 'signup_page.dart';
import 'user_model.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MonumentTicket extends StatefulWidget {
  String monument;
  MonumentTicket(
    this.monument
  ){}
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MonumentTicket> {
  
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String tourDate = "";
  String tourType = "Unguided";
  String displayText = "Select Date: ";
  
  
  bool guidedTourBool = false;
  
  
  void _onguidedTourBoolChanged(bool newValue) => setState(() {
    guidedTourBool = newValue;

    if(newValue == true){
      unguidedTourBool = false;
      tourType = "Guided";
    }
    
  });

  bool unguidedTourBool = false;

  
  void _onunguidedTourBoolChanged(bool newValue) => setState(() {
    unguidedTourBool = newValue;
    if(newValue == true){
      guidedTourBool = false;
      tourType = "Unguided";
    }
  });

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
                      'Up for a visit?',
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
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Name',
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
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Age ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: false,
                    ),

                    FlatButton(
                    onPressed: () {
                    DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2020, 8, 3),
                              maxTime: DateTime(2020, 10, 7), 
                          onChanged: (date) {
                            // print('change $date');
                          }, onConfirm: (date) {
                                tourDate = date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString();
                                setState(() {
                                  displayText = "Date: " + tourDate;
                                });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text(
                          displayText,
                          style: TextStyle(color: Colors.blue),
                      )),
                    Row(children: <Widget>[
                        Checkbox(
                          value: guidedTourBool,
                          onChanged: _onguidedTourBoolChanged
                      ),

                      SizedBox(width: 2.0),

                      Text(
                          'Guided tour',
                          style: TextStyle(color: Colors.blue),
                      ),

                      Checkbox(
                          value: unguidedTourBool,
                          onChanged: _onunguidedTourBoolChanged
                      ),

                      SizedBox(width: 2.0),

                      Text(
                          'Guide not required',
                          style: TextStyle(color: Colors.blue),
                      ),

                    ],
                  ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                          onTap: () { 
                            
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MonumentTicketDisplay(
                                    emailController.text,
                                    passwordController.text,
                                    widget.monument,
                                    tourType,
                                    tourDate
                                  )
                              )
                            );
                            // loginUser(emailController.text, passwordController.text);
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
                                  'Checkout',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )
                          ),
                    ),
                  ],
                )),
          
          ]),
        ));
  }

  }