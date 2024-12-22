import 'package:contini_statisticini/screens/counter_details.dart';
import 'package:contini_statisticini/models/counter.dart';
import 'package:contini_statisticini/ui_utils/buttonAddCounter.dart';
import 'package:contini_statisticini/ui_utils/createCounterModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainHomeScaffold();
  }
}

class MainHomeScaffold extends StatelessWidget {
  final Box<Counter> _countersBox = Hive.box<Counter>('counters');

  @override
  Widget build(BuildContext context) {
    // Manually add line
    // _countersBox.add(new Counter(id: 0, name: 'Seghe', detailCount: 15));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contini Statisticini'),
      ),
      body: ValueListenableBuilder(
          valueListenable: _countersBox.listenable(),
          builder: (context, Box<Counter> box, _) {
            if (box.isEmpty) {
              return const Center(
                  child: Text("No counters yet!\n Create a new counter!"));
            }
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final counter = box.getAt(index);
                    return ListTile(
                      title: Text(counter!.name,
                          style: const TextStyle(fontSize: 20.0)),
                      subtitle: Text('Details: ${counter.detailCount}'),
                      trailing: TrailerButtonContainer(
                          requiredAdditionalData:
                              counter.requiredAdditionalData,
                          box: box,
                          counter: counter),
                      tileColor: Colors.amber[300],
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CounterDetails(id: counter.id)));
                      },
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CreateCounterModel(
                    id: _countersBox.length, countersBox: _countersBox);
              },
            );
          },
          label: const Text('Counter', style: TextStyle(fontSize: 18.0)),
          icon: const Icon(Icons.plus_one_sharp)),
    );
  }
}
