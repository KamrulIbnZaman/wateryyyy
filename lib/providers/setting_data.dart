import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class SettingData with ChangeNotifier {
  String? _gender=null;
  int _startHour = 06; 
  int _endHour = 21;
  bool _loadIntro = false;
  int drunkCount = 0;
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    // 'Channel for Alarm notification',
    icon: 'water_glass',
    // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
    largeIcon: DrawableResourceAndroidBitmap('water_glass'),
  );

  // DateTime _startingTime=DateTime(null,null,null,);

  int get glassAmount {
    if (_gender == 'Male') {
      return 16;
    }
    return 12;
  }

  bool get goSetting {
    return !_loadIntro;
  }

  Future<bool> getSettingData() async {
    Future.delayed(Duration(seconds: 1));
    final pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('userData')) {
      return true;
    }

    if (!pref.containsKey('drunkCount')) {
      return true;
    }


    final userData = json.decode(pref.getString('userData') as String) ;
    _gender = userData['gender'] as String;
    _startHour = userData['startHour'] as int;
    _endHour = userData['endHour'] as int;
    drunkCount = pref.getInt('drunkCount') as int;
    return false;
  }

  Future<void> saveChanges(
    String g,
    int s,
    int e,
  ) async {
    _gender = g;
    _startHour = s;
    _endHour = e;

    final pref = await SharedPreferences.getInstance();
    final userData = json.encode({
      'gender': g,
      'startHour': s,
      'endHour': e,
    });

    pref.setString('userData', userData);
    _loadIntro = true;
    drunkCount = 0;
  }

  Color get warningColor {
    if (drunkCount == 0) {
      return Colors.red;
    }
    if (glassAmount / drunkCount > 2.1) {
      return Colors.red;
    }
    if (glassAmount / drunkCount > 1) {
      return Colors.orange;
    }
     return Colors.lightGreen;
  }

  Future<void> addAGlass() async {
    if (drunkCount < glassAmount) {
      drunkCount++;
    }
    String saveCount = drunkCount.toString();
    print('${int.parse(saveCount)}');

    final pref = await SharedPreferences.getInstance();

    try {
      pref.setInt('drunkCount', drunkCount);
    } catch (er) {
      drunkCount--;
    }
  }

  void dailyNotify(FlutterLocalNotificationsPlugin FLNplugin) async {
    await FLNplugin.showDailyAtTime(
      0,
      'Watery',
      'Have a Wateryfull day!',
      daylytime(FLNplugin),
      NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
    );
    
  }

  Time daylytime(FlutterLocalNotificationsPlugin flnp) {
    HourlyNotif(flnp);

    return Time(_startHour);
  }

  void HourlyNotif(FlutterLocalNotificationsPlugin flnp) {
    flnp.periodicallyShow(
      001,
      'Watery',
      'Drink your water!',
      RepeatInterval.hourly,
      NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
    );
  }

  void cnacellingNotif(FlutterLocalNotificationsPlugin flnp) {}
}
