import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobleapconnectnew/pages/main/Search/search_page.dart';
import 'package:jobleapconnectnew/pages/main/jobs/jobs_page.dart';
import 'package:jobleapconnectnew/pages/main/main_page/widgets/app_bar_widget.dart';
import 'package:jobleapconnectnew/pages/main/main_page/widgets/drawer_widget.dart';
import 'package:jobleapconnectnew/theme/styles.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
          return const JobsPage();
        }

      case 1:
        {
          return const search_page();
        }
    }
  }
}
