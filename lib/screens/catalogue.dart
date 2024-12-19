import 'package:flutter/material.dart';

class PaddingExamplesScaffold extends StatelessWidget {
    final List<Map<String, dynamic>> paddings = [
        {'name': '.symmetric(horizontal: 5.0, vertical: 9.0)', 'EdgeInsets': EdgeInsets.symmetric(horizontal: 5.0, vertical: 9.0)},
        {'name': '.all(12.0)', 'EdgeInsets': EdgeInsets.all(12.0)},
        {'name': '.zero', 'EdgeInsets': EdgeInsets.zero},
        {'name': '.only(left: 20.0, top: 6.0)', 'EdgeInsets': EdgeInsets.only(left: 20.0, top: 6.0)},
        {'name': '.fromLTRB(1.0, 2.0, 3.0, 4.0)', 'EdgeInsets': EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0)},
    ];

    @override
  Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            title: const Text('Paddings Examples'),
        ),
            body: ListView.builder(
                itemCount: paddings.length,
                itemBuilder: (context, index) {
                    final padding = paddings[index];
                    return ListTile(
                        contentPadding: const EdgeInsets.all(5.0),
                        title: Text(padding['name'], style: const TextStyle(fontSize: 20.0)),
                        trailing: Container(
                            padding: padding['EdgeInsets'],
                            color: Colors.grey[300],
                            child: const Text('hello'),
                        ),
                        tileColor: Colors.amber[300],
                    );
                },
            ),
        );
  }
}



class MainAxisAlignmentExamples extends StatelessWidget {
    final List<Map<String, dynamic>> alignments = [
    {'alignment': MainAxisAlignment.spaceBetween, 'label': 'MainAxisAlignment.spaceBetween'},
    {'alignment': MainAxisAlignment.spaceAround, 'label': 'MainAxisAlignment.spaceAround'},
    {'alignment': MainAxisAlignment.spaceEvenly, 'label': 'MainAxisAlignment.spaceEvenly'},
    {'alignment': MainAxisAlignment.center, 'label': 'MainAxisAlignment.center'},
    {'alignment': MainAxisAlignment.start, 'label': 'MainAxisAlignment.start'},
    {'alignment': MainAxisAlignment.end, 'label': 'MainAxisAlignment.end'},
  ];

    
    final List<Map<String, dynamic>> crossAxisAlignments = [
        {'label': 'CrossAxisAlignment.start', 'alignment': CrossAxisAlignment.start},
        {'label': 'CrossAxisAlignment.end', 'alignment': CrossAxisAlignment.end},
        {'label': 'CrossAxisAlignment.center', 'alignment': CrossAxisAlignment.center},
        {'label': 'CrossAxisAlignment.stretch', 'alignment': CrossAxisAlignment.stretch},
        {'label': 'CrossAxisAlignment.baseline', 'alignment': CrossAxisAlignment.baseline},
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            title: const Text('Cross Axis Alignment Examples'),
        ),
            body: ListView.builder(
                itemCount: crossAxisAlignments.length,
                itemBuilder: (context, index) {
                    final alignment = crossAxisAlignments[index];
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    alignment['label'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    color: Colors.grey[300],
                                    height: 50,
                                    child: Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: alignment['alignment'],
                                        children: const [
                                            Text(
                                            'Small',
                                            style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                            'Large',
                                            style: TextStyle(fontSize: 32),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                            'Baseline',
                                            style: TextStyle(fontSize: 24),
                                            ),
                                        ],
                                    ),
                                ),
                            ],
                        )
                    );
                },
            ),
        );
    }
}



class ButtonExamplesScaffold extends StatelessWidget{
    final List<Map<String, dynamic>> buttons = [
    {
        'name': 'ElevatedButton',
        'button': ElevatedButton(
        onPressed: () {
            // Action for ElevatedButton
        },
        child: const Text('Elevated Button'),
        ),
    },
    {
        'name': 'ElevatedButton.icon()',
        'button': ElevatedButton.icon(
        onPressed: () {
            // Action for ElevatedButton.icon
        },
        icon: const Icon(Icons.check),
        label: const Text('Elevated Icon'),
        ),
    },
    {
        'name': 'TextButton',
        'button': TextButton(
        onPressed: () {
            // Action for TextButton
        },
        child: const Text('Text Button'),
        ),
    },
    {
        'name': 'TextButton.icon()',
        'button': TextButton.icon(
        onPressed: () {
            // Action for TextButton.icon
        },
        icon: const Icon(Icons.info),
        label: const Text('Text Icon'),
        ),
    },
    {
        'name': 'OutlinedButton',
        'button': OutlinedButton(
        onPressed: () {
            // Action for OutlinedButton
        },
        child: const Text('Outlined Button'),
        ),
    },
    {
        'name': 'OutlinedButton.icon()',
        'button': OutlinedButton.icon(
        onPressed: () {
            // Action for OutlinedButton.icon
        },
        icon: const Icon(Icons.share),
        label: const Text('Outlined Icon'),
        ),
    },
    {
        'name': 'IconButton',
        'button': IconButton(
        onPressed: () {
            // Action for IconButton
        },
        icon: const Icon(Icons.star),
        ),
    },
    {
        'name': 'FloatingActionButton',
        'button': FloatingActionButton(
        onPressed: () {
            // Action for FloatingActionButton
        },
        child: const Icon(Icons.add),
        ),
    },
    {
        'name': 'FloatingActionButton.extended()',
        'button': FloatingActionButton.extended(
        onPressed: () {
            // Action for FloatingActionButton.extended
        },
        label: const Text('Extended FAB'),
        icon: const Icon(Icons.navigation),
        ),
    },
    {
        'name': 'DropdownButton',
        'button': DropdownButton<String>(
        value: 'Option 1',
        items: const [
            DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
            DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
            DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
        ],
        onChanged: (value) {
            // Handle change
        },
        ),
    },
    {
        'name': 'PopupMenuButton',
        'button': PopupMenuButton<String>(
        onSelected: (value) {
            // Action for selected menu item
        },
        itemBuilder: (context) => const [
            PopupMenuItem(value: 'Item 1', child: Text('Item 1')),
            PopupMenuItem(value: 'Item 2', child: Text('Item 2')),
        ],
        ),
    },
    ];

    @override
    Widget build(BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                title: const Text('Buttons Examples'),
            ),
                body: ListView.builder(
                    itemCount: buttons.length,
                    itemBuilder: (context, index) {
                        final button = buttons[index];
                        return ListTile(
                            contentPadding: const EdgeInsets.all(5.0),
                            title: Text(button['name'], style: const TextStyle(fontSize: 20.0)),
                            trailing: button['button'],
                            tileColor: Colors.amber[300],
                        );
                    },
                ),
            );
    }
}


class InputWidgetsShowcase extends StatefulWidget {
  @override
  State<InputWidgetsShowcase> createState() => _InputWidgetsShowcaseState();
}


class _InputWidgetsShowcaseState extends State<InputWidgetsShowcase> {
  // Controllers for Text Fields
  final TextEditingController textController = TextEditingController();
  final TextEditingController formTextController = TextEditingController();

  // Dropdown and Radio Selection
  String? dropdownValue;
  String? radioValue;

  // Boolean states for Checkboxes and Switches
  bool isChecked = false;
  bool switchValue = false;

  // Slider value
  double sliderValue = 0.5;

  // Date and Time Picker Variables
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Widgets Showcase"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TextField (General Input)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter some text",
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "TextFormField (Form-Friendly Input)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: formTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter form text",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  "DropdownButtonFormField",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  items: ["Option 1", "Option 2", "Option 3"]
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Choose an option",
                  ),
                  validator: (value) =>
                      value == null ? "Please select an option" : null,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Checkbox",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: const Text("Check me!"),
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  "Switch",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SwitchListTile(
                  title: const Text("Switch me!"),
                  value: switchValue,
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  "Slider",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: sliderValue,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: sliderValue.toStringAsFixed(2),
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  "Radio Buttons",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text("Option A"),
                      value: "A",
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Option B"),
                      value: "B",
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const Text(
                  "Date Picker",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickDate(context),
                      child: const Text("Pick Date"),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.toLocal()}".split(' ')[0]
                          : "No date selected",
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const Text(
                  "Time Picker",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickTime(context),
                      child: const Text("Pick Time"),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : "No time selected",
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Form Submitted Successfully!"),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit Form"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

