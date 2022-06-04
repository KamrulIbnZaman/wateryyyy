import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About this app!'),
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'As a developer this is my first app. Hope you like it! \n\n\nIf you like the app please share and rate! ',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'The data about the amount of water needed is collectet from here, please read the information provided there carefully before following the apps instruction. I won\'t be able to take any responsibility if any complications arise from following the apps intruction, follow it with your own accord',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
