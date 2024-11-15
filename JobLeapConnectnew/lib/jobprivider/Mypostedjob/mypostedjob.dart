import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobleapconnectnew/Model/MyJobs/MyJobs.dart';
import 'package:jobleapconnectnew/jobprivider/jobdetail/jobdetail.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myjobs extends StatefulWidget {
  const myjobs({Key? key}) : super(key: key);

  @override
  State<myjobs> createState() => _myjobsState();
}

class _myjobsState extends State<myjobs> {
  String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getMyjob();
    });
  }

  List<MyJobs?> Myjobs = [];
  Future<List<MyJobs?>?> getMyjob() async {
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
      for (Map i in data) {
        Myjobs.add(MyJobs.fromJson(i));
        if (i != null && i['_id'] != null) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('id', i['_id']);
        }
      }
      return Myjobs;
      // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  void deletejob(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.Request('DELETE', Uri.parse('https://$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: responseBody);
      print(responseBody);
    } else {
      String errorBody = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: errorBody);
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5e4b75),
        title: Text('My Job Page',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Rubik Medium',
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 8,
                color: linkedInLightGreyCACCCE,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * More Jobs for you Section
                    const Text(
                      "My jobs ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildMoreJobsForYouList(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildMoreJobsForYouList() {
    return Column(
      children: [
        FutureBuilder(
          future: getMyjob(),
          builder: (context, AsyncSnapshot<List<MyJobs?>?> snapshot) {
            if (!snapshot.hasData) {
              return Text("Data Not Found");
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: Myjobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => jobdetails_page()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Center(
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: CircleAvatar(
                                        child: Icon(Icons.home_work))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Myjobs[index]!.jobTitle.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //  Icon(Icons.bookmark_border, size: 30, color: linkedInMediumGrey86888A,)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              SharedPreferences sp =
                                                  await SharedPreferences
                                                      .getInstance();
                                              id = sp.getString('id');

                                              setState(() {
                                                deletejob(id!);
                                              });
                                            },
                                            child: Icon(Icons.delete))
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  Myjobs[index]!.companyName.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Myjobs[index]!.city.toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.a,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Actively recruiting",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: linkedInMediumGrey86888A),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  color: linkedInMediumGrey86888A,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ],
    );
  }
}
