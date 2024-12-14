import 'package:contini_statisticini/screens/counter_details.dart';
import 'package:contini_statisticini/models/counter.dart';
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

    Box<Counter> countersBox = Hive.box<Counter>('counters');

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Conticini Statisticini'),
            ),
            body: ValueListenableBuilder(
                valueListenable: countersBox.listenable(),
                builder: (context, Box<Counter> box, _) {
                    box.delete(1);
                    if (box.isEmpty) {
                        return const Center(child: Text("No counters yet!\n Create a new counter!"));
                    }
                    return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                            final counter = box.getAt(index);
                            return ListTile(
                                title: Text(counter!.name, style: const TextStyle(fontSize: 20.0)),
                                subtitle: Text('Details: ${counter.detailCount}'),
                                trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                        children: [               
                                            IconButton(onPressed: () { 
                                                box.putAt(index, Counter(
                                                    id: counter.id,
                                                    name: counter.name,
                                                    detailCount: counter.detailCount + 1));
                                            },
                                                    icon: const Icon(Icons.plus_one), ),
                                            IconButton(onPressed: () { },
                                                    icon: const Icon(Icons.add), ),
                                        ],),
                                ),
                                tileColor: Colors.amber[300],
                                onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CounterDetails(id: counter.id)));
                                },
                            );
                        }
                    );
                }
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    showDialog(
                        context: context, 
                        builder: (context) {
                        return AlertDialog(
                            title: const Text('Add Counter'),
                            content: TextField(
                            decoration: const InputDecoration(hintText: 'Enter counter name'),
                            onChanged: (value) {
                                // save the input value
                            },
                            ),
                            actions: [
                            TextButton(
                                onPressed: () {
                                Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                            ),
                            TextButton(
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                                child: const Text('Add'),
                            )
                            ],
                        );
                        },
                    );
                },
                label: const Text('Counter', style: TextStyle(fontSize: 18.0)),
                icon: const Icon(Icons.plus_one_sharp)
            ),
        );
    }
    }
