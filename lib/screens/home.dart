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
  final Box<Counter> _countersBox = Hive.box<Counter>('counters');

  @override
  Widget build(BuildContext context) {
    // Manually add line
    // _countersBox.add(new Counter(id: 0, name: 'Seghe', detailCount: 15));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conticini Statisticini'),
      ),
      body: ValueListenableBuilder(
          valueListenable: _countersBox.listenable(),
          builder: (context, Box<Counter> box, _) {
            if (box.isEmpty) {
              return const Center(
                  child: Text("No counters yet!\n Create a new counter!"));
            }
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final counter = box.getAt(index);
                  return ListTile(
                    title: Text(counter!.name,
                        style: const TextStyle(fontSize: 20.0)),
                    subtitle: Text('Details: ${counter.detailCount}'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              box.putAt(
                                  index,
                                  Counter(
                                      id: counter.id,
                                      name: counter.name,
                                      detailCount: counter.detailCount + 1));
                            },
                            icon: const Icon(Icons.plus_one),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    tileColor: Colors.amber[300],
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CounterDetails(id: counter.id)));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return _CreateCounterModel(id: _countersBox.length + 1);
              },
            );
          },
          label: const Text('Counter', style: TextStyle(fontSize: 18.0)),
          icon: const Icon(Icons.plus_one_sharp)),
    );
  }
}

class _CreateCounterModel extends StatefulWidget {
  final int id;
  final Map<String, dynamic> dynamicFields = {'id': 0, 'name': "", 'data': []};
  _CreateCounterModel({Key? key, required this.id}) : super(key: key) {
    final Map<String, dynamic> dynamicFields = {
      'id': this.id,
      'name': "",
      'data': List<Map<String, dynamic>>,
    };
  }

  @override
  State<_CreateCounterModel> createState() => __CreateCounterModelState();
}

class __CreateCounterModelState extends State<_CreateCounterModel> {
  final GlobalKey<FormState> _createModalKey = GlobalKey<FormState>();

  void _addField() {
    setState(() {
      widget.dynamicFields['data'].add({
        'fieldname': '',
        'fieldtype': '',
        'required': ''
      }); // Add a new empty field.
    });
  }

  void _removeField() {
    setState(() {
      if (widget.dynamicFields['data'].length > 0) {
        widget.dynamicFields['data'].removeLast(); // Add a new empty field.
      }
    });
  }

  void _createCounter() {
    if (_createModalKey.currentState!.validate()) {
      _createModalKey.currentState!.save();
      print(widget.dynamicFields);
      Navigator.of(context).pop();
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createModalKey,
      child: AlertDialog(
        title: const Text('Add Your Custom Counter!'),
        content: SizedBox(
          width: double
              .maxFinite, // Ensures the dialog content can take full width
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.purple,
                      fontSize: 17,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w200,
                    ),
                    label: Text("Counter Name"),
                  ),
                  onSaved: (value) {
                    widget.dynamicFields['name'] = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You must provide a counter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Adds spacing between fields
                // Constraining the ListView.builder
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 250, // Set a maximum height for the list
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), // Smooth scrolling
                    itemCount: widget.dynamicFields['data'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Field Name ${index + 1}',
                                ),
                                initialValue: '',
                                onChanged: (value) {
                                  widget.dynamicFields['data'][index]['index'] =
                                      index;
                                  widget.dynamicFields['data'][index]
                                      ['fieldname'] = value;
                                },
                                validator: (value) {
                                  value == null || value.isEmpty
                                      ? "This field cannot be empty"
                                      : null;
                                },
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Field type',
                                ),
                                items: [
                                  "Numero Intero",
                                  "Testo",
                                  "Data",
                                  "Set di valori"
                                ]
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  widget.dynamicFields['data'][index]
                                      ['fieldtype'] = value;
                                },
                                validator: (value) => value == null
                                    ? "You must choose a type for the field"
                                    : null,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: CheckboxListTile(
                                value: true,
                                onChanged: (value) {
                                  widget.dynamicFields['data'][index]
                                      ['required'] = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  TextButton.icon(
                    onPressed: _removeField,
                    label: Text('Delete Field'),
                    icon: Icon(Icons.delete),
                  ),
                  TextButton(
                    onPressed: _addField,
                    child: const Text("Add Field"),
                  ),
                ]),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: _createCounter,
            child: const Text('Create Counter'),
          ),
        ],
      ),
    );
  }
}
