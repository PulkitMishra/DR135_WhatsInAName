import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_androidx/UserProfile.dart';
import 'signup_page.dart';
import 'user_model.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();


Future<void> signInWithGoogle() async {

  if(isUserLoggedIn == 1){
    print("User already logged in");
    return;
  }

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  final FirebaseUser currentUser = await _auth.currentUser();

  isUserLoggedIn = 1;          
  mainUser = new User(
      currentUser.displayName, 
      "Traveler", 
      "Edit your bio", 
      "0", 
      "0",  
      "0",  
      currentUser.photoUrl,
      currentUser.photoUrl,  
      currentUser.email,  
      "GoogleSignIn",
  );
      mainUser.documentId = currentUser.uid;
      mainUser.age = "young";
      print("navigating to profile page");
            Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfilePage(
              mainUser.getFullName(), 
              "Traveler", 
              "Enter your bio", 
              "0", 
              "0",  
              "0"
    )));
}

void signOutGoogle() async{
  await googleSignIn.signOut();
}
  
  Widget googleSignInButton() {
    return SignInButton(
        Buttons.Google,
        onPressed: () {signInWithGoogle();},
    );
  }

    Widget facebookSignInButton() {
    return SignInButton(
        Buttons.Facebook,
        onPressed: () {},
    );
  }

Widget linkedinSignInButton() {
    return SignInButton(
        Buttons.LinkedIn,
        onPressed: () {},
    );
  }
  
  
  
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
                      'Welcome Back',
                      style:
                          TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
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
                          onTap: () { 
                            print("Logging in");
                            loginUser(emailController.text, passwordController.text);
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
                                  'LOGIN',
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
                    SizedBox(height: 20.0),
                    Container(
                      height: 60.0,
                      color: Colors.transparent,
                      child: Container(
                        child: InkWell(
                          onTap: () {},
                            child: Center(
                                child: googleSignInButton(),
                                  // child: Text('Go Back',
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         fontFamily: 'Montserrat')),
                                ),
                              
                        ),
                      ),
                    ),

                    SizedBox(height: 20.0),
                    Container(
                      height: 60.0,
                      color: Colors.transparent,
                      child: Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         color: Colors.black,
                        //         style: BorderStyle.solid,
                        //         width: 1.0),
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            // google sign in here
                          },
                          child: 
                          
                              Center(
                                child: facebookSignInButton(),
                                // child: Text('Go Back',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontFamily: 'Montserrat')),
                            ),
                        ),
                      ),
                    ),

                  ],
                )),
            
          SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New here ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          
          ]),
        ));
  }




  Future<void> loginUser(String email, String password) async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('users').getDocuments();
    var list = querySnapshot.documents;
    for (int i = 0; i < list.length; i++){
        if(isUserLoggedIn == 0 && email == list[i].data['email'] && password == list[i].data['password']){
            isUserLoggedIn = 1;          
            mainUser = new User(
              list[i].data['name'], 
              list[i].data['status'], 
              list[i].data['bio'], 
              list[i].data['followers'], 
              list[i].data['posts'],  
              list[i].data['scores'],  
              list[i].data['imageurl'],
              list[i].data['backgroundimageurl'],  
              list[i].data['email'],  
              list[i].data['password'],
            );
            mainUser.documentId = list[i].data['documentId'];
            mainUser.age = list[i].data['age'];
            print("navigating to profile page");
            Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfilePage(
              list[i].data['name'], 
              list[i].data['status'], 
              list[i].data['bio'], 
              list[i].data['followers'], 
              list[i].data['posts'],  
              list[i].data['scores']
            )));
            break;
            }
        }
    }
    
  }