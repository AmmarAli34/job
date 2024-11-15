import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/Model/pcradentials/Pcradentials.dart';
import 'package:jobleapconnectnew/jobprivider/profile/pprofile.dart';
import 'package:jobleapconnectnew/pages/auth/sign_in_page.dart';
import 'package:jobleapconnectnew/pages/auth/sign_up_page.dart';
import 'package:jobleapconnectnew/pages/main/main_page/main_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Future<Uint8List> imageData = fetchImage();
  late var name = getCardentailData();

  Future<Pcradentials?> getCardentailData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.Request('GET', Uri.parse('https://'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // We need to read the response and convert it into a string before parsing it
      var responseBody = await response.stream
          .bytesToString(); // Read the response body as a string
      var data = jsonDecode(responseBody); // Now decode the JSON string
      return Pcradentials.fromJson(data); // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

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

  void deleteaccunt() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.Request('DELETE', Uri.parse('https:'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: await response.stream.bytesToString());
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => SignUpPage()), (route) => false);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * TOP AREA DRAWER - EXPANDED
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: FutureBuilder<Uint8List>(
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
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: getCardentailData(),
                        builder:
                            (context, AsyncSnapshot<Pcradentials?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(
                              snapshot.data!.userName.toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      //const Text("View profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: linkedInMediumGrey86888A),),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: linkedInLightGreyCACCCE,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => pprofile()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.person_2_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "profile",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.post_add),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Applicant Page",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // * BOTTOM AREA DRAWER
          Container(
            width: double.infinity,
            height: 1,
            color: linkedInLightGreyCACCCE,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0, left: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.login_outlined,
                      size: 20,
                      color: linkedInMediumGrey86888A,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          sp.remove('token');
                          Fluttertoast.showToast(msg: 'Logout');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => SignInPage()),
                              (route) => false);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: linkedInMediumGrey86888A,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0, left: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    deleteaccunt();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: linkedInMediumGrey86888A,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Delete Account",
                        style: TextStyle(
                            color: linkedInMediumGrey86888A,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
