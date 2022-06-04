import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:workmanager/workmanager.dart';



import './screen/intro_screen.dart';

import './providers/setting_data.dart';
import './screen/settings_screen.dart';
import './screen/home_page_screen.dart';
import 'screen/about_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//     print('');
//     return Future.value(true);
//   });
// }

void main() async{

 WidgetsFlutterBinding.ensureInitialized();
//  Workmanager().initialize(() {
//   Workmanager().executeTask((taskName, inputData) async {
//     print('');
//     return Future.value(true);
//   });
// });

// Workmanager().registerPeriodicTask('uniqueName', 'taskName',);



  var initializationSettingsAndroid =
      AndroidInitializationSettings('water_glass');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingData(),
        ),
        // ChangeNotifierProxyProvider<Auth, Products>(
        //   create: (context)=>Products('sddf',''),
        //   update: (context, auth, previousProducts) => Products(
        //     auth.token as String,
        //     auth.userId as String,
        //   ),
        // ),
        // ChangeNotifierProvider(
        //   create: (ctx) => Cart(),
        // ),
        // ChangeNotifierProxyProvider<Auth, Order>(
        //   create: (context)=>Order('','',[]),
        //   update: (context, auth, prevOrder) => Order(
        //     auth.token as String,
        //     auth.userId as String,
        //     prevOrder == null ? [] : prevOrder.order,
        //   ),
        // )
      ],
      child: Consumer<SettingData>(
          builder: (ctx, setting, _) => MaterialApp(
                title: 'Watery',
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    foregroundColor: setting.warningColor,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  accentColor: Colors.blueAccent,
                ),
                home: FutureBuilder(
                  future: setting.getSettingData(),
                  builder: (context, snapshot) => HomePage(snapshot),
                ),
                routes: {
                  SettingsScreen.routeName: (ctx) => SettingsScreen(),
                  AboutScreen.routeName: (ctx) => AboutScreen(),
                 },
              )),
    );
  }
}

class HomePage extends StatefulWidget {
  AsyncSnapshot snapshot;
  HomePage(this.snapshot);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isItDone = false;

  void changeScreen() {
    if (!isItDone) {
      setState(() {
        isItDone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.connectionState == ConnectionState.waiting) {
      return IntroScreen();
    }
    if (!isItDone && widget.snapshot.data) {
      return SettingsScreen(changeScreen);
    }
    return HomePageScreen();
  }
}
