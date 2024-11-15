import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/Model/allAplicant/AllAplicant.dart';
import 'package:jobleapconnectnew/Model/threeAplicant/ThreeAplicant.dart';
import 'package:jobleapconnectnew/jobprivider/ApplicantDetail/ApplicantDetail.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class provider_main_page extends StatefulWidget {
  const provider_main_page({super.key});

  @override
  State<provider_main_page> createState() => _provider_main_pageState();
}

class _provider_main_pageState extends State<provider_main_page> {
  @override
  List<ThreeAplicant> Allaplicant3 = [];
  Future<List<ThreeAplicant>?> getallApplicant3() async {
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
        Allaplicant3.add(ThreeAplicant.fromJson(i));
        if (i != null && i['_id'] != null) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('Aid', i['_id']);
        }
      }
      return Allaplicant3;
      // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  List<AllAplicant> Allaplicant = [];
  Future<List<AllAplicant>?> getallApplicant() async {
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
        Allaplicant.add(AllAplicant.fromJson(i));
        if (i != null && i['id'] != null) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('Aid', i['id']);
        }
      }
      return Allaplicant;
      // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  @override
  final List<String> imageList = [
    'images/company1.png',
    'images/company2.png',
    'images/company3.png',
  ];
  int currentindex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Center(
                        child: CarouselSlider(
                          items: imageList
                              .map(
                                (e) => Center(
                                  child: Container(
                                    color: Colors.white,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: AssetImage(e),
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                              initialPage: 0,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 20),
                              enlargeCenterPage: true,
                              enlargeFactor: 0.9,
                              onPageChanged: (value, _) {
                                setState(() {
                                  currentindex = value;
                                });
                              }),
                        ),
                      ),
                      buildCarouslIndicator()
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Recommended Section
                  const Text(
                    "Applicant",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildRecommendedJobsList(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
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
                    "More Applicant",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    ));
  }

  buildCarouslIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imageList.length; i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: i == currentindex ? 7 : 5,
            width: i == currentindex ? 7 : 5,
            decoration: BoxDecoration(
                color: i == currentindex ? Colors.black : Colors.grey,
                shape: BoxShape.circle),
          )
      ],
    );
  }

  _buildRecommendedJobsList() {
    return Column(children: [
      FutureBuilder(
        future: getallApplicant3(),
        builder: (context, AsyncSnapshot<List<ThreeAplicant>?> snapshot) {
          if (!snapshot.hasData) {
            return Text("Data Not Found");
          } else {
            return SizedBox(
              height: 380,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String Aid = sp.getString('Aid')!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Applicantdetail(
                                      id: Aid,
                                    )));
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
                                      child: Icon(Icons.person),
                                    )),
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
                                    Text(
                                      Allaplicant3[index].userName.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Icon(Icons.bookmark_border, size: 30, color: linkedInMediumGrey86888A,)
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  Allaplicant3[index].category.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Allaplicant3[index].city.toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Allaplicant3[index].phoneNumber.toString(),
                                  style: TextStyle(fontSize: 10),
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
                  }),
            );
          }
        },
      ),
    ]);
  }

  _buildMoreJobsForYouList() {
    return Column(
      children: [
        FutureBuilder(
          future: getallApplicant(),
          builder: (context, AsyncSnapshot<List<AllAplicant>?> snapshot) {
            if (!snapshot.hasData) {
              return Text("Data Not Found");
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: Allaplicant.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String Aid = sp.getString('Aid')!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Applicantdetail(
                                      id: Aid,
                                    )));
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
                                        child: Icon(Icons.person))),
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
                                    Text(
                                      Allaplicant[index].userName.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //  Icon(Icons.bookmark_border, size: 30, color: linkedInMediumGrey86888A,)
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  Allaplicant[index].category.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Allaplicant[index].city.toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Allaplicant[index].phoneNumber.toString(),
                                  style: TextStyle(fontSize: 10),
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
