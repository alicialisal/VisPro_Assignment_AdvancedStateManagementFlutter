import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:provider/provider.dart';

import 'counter_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(), // Instantiate the GlobalState class here
      child: MyGlobalApp(),
    ),
  );
}

class MyGlobalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Global State Example')),
        body: CounterList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add a new counter
            Provider.of<GlobalState>(context, listen: false).addCounter();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
