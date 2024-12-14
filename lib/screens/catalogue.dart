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

