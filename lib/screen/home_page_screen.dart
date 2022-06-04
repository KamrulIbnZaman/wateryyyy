import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import '../main.dart';
import '../providers/setting_data.dart';
import '../widgets/drawer.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    final sdata = Provider.of<SettingData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(foregroundColor: sdata.warningColor,
        title: Text('Stay  Watery',textAlign: TextAlign.center,),
      ),
      drawer: AppDrawer(sdata.warningColor),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [
              sdata.warningColor,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundColor: sdata.warningColor,
              child: Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(160),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.glassWater
                        ,
                        size: 100,
                        color: sdata.warningColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          child: Text(
                            '${sdata.drunkCount}/${sdata.glassAmount}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: sdata.warningColor,
        child: Icon(
          sdata.drunkCount < sdata.glassAmount ? Icons.add : Icons.done,
        ),
        onPressed: () {
          scheduleAlarm();
          if (sdata.drunkCount < sdata.glassAmount) {
            setState(() {
              sdata.addAGlass();
            });
          }

        },
      ),
    );
  }

  void scheduleAlarm() async {
var scheduledNotificationDateTime=DateTime.now().add(Duration(seconds: 5));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'water_glass',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('water_glass'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        // sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', 'alarmInfo.title',
        scheduledNotificationDateTime, platformChannelSpecifics);
  }
}
