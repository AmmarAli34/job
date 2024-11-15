import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobleapconnectnew/Model/ApplicantCardentail/profileCardentail.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:jobleapconnectnew/Model/profiledata_applicant/Applicant_profile.dart';
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  File? image;
  late Future<Uint8List> imageData;
  final _picker = ImagePicker();
  bool showSpinner = false;
  TextEditingController about = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController edu = TextEditingController();
  TextEditingController skill = TextEditingController();
  Future getimage() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      image = File(pickedfile.path);
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: 'no image select');
    }
  }

  Future<void> uploadimage() async {
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.MultipartRequest('POST', Uri.parse('https://'));
    request.files
        .add(await http.MultipartFile.fromPath('profilePicture', image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'upload Successfully');
    } else {
      print(response.reasonPhrase);
    }
  }

  void postabout(String About) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "aboutMe": About,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase);
    }
  }

  void postwork(String Work) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "workExperience": Work,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase.toString());
    }
  }

  void postedu(String Edu) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "education": Edu,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase);
    }
  }

  void postskill(String Skill) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({"skills": Skill});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
    getCardentailData();
    imageData = fetchImage();
    setState(() {});
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

  Future<ApplicantProfile?> getProfileData() async {
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
      return ApplicantProfile.fromJson(
          data); // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<ProfileCardentail?> getCardentailData() async {
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
      return ProfileCardentail.fromJson(
          data); // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  void deleteprofiledata() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.Request('DELETE', Uri.parse('https://'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: await response.stream.bytesToString());
    } else {
      Fluttertoast.showToast(msg: await response.stream.bytesToString());
      print(await response.stream.bytesToString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: linkedInColor),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    child: Center(
                                      child: SizedBox(
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          child: FutureBuilder<Uint8List>(
                                            future: imageData,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return CircleAvatar(
                                                    child: Icon(Icons.person));
                                              } else {
                                                return Image.memory(snapshot
                                                    .data!); // Display image from bytes
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 50,
                                    width: 50,
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 50),
                                                        child: Center(
                                                          child: Container(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15.0),
                                                                child: Column(
                                                                  children: [
                                                                    image ==
                                                                            null
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              getimage();
                                                                            },
                                                                            child:
                                                                                Icon(Icons.picture_in_picture))
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              getimage();
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: Center(
                                                                                child: Image.file(
                                                                                  File(image!.path),
                                                                                  height: 80,
                                                                                  width: 80,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              uploadimage();
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('Upload'))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.camera_alt))))
                              ],
                            ),
                          ),

                          //const Text("View profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: linkedInMediumGrey86888A),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white70),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                  future: getCardentailData(),
                                  builder: (context,
                                      AsyncSnapshot<ProfileCardentail?>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("Data Not Found");
                                    } else {
                                      return Text(
                                        snapshot.data!.userName.toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                    width: double.infinity,
                                    height: 2.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey, // Line color
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.workspace_premium),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Catagory",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                  future: getCardentailData(),
                                  builder: (context,
                                      AsyncSnapshot<ProfileCardentail?>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("Data Not Found");
                                    } else {
                                      return Text(
                                        snapshot.data!.category.toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                    width: double.infinity,
                                    height: 2.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey, // Line color
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.credit_card),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "CNIC",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                  future: getCardentailData(),
                                  builder: (context,
                                      AsyncSnapshot<ProfileCardentail?>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("Data Not Found");
                                    } else {
                                      return Text(
                                        snapshot.data!.cnic.toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                    width: double.infinity,
                                    height: 2.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey, // Line color
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.phone),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "phone no:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                  future: getCardentailData(),
                                  builder: (context,
                                      AsyncSnapshot<ProfileCardentail?>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("Data Not Found");
                                    } else {
                                      return Text(
                                        snapshot.data!.phoneNumber.toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                    width: double.infinity,
                                    height: 2.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey, // Line color
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_city),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "City:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                  future: getCardentailData(),
                                  builder: (context,
                                      AsyncSnapshot<ProfileCardentail?>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("Data Not Found");
                                    } else {
                                      return Text(
                                        snapshot.data!.city.toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                    width: double.infinity,
                                    height: 2.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey, // Line color
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white70),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_3_sharp),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'About me',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: about,
                                                decoration: InputDecoration(
                                                    hintText: "About",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide: BorderSide(
                                                            width: 1.0))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              postabout(
                                                about.text.toString(),
                                              );
                                              setState(() {});

                                              Navigator.pop(context);
                                            },
                                            child: Text('Set'))
                                      ],
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: getProfileData(),
                        builder: (context,
                            AsyncSnapshot<ApplicantProfile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.aboutMe.toString(),
                                style: TextStyle(fontSize: 10));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                        width: double.infinity,
                        height: 2.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey, // Line color
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white70),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.work),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Work Experience',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: work,
                                                decoration: InputDecoration(
                                                    hintText: "work",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide: BorderSide(
                                                            width: 1.0))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              postwork(
                                                work.text.toString(),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text('Set'))
                                      ],
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: getProfileData(),
                        builder: (context,
                            AsyncSnapshot<ApplicantProfile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(
                                snapshot.data!.workExperience.toString(),
                                style: TextStyle(fontSize: 10));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                        width: double.infinity,
                        height: 2.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey, // Line color
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white70),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.history_edu_rounded),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Education',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: edu,
                                                decoration: InputDecoration(
                                                    hintText: "Education",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide: BorderSide(
                                                            width: 1.0))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              postedu(
                                                edu.text.toString(),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text('Set'))
                                      ],
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: getProfileData(),
                        builder: (context,
                            AsyncSnapshot<ApplicantProfile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.education.toString(),
                                style: TextStyle(fontSize: 10));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                        width: double.infinity,
                        height: 2.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey, // Line color
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white70),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.soup_kitchen),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Skills',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: TextFormField(
                                                controller: skill,
                                                decoration: InputDecoration(
                                                    hintText: "Skill",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide: BorderSide(
                                                            width: 1.0))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              postskill(skill.text.toString());
                                              Navigator.pop(context);
                                            },
                                            child: Text('Set'))
                                      ],
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: getProfileData(),
                        builder: (context,
                            AsyncSnapshot<ApplicantProfile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.skills.toString(),
                                style: TextStyle(fontSize: 10));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                        width: double.infinity,
                        height: 2.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey, // Line color
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 65),
              child: ButtonContainerWidget(
                title: "Delete Profile",
                onTap: () {
                  deleteprofiledata();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
