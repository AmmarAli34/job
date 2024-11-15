import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/pages/auth/sign_in_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  TextEditingController sec = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  void forget(
    String Phone,
    String Sec,
    String Pass,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode(
        {"phoneNumber": Phone, "securityStatement": Sec, "password": Pass});
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
        Fluttertoast.showToast(msg: 'Forget successful');
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
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 5, left: 7),
                        child: Text('Forget  Page',
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
                        title: "Forget",
                        onTap: () {
                          forget(
                            phone.text.toString(),
                            sec.text.toString(),
                            pass.text.toString(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: "Already have Password ",
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
