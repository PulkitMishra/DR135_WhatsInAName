import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BlogDestinationScreen extends StatefulWidget {
 
  String imageUrl;
  String author;
  String title;
  // Destination fields
 BlogDestinationScreen(
   this.imageUrl,
   this.author,
   this.title
 ){}

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<BlogDestinationScreen> {
  

  @override
  Widget build(BuildContext context) {
    int _currentTab = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Image(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ), // TextStyle
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          widget.author,
                          // getMainText(),
                          style: new TextStyle(
                            fontFamily: 'Spectral',
                            fontWeight: FontWeight
                                .w600, //try changing weight to w500 if not thin
//                      fontStyle: FontStyle.italic,
                            //color: Color(0x000000),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Text(
                        '''
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ornare arcu odio ut sem nulla. Pretium aenean pharetra magna ac placerat vestibulum lectus mauris. A lacus vestibulum sed arcu non. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean. Nisl rhoncus mattis rhoncus urna neque viverra justo nec. Risus nullam eget felis eget nunc lobortis mattis aliquam. Egestas tellus rutrum tellus pellentesque eu tincidunt. Blandit turpis cursus in hac habitasse platea dictumst quisque. Lectus urna duis convallis convallis tellus id interdum velit. At volutpat diam ut venenatis tellus in metus. Nunc non blandit massa enim nec dui nunc mattis. In vitae turpis massa sed. Vitae semper quis lectus nulla at. 

Eget mi proin sed libero enim sed faucibus. Sit amet facilisis magna etiam tempor orci eu lobortis. Quam viverra orci sagittis eu volutpat odio facilisis. Eu turpis egestas pretium aenean pharetra. Nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Sagittis vitae et leo duis. Erat velit scelerisque in dictum non consectetur a. Eget dolor morbi non arcu risus. In egestas erat imperdiet sed. Dui accumsan sit amet nulla facilisi morbi.

Nisl suscipit adipiscing bibendum est ultricies integer quis auctor elit. Pellentesque diam volutpat commodo sed egestas. Morbi tristique senectus et netus et malesuada fames ac. Eget sit amet tellus cras adipiscing enim eu. At erat pellentesque adipiscing commodo elit. Commodo quis imperdiet massa tincidunt nunc pulvinar sapien et ligula. Ut sem nulla pharetra diam sit amet nisl suscipit adipiscing. Sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Cursus turpis massa tincidunt dui ut ornare. Aenean vel elit scelerisque mauris pellentesque. Diam ut venenatis tellus in metus vulputate eu. Odio tempor orci dapibus ultrices.

Volutpat commodo sed egestas egestas fringilla phasellus. In hac habitasse platea dictumst quisque sagittis purus sit. Donec enim diam vulputate ut pharetra sit amet aliquam id. Purus in massa tempor nec. Sit amet aliquam id diam maecenas ultricies mi eget mauris. Dolor morbi non arcu risus quis varius. Id diam vel quam elementum pulvinar etiam non. Consectetur lorem donec massa sapien faucibus et molestie. Arcu dui vivamus arcu felis bibendum. Dui faucibus in ornare quam viverra orci. Hendrerit dolor magna eget est lorem ipsum dolor sit amet. Vitae sapien pellentesque habitant morbi tristique senectus et netus. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus. Mi bibendum neque egestas congue quisque. Volutpat consequat mauris nunc congue nisi vitae suscipit tellus mauris. Pretium nibh ipsum consequat nisl vel pretium.

Pellentesque eu tincidunt tortor aliquam nulla facilisi cras. At in tellus integer feugiat scelerisque varius morbi enim. Urna duis convallis convallis tellus id interdum. Pharetra pharetra massa massa ultricies mi quis hendrerit. Nulla malesuada pellentesque elit eget gravida. Proin sagittis nisl rhoncus mattis rhoncus urna neque viverra justo. Vestibulum lectus mauris ultrices eros in cursus turpis massa. Velit sed ullamcorper morbi tincidunt. Enim ut sem viverra aliquet eget. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui. Sapien et ligula ullamcorper malesuada proin libero. Ultricies lacus sed turpis tincidunt id. Vulputate enim nulla aliquet porttitor lacus luctus accumsan. Ultrices dui sapien eget mi proin.

In mollis nunc sed id semper. Libero enim sed faucibus turpis in. Et malesuada fames ac turpis egestas. Elementum facilisis leo vel fringilla est ullamcorper eget. Gravida cum sociis natoque penatibus et magnis dis. Donec adipiscing tristique risus nec. Pellentesque sit amet porttitor eget dolor morbi. Elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus. Amet facilisis magna etiam tempor orci. Ut ornare lectus sit amet est placerat in. Euismod quis viverra nibh cras. Ullamcorper dignissim cras tincidunt lobortis feugiat vivamus. Volutpat est velit egestas dui. Fames ac turpis egestas integer. Volutpat commodo sed egestas egestas.

Iaculis nunc sed augue lacus viverra vitae congue eu. Orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor. Cum sociis natoque penatibus et magnis. Metus vulputate eu scelerisque felis imperdiet. Tortor posuere ac ut consequat semper viverra nam libero justo. Suscipit adipiscing bibendum est ultricies integer quis auctor. Nunc sed velit dignissim sodales ut. Dictum sit amet justo donec enim diam vulputate ut. At urna condimentum mattis pellentesque id nibh tortor id aliquet. Morbi blandit cursus risus at. Consectetur purus ut faucibus pulvinar elementum integer enim neque volutpat. Tincidunt nunc pulvinar sapien et. Suspendisse ultrices gravida dictum fusce ut placerat. Amet massa vitae tortor condimentum lacinia quis. Sit amet consectetur adipiscing elit ut aliquam purus. Sed ullamcorper morbi tincidunt ornare massa eget egestas purus viverra. Duis convallis convallis tellus id interdum velit laoreet id. Sagittis purus sit amet volutpat. Lacus sed turpis tincidunt id aliquet.

Vel pretium lectus quam id leo in vitae turpis. Adipiscing elit duis tristique sollicitudin nibh. Etiam erat velit scelerisque in. Amet nisl suscipit adipiscing bibendum. Vestibulum sed arcu non odio. In hac habitasse platea dictumst. Odio ut enim blandit volutpat maecenas volutpat. Risus feugiat in ante metus dictum at tempor. Convallis tellus id interdum velit laoreet id donec. Nulla facilisi nullam vehicula ipsum a arcu cursus. Tincidunt vitae semper quis lectus nulla at volutpat diam. Mattis molestie a iaculis at erat pellentesque adipiscing commodo. Ut enim blandit volutpat maecenas. Rhoncus urna neque viverra justo nec ultrices dui sapien eget. Mi proin sed libero enim sed faucibus turpis.

Dignissim diam quis enim lobortis. Tincidunt eget nullam non nisi est sit amet facilisis. Sed cras ornare arcu dui. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus. Arcu odio ut sem nulla pharetra. Cum sociis natoque penatibus et magnis dis parturient. Sagittis purus sit amet volutpat consequat mauris nunc. Scelerisque purus semper eget duis at tellus at urna condimentum. Integer eget aliquet nibh praesent. Et malesuada fames ac turpis egestas sed. Eu non diam phasellus vestibulum lorem sed risus.

Netus et malesuada fames ac turpis egestas sed tempus. Consequat id porta nibh venenatis cras. Convallis posuere morbi leo urna molestie at. Eget duis at tellus at urna. Arcu cursus euismod quis viverra. Viverra vitae congue eu consequat ac felis donec et odio. Pharetra pharetra massa massa ultricies mi. Aliquam vestibulum morbi blandit cursus risus at. Eros donec ac odio tempor orci dapibus ultrices in. Aliquam faucibus purus in massa tempor nec feugiat nisl pretium. Aenean sed adipiscing diam donec. Nisl rhoncus mattis rhoncus urna neque viverra justo. Faucibus nisl tincidunt eget nullam. Metus dictum at tempor commodo ullamcorper a lacus vestibulum. Facilisis leo vel fringilla est ullamcorper eget nulla.''',
                        
                        // getHourTimings(),
                        style: new TextStyle(
                          fontFamily: 'Spectral',
                          fontWeight: FontWeight
                              .w600, //try changing weight to w500 if not thin
//                      fontStyle: FontStyle.italic,
                          //color: Color(0x000000),
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}