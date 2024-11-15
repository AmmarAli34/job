import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jobleapconnectnew/Model/pcradentials/Pcradentials.dart';
import 'package:jobleapconnectnew/Model/pprofile/Pprofile.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pprofile extends StatefulWidget {
  const pprofile({super.key});

  @override
  State<pprofile> createState() => _pprofileState();
}

class _pprofileState extends State<pprofile> {
  File? image;
  late Future<Uint8List> imageData;
  final _picker = ImagePicker();
  bool showSpinner = false;
  TextEditingController overview = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController employeeno = TextEditingController();
  TextEditingController date = TextEditingController();
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

  void postover(String Overview) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "overview": Overview,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase);
    }
  }

  void postdes(String Des) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "description": Des,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase.toString());
    }
  }

  void postemployeeno(String Em) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "employeesNo": Em,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Add');
    } else {
      print(response.reasonPhrase);
    }
  }

  void postdate(String Date) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({"establishDate": Date});
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

  Future<Pprofile?> getProfileData() async {
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
      return Pprofile.fromJson(data); // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

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
      print(await response.stream.bytesToString());
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

  void Deleteimage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.MultipartRequest('DELETE', Uri.parse('https://'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: responseString);
      print(responseString);
    } else {
      String responseString = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: responseString);
      print(responseString);
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
                                                    child:
                                                        Icon(Icons.home_work));
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
                                                                    Row(
                                                                      children: [
                                                                        image ==
                                                                                null
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    getimage();
                                                                                  });
                                                                                },
                                                                                child: Icon(Icons.picture_in_picture))
                                                                            : InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    getimage();
                                                                                  });
                                                                                },
                                                                                child: Container(
                                                                                  child: Center(
                                                                                    child: Image.file(
                                                                                      File(image!.path),
                                                                                      height: 80,
                                                                                      width: 80,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        const SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                Deleteimage();
                                                                              });
                                                                            },
                                                                            child:
                                                                                Icon(Icons.delete))
                                                                      ],
                                                                    ),
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
                                      AsyncSnapshot<Pcradentials?> snapshot) {
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
                                      AsyncSnapshot<Pcradentials?> snapshot) {
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
                                      "Email",
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
                                      AsyncSnapshot<Pcradentials?> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("Data Not Found");
                                    } else {
                                      return Text(
                                        snapshot.data!.email.toString(),
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
                                      AsyncSnapshot<Pcradentials?> snapshot) {
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
                                      AsyncSnapshot<Pcradentials?> snapshot) {
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
                              'Overview',
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
                                                controller: overview,
                                                decoration: InputDecoration(
                                                    hintText: "overview",
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
                                              postover(
                                                overview.text.toString(),
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
                        builder: (context, AsyncSnapshot<Pprofile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.overview.toString(),
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
                              'Description',
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
                                                controller: description,
                                                decoration: InputDecoration(
                                                    hintText: "Description",
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
                                              postdes(
                                                description.text.toString(),
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
                        builder: (context, AsyncSnapshot<Pprofile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.description.toString(),
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
                              'EmployeeNo',
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
                                                controller: employeeno,
                                                decoration: InputDecoration(
                                                    hintText: "EmployeeNo",
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
                                              postemployeeno(
                                                employeeno.text.toString(),
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
                        builder: (context, AsyncSnapshot<Pprofile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.employeesNo.toString(),
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
                              'EstablishDate',
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
                                                controller: date,
                                                decoration: InputDecoration(
                                                    hintText: "Date",
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
                                              postdate(date.text.toString());
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
                        builder: (context, AsyncSnapshot<Pprofile?> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Data Not Found");
                          } else {
                            return Text(snapshot.data!.establishDate.toString(),
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
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 65),
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
            ),
          ],
        ),
      ),
    );
  }
}
