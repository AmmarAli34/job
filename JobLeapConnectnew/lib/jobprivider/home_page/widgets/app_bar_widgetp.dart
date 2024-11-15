import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jobleapconnectnew/jobprivider/notifications/notifications_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
late Future<Uint8List> imageData= fetchImage();

Future<Uint8List> fetchImage() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  var token = sp.getString('token');
  var headers = {'token': token!};

  // Make the GET request with headers
  final response = await http.get(
    Uri.parse('https://'),
    headers: headers, // Pass headers here
  );

  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception('Failed to load image');
  }
}

PreferredSizeWidget appBarWidget(BuildContext context, {VoidCallback? onLeadingTapClickListener, String? title, bool? isJobsTab}) {
  return AppBar(
    backgroundColor: linkedInColor,
    elevation: 0,
    leading: GestureDetector(
      onTap: onLeadingTapClickListener,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(borderRadius: BorderRadius.circular(50),child:FutureBuilder<Uint8List>(
          future: imageData,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return CircleAvatar(
                  child: Icon(Icons.home_work));
            } else {
              return Image.memory(snapshot
                  .data!); // Display image from bytes
            }
          },
        )),
      ),
    ),
     title: Row(
       children: [
         Center(
           child: Text('JobProvider Page',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
         )

       ],
     ),

    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 18),
        child: Center(
          child:InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> jobprovider_NotificationsPage()));
              },
              child: Icon(Icons.notifications,color: Colors.white,)),
        ),
      ),
    ],

  );
}