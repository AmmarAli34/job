
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobleapconnectnew/jobprivider/Search/search_page.dart';
import 'package:jobleapconnectnew/jobprivider/home_page/home_page.dart';
import 'package:jobleapconnectnew/jobprivider/home_page/widgets/app_bar_widgetp.dart';
import 'package:jobleapconnectnew/jobprivider/home_page/widgets/drawer_widget.dart';
import 'package:jobleapconnectnew/pages/main/create/create_page.dart';
import 'package:jobleapconnectnew/theme/styles.dart';



class pMainPage extends StatefulWidget {
  const pMainPage({super.key});

  @override
  State<pMainPage> createState() => _MainPageState();
}

class _MainPageState extends State<pMainPage> {

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      key: _scaffoldState,
        appBar: _currentPageIndex == 4? appBarWidget(
            context,
            title: "Search Jobs",
            isJobsTab: true,
            onLeadingTapClickListener: () {
              setState(() {
                _scaffoldState.currentState!.openDrawer();
              });
            }
        ) :appBarWidget(
            context,
            title: "Search",
            isJobsTab: false,
            onLeadingTapClickListener: () {
              setState(() {
                _scaffoldState.currentState!.openDrawer();
              });
            }
        ),
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
            icon: Icon(CupertinoIcons.house_fill),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.add),
            label: "Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
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
          return const provider_main_page();
        }

     case 1:
        {
          return CreatePage(onCloneClickListener: () {
            Navigator.pop(context);
            setState(() {
              _currentPageIndex = 0;
            });
          },);
        }

      case 2:
        {
          return const psearch_page();
        }
    }
  }
}
