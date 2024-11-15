import 'package:flutter/material.dart';
import 'package:jobleapconnectnew/widgets/button_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class jobdetails_page extends StatefulWidget {
  const jobdetails_page({super.key});

  @override
  State<jobdetails_page> createState() => _jobdetails_pageState();
}



class _jobdetails_pageState extends State<jobdetails_page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gett();
    getc();
    getd();
    getje();
    getn();
    getp();
    getrs();
  }
  String? Title;
  String? name;
  String? rs;
  String? city;
  String? about;
  String? phone;
  String? Date;

  void gett()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    Title=sp.getString('JT')!;
    print(Title);
  }
  void getn()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    name=sp.getString('CN')!;
  }
  void getrs()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    rs=sp.getString('RS')!;
  }
  void getc()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    city=sp.getString('CI')!;
  }
  void getje()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    about=sp.getString('JD')!;
  }
  void getp()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    phone=sp.getString('PH')!;
  }
  void getd()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    Date=sp.getString('DA')!;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5e4b75),
        title: Text('Job Detial Page',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Rubik Medium',
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0XFF475252)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("$Title",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontFamily: 'Rubik Medium',
                                                fontWeight: FontWeight.bold),
                                          ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border:
                                                Border.all(color: Colors.white)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child:CircleAvatar(
                                            child: Icon(Icons.home_work),
                                          )
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),

                                      Text(
                                        '$name',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Rubik Medium',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'on_sit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Rubik Medium',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'RS:$rs',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Rubik Medium',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('$city',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Rubik Medium',
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0XFF475252)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'About the job',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Rubik Medium',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$about',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Phone no',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Rubik Medium',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$phone',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Last Date',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Rubik Medium',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$Date',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ButtonContainerWidget(
                                  title: "Apply",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
