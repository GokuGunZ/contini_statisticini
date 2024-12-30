import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CounterDetails extends StatefulWidget {
  CounterDetails({super.key, required this.id, required this.scrollController});

  int id = 0;
  ScrollController scrollController;

  @override
  State<CounterDetails> createState() => _CounterDetailsState();
}

class _CounterDetailsState extends State<CounterDetails> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  List<Map<String, dynamic>> countDetails = [
    {
      'id': 0,
      'name': 'Workouts',
      'count': 2,
      'details': [
        {'description': 'Chest Day', 'date': "10-12-2024"},
        {'description': 'Leg Day', 'date': "12-12-2024"},
        {'description': 'Chest Day', 'date': "10-12-2024"},
        {'description': 'Leg Day', 'date': "12-12-2024"},
        {'description': 'Chest Day', 'date': "10-12-2024"},
        {'description': 'Leg Day', 'date': "12-12-2024"},
        {'description': 'Chest Day', 'date': "10-12-2024"},
        {'description': 'Leg Day', 'date': "12-12-2024"},
      ],
    },
    {
      'id': 1,
      'name': 'Books Read',
      'count': 2,
      'details': [
        {'description': '1984 by George Orwell', 'date': "10-12-2024"},
        {'description': 'The Hobbit by J.R.R. Tolkien', 'date': "12-12-2024"},
      ],
    },
  ];

  Map<String, dynamic> counterDetails = {};

  Map<String, dynamic> retriveDetails(id) {
    Map<String, dynamic> counterDetails = {};
    for (var i = 0; i < countDetails.length; i++) {
      if (countDetails[i]['id'] == id) {
        counterDetails = countDetails[i];
      }
    }
    return counterDetails;
  }

  @override
  Widget build(BuildContext context) {
    counterDetails = retriveDetails(widget.id);

    return DecoratedBox(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 237, 217),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 228, 175, 15),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 1))
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22))),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Center(
                        child: Wrap(
                          children: [
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              height: 5,
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: Center(child: Text('Counter')),
                ),
                Expanded(
                    child: ListView.builder(
                  controller: widget.scrollController,
                  itemCount: counterDetails['details'].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                            counterDetails['details'][index]['description'],
                            style: const TextStyle(fontSize: 20.0)),
                        subtitle: Text(counterDetails['details'][index]['date'],
                            style: const TextStyle(fontSize: 16.0)),
                        trailing: IconButton(
                            icon: Icon(Icons.delete), onPressed: () {}));
                  },
                )),
              ],
            ),
          );
        }
  }

