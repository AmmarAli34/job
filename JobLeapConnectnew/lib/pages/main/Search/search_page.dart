import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/Model/Sreach/Sreach.dart';
import 'package:jobleapconnectnew/jobprivider/jobdetail/jobdetail.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  String cata = 'Catagory';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get(cata);
    setState(() {});
  }

  List<Sreach> Search = [];
  Future<List<Sreach>?> get(String Cata) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var headers = {'token': token!};
    var request = http.Request('GET', Uri.parse('https://$Cata'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // We need to read the response and convert it into a string before parsing it
      var responseBody = await response.stream
          .bytesToString(); // Read the response body as a string
      var data = jsonDecode(responseBody); // Now decode the JSON string
      for (Map i in data) {
        Search.add(Sreach.fromJson(i));
      }
      return Search; // Assuming you have a fromJson method
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: linkedInLightGreyCACCCE.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                            '$cata                                                  '),
                      ),
                      items: <String>[
                        'Baby Caretaker',
                        'Chef',
                        'Construction Labour',
                        'Delivery Rider',
                        'Driver',
                        'Electricain',
                        'Factory Worker',
                        'Gardener',
                        'House Caretaker',
                        'House Cleaner',
                        'Office Boy',
                        'Other Labours',
                        'Plumber',
                        'Security Guard',
                        'Shop Assistant',
                        'Waiter',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          cata = value!;
                        });
                      }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: linkedInLightGreyCACCCE,
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
                            "jobs for you",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
          future: get(cata),
          builder: (context, AsyncSnapshot<List<Sreach>?> snapshot) {
            if (!snapshot.hasData) {
              return Text("Data Not Found");
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: Search.length,
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
                                      Search[index].jobTitle.toString(),
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
                                  Search[index].companyName.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  Search[index].city.toString(),
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
