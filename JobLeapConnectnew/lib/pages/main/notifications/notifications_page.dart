import 'package:flutter/material.dart';
import 'package:jobleapconnectnew/theme/styles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: linkedInColor,
          title: Text(
            'Notification Screen',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return _singleNotificationWidget();
                    })
              ],
            ),
          ),
        ));
  }

  _singleNotificationWidget() {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    "images/profile.JPEG",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          title: Text(
            "Ammar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Notification",
            style: TextStyle(color: linkedInMediumGrey86888A),
          ),
          trailing: Icon(Icons.delete),
        ),
      ),
    );
  }
}
