import 'package:contini_statisticini/models/counter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class CreateCounterModel extends StatefulWidget {
  final int id;
  final Map<String, dynamic> dynamicFields;
  final Box<Counter> countersBox;
  CreateCounterModel({Key? key, required this.id, required this.countersBox})
      : dynamicFields = {
          'id': id,
          'name': "",
          'data': <Map>[],
        },
        super(key: key);

  @override
  State<CreateCounterModel> createState() => _CreateCounterModelState();
}

class _CreateCounterModelState extends State<CreateCounterModel> {
  final GlobalKey<FormState> _createModalKey = GlobalKey<FormState>();

  void _addField() {
    setState(() {
      widget.dynamicFields['data'].add({
        'fieldname': '',
        'fieldtype': '',
        'required': false,
        'values': <String>[],
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

  void _createCounter() async {
    if (_createModalKey.currentState!.validate()) {
      _createModalKey.currentState!.save();
      String uniqueId = Uuid().v1();
      await widget.countersBox.put(
          uniqueId,
          Counter(
              id: uniqueId,
              name: widget.dynamicFields['name'],
              properties: widget.dynamicFields['data']));
      Navigator.of(context).pop();
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
                widget.dynamicFields['data'].length != 0
                    ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Required \n Fields",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ])
                    : SizedBox.shrink(),

                // Constraining the ListView.builder
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 550, // Set a maximum height for the list
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), // Smooth scrolling
                    itemCount: widget.dynamicFields['data'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
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
                                      setState(() {
                                        widget.dynamicFields['data'][index]
                                            ['fieldtype'] = value;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? "You must choose a type for the field"
                                        : null,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Checkbox(
                                    value: widget.dynamicFields['data'][index]
                                        ['required'],
                                    onChanged: (value) {
                                      setState(() {
                                        widget.dynamicFields['data'][index]
                                            ['required'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              children: [
                                widget.dynamicFields['data'][index]
                                            ['fieldtype'] ==
                                        "Set di valori"
                                    ? MultiSelectForm(
                                        dynamicFields: widget.dynamicFields,
                                        index: index)
                                    : TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Field Name ${index + 1}',
                                        ),
                                        initialValue: '',
                                        onChanged: (value) {
                                          widget.dynamicFields['data'][index]
                                              ['index'] = index;
                                          widget.dynamicFields['data'][index]
                                              ['fieldname'] = value;
                                        },
                                        validator: (value) {
                                          return value == null || value.isEmpty
                                              ? "This field cannot be empty"
                                              : null;
                                        },
                                      ),
                              ],
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

class MultiSelectForm extends StatefulWidget {
  late List<String> values;
  final Map<String, dynamic> dynamicFields;
  final int index;
  MultiSelectForm(
      {super.key, required this.dynamicFields, required this.index}) {
    values = dynamicFields['data'][index]['values'];
  }
  @override
  _MultiSelectFormState createState() => _MultiSelectFormState();
}

class _MultiSelectFormState extends State<MultiSelectForm> {
  final TextEditingController _controller = TextEditingController();

  void _addValue(String value) {
    if (value.isNotEmpty && !widget.values.contains(value)) {
      var values = value.split(',');
      setState(() {
        for (String val in values) {
          widget.values.add(val.trim());
        }
      });
      _controller.clear(); // Clear the input box
    }
  }

  void _removeValue(String value) {
    setState(() {
      widget.values.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Field Name ${widget.index + 1}',
                ),
                initialValue: '',
                onChanged: (value) {
                  widget.dynamicFields['data'][widget.index]['index'] =
                      widget.index;
                  widget.dynamicFields['data'][widget.index]['fieldname'] =
                      value;
                },
                validator: (value) {
                  return value == null || value.isEmpty
                      ? "This field cannot be empty"
                      : null;
                },
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted:
                    _addValue, // Add value when 'Enter' is pressed
                decoration: InputDecoration(
                  labelText: 'Enter values',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return widget.values.isEmpty
                      ? 'You must enter some values'
                      : null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        // Wrap widget to display chips
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.values.map((value) {
            return Chip(
              label: Text(value),
              deleteIcon: Icon(Icons.close),
              onDeleted: () => _removeValue(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
