import 'package:flutter/material.dart';

class CounterDetails extends StatelessWidget {
    CounterDetails({super.key, required this.id});

    int id = 0;

    List<Map<String, dynamic>> countDetails = [
        {
            'id': 0,
            'name': 'Workouts',
            'count': 2,
            'details': [
            {'description': 'Chest Day', 'date': "10-12-2024"},
            {'description': 'Leg Day', 'date': "12-12-2024"},
            ],
        },
        {
            'id' : 1,
            'name': 'Books Read',
            'count': 2,
            'details': [
            {'description': '1984 by George Orwell', 'date': "10-12-2024"},
            {'description': 'The Hobbit by J.R.R. Tolkien', 'date': "12-12-2024"},
            ],
        },
    ];
    

    Map<String, dynamic> counterDetails = {};

    Map<String, dynamic> retriveDetails(id){
        Map <String, dynamic> counterDetails = {};
        for (var i = 0; i < countDetails.length; i++) {
        if (countDetails[i]['id'] == id) {
            counterDetails = countDetails[i];
            }
        }
        return counterDetails;
    }

    @override
    Widget build(BuildContext context) {


        counterDetails = retriveDetails(id);
        return Scaffold(
        appBar: AppBar(
            title: Text(counterDetails['name']),
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
            return ListTile(
                title: Text(counterDetails['details'][index]['description'],
                style: const TextStyle(fontSize: 20.0)),
                subtitle: Text(counterDetails['details'][index]['date'],
                style: const TextStyle(fontSize: 16.0)),
                trailing: IconButton(icon: Icon(Icons.delete),
                onPressed: () {},)
            );
            },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {},
        child: const Icon(Icons.add)),
        );
    }
}