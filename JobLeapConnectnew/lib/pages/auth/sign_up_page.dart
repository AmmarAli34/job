import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobleapconnectnew/pages/auth/sign_in_page.dart';
import 'package:jobleapconnectnew/pages/main/main_page/main_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController sec = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  String city = 'Select City';
  String cata = 'Catagory';

  void signUp(
    String Name,
    String Email,
    String Sec,
    String Phone,
    String Pass,
    String City,
    String Cata,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({
      "userName": Name,
      "email": Email,
      "password": Pass,
      "phoneNumber": Phone,
      "city": City,
      "category": Cata,
      "securityStatement": Sec,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Decode the response body
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      // Check if token exists and is not null
      if (data != null && data['token'] != null) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.setString('token', data['token']);
        Fluttertoast.showToast(msg: 'Sign in successful');

        // Navigate to MainPage only after token is stored
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MainPage()),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'Token not found');
      }
    } else {
      // Retrieve and display error message only once
      final errorMessage = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: errorMessage);
      print(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Color(0XFF5e4b75)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, bottom: 5, left: 7),
                        child: Text('Sign Up Page',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Rubik Medium',
                              color: Colors.white,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1.0),
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
                          )
                        ],
                      )
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Enter your Name or Company Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email or CNIC",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phone,
                        decoration: InputDecoration(
                            hintText: "Phone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: sec,
                        decoration: InputDecoration(
                            hintText: "Security Question",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black54)),
                              width: 180,
                              height: 50,
                              child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(5),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text('$cata'),
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
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black54)),
                              width: 180,
                              height: 50,
                              child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(5),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text('$city              '),
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: pass,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonContainerWidget(
                        title: "Signup",
                        onTap: () {
                          signUp(
                              name.text.toString(),
                              email.text.toString(),
                              sec.text.toString(),
                              phone.text.toString(),
                              pass.text.toString(),
                              city,
                              cata);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: "Already on JobLeap Connect? ",
                              style: TextStyle(
                                  color: linkedInBlack000000, fontSize: 16),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SignInPage()),
                                          (route) => false,
                                        );
                                      },
                                    text: "Sign in",
                                    style: TextStyle(
                                        color: linkedInBlue0077B5,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ]),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
