import 'package:flutter/material.dart';
import '../providers/setting_data.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings';
  Function? saveChanges;

  SettingsScreen([this.saveChanges]);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String gender = 'Male';
  int startHour = 6;
  int endHour = 21;

  String get endHour12 {
    if (endHour == 22) {
      return '10 pm';
    }
    if (endHour == 21) {
      return '09 pm';
    }
    if (endHour == 23) {
      return '11 pm';
    }
    if (endHour == 59) {
      return '12 am';
    }
    return '09 pm';
  }

  List<PopupMenuEntry<dynamic>> get morningTimeOptions {
    return [
      PopupMenuItem(
        child: const Text(
          '05 am',
          style: TextStyle(fontSize: 20),
        ),
        value: 5,
      ),
      PopupMenuItem(
        child: const Text(
          '06 am',
          style: TextStyle(fontSize: 20),
        ),
        value: 6,
      ),
      PopupMenuItem(
        child: const Text(
          '07 am',
          style: TextStyle(fontSize: 20),
        ),
        value: 7,
      ),
      PopupMenuItem(
        child: const Text(
          '08 am',
          style: TextStyle(fontSize: 20),
        ),
        value: 8,
      ),
      PopupMenuItem(
        child: const Text(
          '09 am',
          style: TextStyle(fontSize: 20),
        ),
        value: 9,
      ),
      PopupMenuItem(
        child: const Text(
          '10 am',
          style: TextStyle(fontSize: 20),
        ),
        value: 10,
      ),
    ];
  }

  List<PopupMenuEntry<dynamic>> get nightTimeOptions {
    return [
      PopupMenuItem(
        child: Text(
          '09 pm',
          style: TextStyle(fontSize: 20),
        ),
        value: 21,
      ),
      PopupMenuItem(
        child: Text(
          '10 pm',
          style: TextStyle(fontSize: 20),
        ),
        value: 22,
      ),
      PopupMenuItem(
        child: Text(
          '11 pm',
          style: TextStyle(fontSize: 20),
        ),
        value: 23,
      ),
      PopupMenuItem(
        child: Text(
          '12 pm',
          style: TextStyle(fontSize: 20),
        ),
        value: 59,
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final setData = Provider.of<SettingData>(context, listen: false);
    return Scaffold(
      appBar: setData.goSetting
          ? null
          : AppBar(
              title: const Text(
                'Settings',
                // style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
      // backgroundColor: Colors.grey,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: 10, right: 10, left: 10, top: setData.goSetting ? 40 : 10),
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: const Text(
                            'Gender :',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(),
                        PopupMenuButton(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Text(
                                    gender,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                          ),
                          onSelected: (value) {
                            setState(() {
                              gender = value as String;
                            });
                          },
                          itemBuilder: (ctx) => [
                            PopupMenuItem(
                              child: Text('Male'),
                              value: 'Male',
                            ),
                            PopupMenuItem(
                              child: Text('Female'),
                              value: 'Female',
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: const Text(
                            'Timeframe :',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Spacer(),
                        PopupMenuButton(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(children: [
                                Text(
                                  '$startHour am',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(Icons.keyboard_arrow_down)
                              ]),
                            ),
                          ),
                          onSelected: (value) {
                            setState(() {
                              startHour = value as int;
                            });
                          },
                          itemBuilder: (ctx) => morningTimeOptions,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: const Text(
                            'to',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        PopupMenuButton(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(children: [
                                Text(
                                  endHour12,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(Icons.keyboard_arrow_down)
                              ]),
                            ),
                          ),
                          onSelected: (value) {
                            setState(() {
                              endHour = value as int;
                            });
                          },
                          itemBuilder: (ctx) => nightTimeOptions,
                        ),
                      ],
                    ),
                  ]),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setData.saveChanges(gender, startHour, endHour);
                    widget.saveChanges!();
                  },
                  child: Text(setData.goSetting ? 'set' : 'save changes'),
                  style: ButtonStyle(),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       label: 'Save changes',
      //     ),
      //   ],
      //   onTap: (_) {},
      // ),
    );
  }
}
