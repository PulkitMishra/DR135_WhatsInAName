import 'dart:ffi';

class User{
  String _fullName;
  String _status;
  String _bio;      
  String _followers;
  String _posts;
  String _scores;
  String imageurl;
  String backgroundimageurl;
  String email;
  String password;
  String documentId;
  String age;

  User(
    this._fullName,
    this._status,
    this._bio,
    this._followers,
    this._posts,
    this._scores,
    this.imageurl,
    this.backgroundimageurl,
    this.email,
    this.password
  );

  String getFullName(){
    
    return this._fullName;
  }

  String getImageUrl(){
      return this.imageurl;
  }

  String getBackgroundImageUrl(){
    return this.backgroundimageurl;
  }

  String getUserStatus(){
    return this._status;
  }

  String getUserBio(){
    return this._bio;
  }

  String getUserFollowers(){
    return this._followers;
  }

  String getUserPosts(){
    return this._posts;
  }

  String getUserScores(){
    return this._scores;
  }

  void setUserBio(String new_bio){
    _bio = new_bio;
  }
}

int isUserLoggedIn = 0;
User mainUser;
String mainUserAvatarImageUrl = "https://png.pngtree.com/png-vector/20191110/ourmid/pngtree-avatar-icon-profile-icon-member-login-vector-isolated-png-image_1978396.jpg";


double getUserLatitude(){
  return 15.5195;
}

double getUserLongitude(){
  return 73.7603;
}