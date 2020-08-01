import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_androidx/home_screen.dart';
import 'package:travel_androidx/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  final String _fullName;
  final String _status;
  final String _bio;
  final String _followers;
  final String _posts;
  final String _scores;

  UserProfilePage(
    this._fullName,
    this._status,
    this._bio,
    this._followers,
    this._posts,
    this._scores
  ) ;

  UserProfile createState() => UserProfile(
      this._fullName,
      this._status,
      this._bio,
      this._followers,
      this._posts,
      this._scores
  );
}

class UserProfile extends State<UserProfilePage>{

  final String _fullName;
  final String _status;
  final String _bio;
  final String _followers;
  final String _posts;
  final String _scores;
  NetworkImage userProfileImage;
  NetworkImage userBackgroundImage;

  UserProfile(
    this._fullName,
    this._status,
    this._bio,
    this._followers,
    this._posts,
    this._scores
  ) ;

  bool _isEditingText = false;
  TextEditingController _bioEditingController;
  String new_bio;

  Widget _buildCoverImage(Size screenSize) {
    userBackgroundImage = NetworkImage(mainUser.backgroundimageurl);
    return GestureDetector(
          onTap: () {
            updateUserBackgroundImage();
          },
          child: Container(
        height: screenSize.height / 2.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: userBackgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

Future <File> cropImage(File selected) async {
  File cropped = await ImageCropper.cropImage(
    sourcePath: selected.path,
    androidUiSettings: AndroidUiSettings(
      toolbarColor: Colors.purple,
      toolbarWidgetColor: Colors.white,
      toolbarTitle: 'Crop',
      ) 
    );

    return cropped;
}

Future <void> uploadImage(File selected) async {
    String fileName = mainUser.email;
    StorageReference storageReference = FirebaseStorage.instance.ref().child("UserProfilePics/$fileName");

    StorageUploadTask uploadTask = storageReference.putFile(selected);
    print("File uploaded: ");
    String uploadedFileURL = await(await uploadTask.onComplete).ref.getDownloadURL();
    print("Uploaded URL: " + uploadedFileURL);
    mainUser.imageurl = uploadedFileURL;
    await Firestore.instance.collection('users').document(mainUser.documentId).updateData({
      'imageurl': mainUser.imageurl,
    });
}

Future <void> uploadBackgroundImage(File selected) async {
    String fileName = mainUser.email;
    StorageReference storageReference = FirebaseStorage.instance.ref().child("UserBackgroundPics/$fileName");

    StorageUploadTask uploadTask = storageReference.putFile(selected);
    print("File (background image) uploaded: ");
    String uploadedFileURL = await(await uploadTask.onComplete).ref.getDownloadURL();
    print("Uploaded (background image) URL: " + uploadedFileURL);
    mainUser.backgroundimageurl = uploadedFileURL;
    await Firestore.instance.collection('users').document(mainUser.documentId).updateData({
      'backgroundimageurl': mainUser.backgroundimageurl,
    });
}

Future<void> updateUserBackgroundImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    selected = await cropImage(selected);
    await uploadBackgroundImage(selected);

    setState(() {
      print("Updating user profile image");
      userBackgroundImage = NetworkImage(mainUser.backgroundimageurl);
    });
}   

Future<void> updateUserProfileImage() async{
    
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    selected = await cropImage(selected);
    await uploadImage(selected);

    setState(() {
      print("Updating user profile image");
      userProfileImage = NetworkImage(mainUser.getImageUrl());
    });
} 

  Widget _buildProfileImage(_width, _height) {
    userProfileImage = NetworkImage(mainUser.getImageUrl());
        return Center(
          child: GestureDetector(
            onTap: () {
              updateUserProfileImage();
            },
            child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: userProfileImage,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.white,
              width: 10.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  Future<void> updateUserBio() async{
    
    await Firestore.instance.collection('users').document(mainUser.documentId).updateData({
      'bio': mainUser.getUserBio(),
    });
} 

  Future<void> _bioUpdateHelper() async {
    await updateUserBio();
  }

  Widget _buildBioHelper(BuildContext context) {
    return Center(
      child: TextField(
        onSubmitted: (newValue){
          setState(() {
             mainUser.setUserBio(newValue);
            _isEditingText =false;
            _bioUpdateHelper();
            _buildBio(context);
          });
        },
        autofocus: true,
        controller: _bioEditingController,
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    String bio = mainUser.getUserBio();
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    if (_isEditingText)
      return _buildBioHelper(context);
    
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () {
              setState(() {_isEditingText = true;
      });
          },
              child: Text(
          bio,
          textAlign: TextAlign.center,
          style: bioTextStyle,
        ),
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName.split(" ")[0]},",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                updateUserBackgroundImage();
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "UPDATE BACKGROUND",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () {
                mainUser = null;
                isUserLoggedIn = 0;
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "LOG OUT",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int current_tab;
    double _width = MediaQuery.of(context).size.width * 0.40;
    double _height = MediaQuery.of(context).size.height * 0.20;
    Size screenSize = MediaQuery.of(context).size;
    if(isUserLoggedIn == 0){
      Navigator.pop(context);
    }
    _bioEditingController = TextEditingController(text: _bio);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(_width, _height),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value){
          if(value == 0)
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.0,
              ), // Icon
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundImage: NetworkImage(( isUserLoggedIn==1? mainUser.getImageUrl() : mainUserAvatarImageUrl))
              ), // CircleAvatar
              title: SizedBox.shrink(),
            )
        ],
        ),
    );
  }
}