import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobleapconnectnew/jobprivider/Search/search_page.dart';
import 'package:jobleapconnectnew/jobprivider/home_page/widgets/drawer_widget.dart';
import 'package:jobleapconnectnew/pages/main/create/create_page.dart';

import 'package:jobleapconnectnew/theme/styles.dart';



class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        key: _scaffoldState,

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedItemColor: linkedInBlack000000,
          selectedLabelStyle: const TextStyle(color: linkedInBlack000000),
          unselectedItemColor: linkedInMediumGrey86888A,
          unselectedLabelStyle: const TextStyle(color: linkedInMediumGrey86888A),
          showUnselectedLabels: true,
          items: const [

            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                size: 30,
              ),
              label: "Post Job",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: "Search",
            ),


          ],
        ),
        body: _switchPages(_currentPageIndex)
    );
  }

  _switchPages(int index) {
    switch (index) {
      case 0:
        {
          return CreatePage(onCloneClickListener: () {
            Navigator.pop(context);
            setState(() {
              _currentPageIndex = 0;
            });
          },);
        }
      case 1:
        {
          return const psearch_page();
        }



    };
  }
}



