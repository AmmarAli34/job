import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/Model/alljob/AllJobs.dart';
import 'package:jobleapconnectnew/Model/job3/Threejob.dart';
import 'package:jobleapconnectnew/jobprivider/jobdetail/jobdetail.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjob3();
    getjoball();
    setState(() {});
  }

  List<Threejob> Alljobs3 = [];
  Future<List<Threejob>?> getjob3() async {
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
        Alljobs3.add(Threejob.fromJson(i));
      }
      return Alljobs3; // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  List<AllJobs> Alljobs = [];
  Future<List<AllJobs>?> getjoball() async {
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
        Alljobs.add(AllJobs.fromJson(i));
      }
      return Alljobs; // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  final List<String> imageList = [
    'images/applicant1.png',
    'images/applicant2.png',
    'images/applicant3.png',
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                width: double.infinity,
                height: 14,
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
                    // * Recommended Section
                    const Text(
                      "Recommended for you",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      "More jobs for you",
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
        future: getjob3(),
        builder: (context, AsyncSnapshot<List<Threejob>?> snapshot) {
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
                        sp.setString(
                            'CN', Alljobs3[index].companyName.toString());
                        sp.setString('JT', Alljobs3[index].jobTitle.toString());
                        sp.setString('RS', Alljobs3[index].price.toString());
                        sp.setString('CI', Alljobs3[index].city.toString());
                        sp.setString(
                            'JD', Alljobs3[index].jobExplanation.toString());
                        sp.setString(
                            'PH', Alljobs3[index].phoneNumber.toString());
                        sp.setString('DA', Alljobs3[index].date.toString());

                        setState(() {});

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
                                      child: Icon(Icons.home_work),
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
                                      Alljobs3[index].jobTitle.toString(),
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
                                  Alljobs3[index].companyName.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Alljobs3[index].city.toString(),
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
          future: getjoball(),
          builder: (context, AsyncSnapshot<List<AllJobs>?> snapshot) {
            if (!snapshot.hasData) {
              return Text("Data Not Found");
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: Alljobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setString(
                            'CN', Alljobs[index].companyName.toString());
                        sp.setString('JT', Alljobs[index].jobTitle.toString());
                        sp.setString('RS', Alljobs[index].price.toString());
                        sp.setString('CI', Alljobs[index].city.toString());
                        sp.setString(
                            'JD', Alljobs[index].jobExplanation.toString());
                        sp.setString(
                            'PH', Alljobs[index].phoneNumber.toString());
                        sp.setString('DA', Alljobs[index].date.toString());

                        setState(() {});
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
                                      child: Icon(Icons.home_work),
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
                                      Alljobs[index].jobTitle.toString(),
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
                                  Alljobs[index].companyName.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Alljobs[index].city.toString(),
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
