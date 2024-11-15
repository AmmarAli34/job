import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobleapconnectnew/jobprivider/Mypostedjob/mypostedjob.dart';
import 'package:jobleapconnectnew/jobprivider/jobpostpage/jobpostpage.dart';
import 'package:jobleapconnectnew/main.dart';
import 'package:jobleapconnectnew/theme/styles.dart';


class CreatePage extends StatefulWidget {
  final VoidCallback? onCloneClickListener;
  const CreatePage({Key? key, required this.onCloneClickListener})
      : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 150,
          decoration:
          const BoxDecoration(color: linkedInWhiteFFFFFF, boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                color: linkedInLightGreyCACCCE,
                blurRadius: 5,
                spreadRadius: 0.1),
          ]),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>myjobs()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _jobsTopItems(title: "My jobs", icon: Icons.bookmark_border),

                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>jobpostpage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _jobsTopItems(title: "Post a job", icon: FontAwesomeIcons.edit),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _jobsTopItems({String? title, IconData? icon}) {
    return Row(
      children: [
        Icon(icon, size: 30, color: linkedInMediumGrey86888A,),
        const SizedBox(width: 10,),
        Text("$title", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
      ],
    );
  }
}
