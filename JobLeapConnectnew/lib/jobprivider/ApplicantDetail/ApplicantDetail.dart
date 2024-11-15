import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/Model/ApplicantDetail/ApplicantDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Applicantdetail extends StatefulWidget {
  final String id;
  const Applicantdetail({Key? key, required this.id}) : super(key: key);
  @override
  State<Applicantdetail> createState() => _ApplicantdetailState();
}

class _ApplicantdetailState extends State<Applicantdetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicantdetail(widget.id);
  }

  Future<ApplicantDetail?> getApplicantdetail(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // We need to read the response and convert it into a string before parsing it
      var responseBody = await response.stream
          .bytesToString(); // Read the response body as a string
      var data = jsonDecode(responseBody); // Now decode the JSON string
      return ApplicantDetail.fromJson(
          data); // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
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
            padding: const EdgeInsets.all(11.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white70),
              child: Column(
                children: [
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                              future: getApplicantdetail(widget.id),
                              builder: (context,
                                  AsyncSnapshot<ApplicantDetail?> snapshot) {
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                              future: getApplicantdetail(widget.id),
                              builder: (context,
                                  AsyncSnapshot<ApplicantDetail?> snapshot) {
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                              future: getApplicantdetail(widget.id),
                              builder: (context,
                                  AsyncSnapshot<ApplicantDetail?> snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Data Not Found");
                                } else {
                                  return Text(
                                      snapshot.data!.education.toString(),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                              future: getApplicantdetail(widget.id),
                              builder: (context,
                                  AsyncSnapshot<ApplicantDetail?> snapshot) {
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
                ],
              ),
            ),
          )
        ])));
  }
}
