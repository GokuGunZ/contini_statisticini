import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:contini_statisticini/models/count_detail.dart';

class DetailListBottomSheet extends StatefulWidget {
  final String id;
  final String counterName;
  final ScrollController scrollController;
  late List<CountDetail> countDetails;
  final Box<CountDetail> counterDetailsBox;

  DetailListBottomSheet(
      {super.key,
      required this.id,
      required this.counterName,
      required this.scrollController,
      required this.counterDetailsBox}) {
    countDetails =
        counterDetailsBox.values.where((item) => item.counterId == id).toList();
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
                child: Text(widget.counterName,
                    style: const TextStyle(fontSize: 26.0))),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.countDetails.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Row(
                    children: [
                      DecoratedBox(
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                              widget.countDetails[index].date as DateTime),
                          style: const TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  subtitle:
                      Text(widget.countDetails[index].attributes.toString()),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.counterDetailsBox
                              .delete(widget.countDetails[index].key);
                          widget.countDetails.removeAt(index);
                        });
                      }));
            },
          )),
        ],
      ),
    );
  }
}
