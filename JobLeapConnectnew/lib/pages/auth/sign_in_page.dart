import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jobleapconnectnew/pages/auth/Forget.dart';
import 'package:jobleapconnectnew/pages/auth/sign_up_page.dart';
import 'package:jobleapconnectnew/pages/main/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/styles.dart';
import '../../widgets/button_container_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  void Signin(
    String Phone,
    String Pass,
  ) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://'));
    request.body = json.encode({"phoneNumber": Phone, "password": Pass});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'signin Successfully');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
          (route) => false);

      // Decode the response body
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      // Check if token exists and is not null
      if (data != null && data['token'] != null) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('token', data['token']);
      }
    } else {
      Fluttertoast.showToast(msg: await response.stream.bytesToString());
      print(await response.stream.bytesToString());
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
                        child: Text('SignIn Page',
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
                        controller: pass,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(width: 1.0))),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forget()));
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: linkedInBlue0077B5),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ButtonContainerWidget(
                        title: "Sign In",
                        onTap: () {
                          Signin(phone.text.toString(), pass.text.toString());
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: linkedInMediumGrey86888A,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("or"),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: linkedInMediumGrey86888A,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: "New to JobLeap Connect? ",
                              style: TextStyle(
                                  color: linkedInBlack000000, fontSize: 16),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const SignUpPage()),
                                          (route) => false,
                                        );
                                      },
                                    text: "Join now",
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
