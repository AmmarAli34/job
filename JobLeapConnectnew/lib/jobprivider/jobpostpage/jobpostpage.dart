import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class jobpostpage extends StatefulWidget {
  const jobpostpage({super.key});

  @override
  State<jobpostpage> createState() => _jobpostpageState();
}

class _jobpostpageState extends State<jobpostpage> {
  TextEditingController detail = TextEditingController();
  TextEditingController pay = TextEditingController();
  String cata = 'Title';
  String city = 'City';

  void Post(
    String Detail,
    String Pay,
    String City,
    String Cata,
  ) async {
    if (City.isEmpty || City == "City" || Cata.isEmpty || Cata == "Title") {
      Fluttertoast.showToast(msg: "Please select a valid City and Title.");
      return;
    }

    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    if (token == null) {
      Fluttertoast.showToast(msg: "Authentication token not found.");
      return;
    }

    var headers = {'token': token};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "city": City,
      "jobTitle": Cata,
      "jobExplanation": Detail,
      "price": Pay
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Successfully posted");
    } else {
      String responseBody = await response.stream.bytesToString();
      print('Error: $responseBody'); // Logs exact backend response
      Fluttertoast.showToast(msg: responseBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5e4b75),
        title: Text('Job Post Page',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Rubik Medium',
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, bottom: 5, left: 7),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white)),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                height: 80,
                                image: AssetImage('images/img.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black54)),
                        width: 367,
                        height: 55,
                        child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(5),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                  '$cata                                           '),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black54)),
                        height: 55,
                        width: 367,
                        child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(5),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                  '$city                                                         '),
                            ),
                            items: <String>[
                              'Karachi',
                              'Lahore',
                              'Faisalabad',
                              'Rawalpindi',
                              'Gujranwala',
                              'Peshawar',
                              'Multan',
                              'Islamabad',
                              'Quetta',
                              'Sialkot',
                              'Bahawalpur',
                              'Hyderabad',
                              'Sargodha',
                              'Sukkur',
                              'Larkana',
                              'Sheikhupura',
                              'Gujrat',
                              'Sahiwal',
                              'Jhang',
                              'Mardan',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                city = value!;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: detail,
                        decoration: InputDecoration(
                            hintText: "Job details",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: pay,
                        decoration: InputDecoration(
                            hintText: "Pay",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ButtonContainerWidget(
                        title: "Submit",
                        onTap: () {
                          Post(detail.text.toString(), pay.text.toString(),
                              city, cata);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
