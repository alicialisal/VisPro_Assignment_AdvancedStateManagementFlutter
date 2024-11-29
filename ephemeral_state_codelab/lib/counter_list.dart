import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:provider/provider.dart';

class CounterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        final item = globalState.counters.removeAt(oldIndex);
        final color = globalState.colors.removeAt(oldIndex);
        globalState.counters.insert(newIndex, item);
        globalState.colors.insert(newIndex, color);
        globalState.notifyListeners();
      },
      children: List.generate(
        globalState.counters.length,
        (index) => CounterItem(
          key: ValueKey(index),
          index: index,
        ),
      ),
    );
  }
}


class CounterItem extends StatelessWidget {
  final int index;
  final Key? key; // Tambahkan properti key

  CounterItem({required this.index, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return Card(
      color: globalState.colors[index],
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: globalState.colors[index],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Counter ${index + 1}: ${globalState.counters[index]}'),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => _showSettingsDialog(context, index),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => globalState.decrementCounter(index),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => globalState.incrementCounter(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => globalState.removeCounter(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context, int index) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        Color selectedColor = globalState.colors[index];
        return AlertDialog(
          title: Text('Edit Counter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Change Color:'),
              Wrap(
                spacing: 5,
                children: Colors.primaries.map((color) {
                  return GestureDetector(
                    onTap: () => selectedColor = color,
                    child: Container(
                      width: 30,
                      height: 30,
                      color: color,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                globalState.changeColor(index, selectedColor);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
