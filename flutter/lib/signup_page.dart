import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';
import 'home_screen.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}


Text _buildErrorMessageTextWidget(String text){
  print("called");
  return Text(
                    text,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  );
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final db = Firestore.instance;
  String text = "";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
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
                      'Signup',
                      style:
                          TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 200.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        _buildErrorMessageTextWidget(text),
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
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
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
                          labelText: 'PASSWORD ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    SizedBox(height: 50.0),
                    GestureDetector(
                          onTap: () => signUpWithEmailPassword(),
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
                                  'SIGNUP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                    ),
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

  Future<void> signUpWithEmailPassword() async {
    print(emailController.text);
    print(passwordController.text);
    FirebaseUser user;
    DocumentReference ref;
    
    try{
      user = (await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)).user;
      ref = await db.collection('users').add({
        'name':nameController.text, 
        'bio': 'Edit your bio',
        'imageurl': mainUserAvatarImageUrl,
        'backgroundimageurl': 'https://firebasestorage.googleapis.com/v0/b/flutter-travel-ea5f8.appspot.com/o/refresh.png?alt=media&token=925a204a-c1f6-422e-8499-8393057b9609',
        'status': 'Traveller',
        'scores': '0',
        'posts' : '0',
        'followers': '0',
        'email': emailController.text, 
        'password': passwordController.text
        });

        String documentID = ref.documentID;
        db.collection('users').document(documentID).updateData({
          "documentId" : documentID
        });

      Navigator.pop(context);
    }catch(e){
      text = e.toString();
      print(text);
  }
}
}