import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jobleapconnectnew/pages/auth/sign_in_page.dart';
import 'package:jobleapconnectnew/pages/auth/sign_up_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final List<String> imageList = [
    'images/main1.png',
    'images/main2.png',
    'images/main3.png',
  ];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0XFF5e4b75),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          height: 50,
                          width: 50,
          
                          image: AssetImage('images/img.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('JobLeap',
                                  style: TextStyle(fontSize: 30,
                                      fontFamily: 'Rubik Medium',
                                      color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Text('Connect',
                                  style: TextStyle(fontSize: 30,
                                      fontFamily: 'Rubik Medium',
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('your Gateway to Opportunities',style: TextStyle(fontSize: 14,
                            fontFamily: 'Rubik Medium',
                            color: Colors.white),)
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20,),
              Container(
                decoration:
          
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Center(
                      child: CarouselSlider(
                        items: imageList
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Container(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image(
                                              image: AssetImage(e),
                                              fit: BoxFit.contain,
                                            )),
                                      ),
                                    ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: true,
                          enlargeFactor: 0.9,
                          onPageChanged: (value,_){
                            setState(() {
                              currentindex= value;
                            });
                          }
                        ),
                      ),
                    ),
                    buildCarouslIndicator()
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('Finding The Right Job Made\n Easy With JobLeap', style: TextStyle(fontSize: 24,
                fontFamily: 'Rubik Medium',)),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ButtonContainerWidget(
                  title: "Sign Up",
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SignUpPage()), (route) => false,);
          
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SignInPage()), (route) => false,);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: linkedInBlue0077B5),
                  ),
                ),
              )
          
          
            ],
          ),
        ),

      ),
    );

  }
  buildCarouslIndicator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i=0; i<imageList.length ;i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: i== currentindex?7:5,
            width:i== currentindex?7:5,
          decoration: BoxDecoration(
            color: i== currentindex ? Colors.black:Colors.grey,
            shape: BoxShape.circle
          ),
          )
      ],
    );
  }

}
