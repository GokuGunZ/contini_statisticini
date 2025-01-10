import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:contini_statisticini/models/count_detail.dart';
import 'package:contini_statisticini/models/counter.dart';

// ignore: must_be_immutable
class DetailListBottomSheet extends StatefulWidget {
  final Counter counter;
  final ScrollController scrollController;
  late List<CountDetail> countDetails;
  final Box<CountDetail> counterDetailsBox;

  DetailListBottomSheet(
      {super.key,
      required this.counter,
      required this.scrollController,
      required this.counterDetailsBox}) {
    countDetails = counterDetailsBox.values
        .where((item) => item.counterId == counter.id)
        .toList();
  }

  @override
  State<DetailListBottomSheet> createState() => _DetailListBottomSheetState();
}

class _DetailListBottomSheetState extends State<DetailListBottomSheet> {
  Map<String, dynamic> counterDetails = {};

  @override
  Widget build(BuildContext context) {
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
              topLeft: Radius.circular(22), topRight: Radius.circular(22))),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // * Scrollable Indicator
              SingleChildScrollView(
                controller: widget.scrollController,
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
            child: Center(
                child: Text(widget.counter.name,
                    style: const TextStyle(fontSize: 26.0))),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.countDetails.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                leading: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70,
                    ),
                    child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Center(
                          child: Text('${index + 1}',
                              style: const TextStyle(fontSize: 16.0)),
                        ))),
                title: Text(
                    DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(widget.countDetails[index].date as DateTime),
                    style: const TextStyle(fontSize: 20.0)),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.counterDetailsBox
                            .delete(widget.countDetails[index].key);
                        widget.countDetails.removeAt(index);
                      });
                    }),
                children: widget.countDetails[index].attributes.toString() !=
                        "null"
                    ? <Widget>[
                        ExpansionTileChildren(
                            attributes: widget.countDetails[index].attributes!,
                            fieldSchema: widget.counter.properties)
                      ]
                    : [],
              );
            },
          )),
        ],
      ),
    );
  }
}

class ExpansionTileChildren extends StatelessWidget {
  final Map<String, dynamic> attributes;
  final List<Map<dynamic, dynamic>> fieldSchema;
  const ExpansionTileChildren(
      {super.key, required this.attributes, required this.fieldSchema});

  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> nonEmptyValues = [];
    for (Map<dynamic, dynamic> field in fieldSchema) {
      if (attributes[field["fieldname"]] != null) {
        nonEmptyValues.add({"fieldname": field["fieldname"], "value": attributes[field["fieldname"]]});
      }
    }
    double boxHeight = 70.0*nonEmptyValues.length;
    return SizedBox(
      height: boxHeight,
      child: ListView.builder(
          itemCount: nonEmptyValues.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(nonEmptyValues[index]['value'].toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
              subtitle: Text(nonEmptyValues[index]['fieldname'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            );
          }),
    );
  }
}
