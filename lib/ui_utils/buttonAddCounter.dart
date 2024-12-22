import 'package:contini_statisticini/models/counter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TrailerButtonContainer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final bool requiredAdditionalData;
  const TrailerButtonContainer(
      {super.key,
      required this.requiredAdditionalData,
      required this.box,
      required this.counter});

  @override
  State<TrailerButtonContainer> createState() => _TrailerButtonContainerState();
}

class _TrailerButtonContainerState extends State<TrailerButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: this.widget.requiredAdditionalData
            ? SingleButtonTrailer(box: widget.box, counter: widget.counter, fullDetailFunc: fullDetailsAdd)
            : DoubleButtonTrailer(box: widget.box, counter: widget.counter, fullDetailFunc: fullDetailsAdd));
  }

  void fullDetailsAdd() {
    GlobalKey<FormState> _addDetailedCount = GlobalKey<FormState>();
    print(widget.counter);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _addDetailedCount,
          child: AlertDialog(
              title: Text('Add a detailed count for ${widget.counter.name}'),
              content: Column(
                children: [Text("${widget.counter.properties.toList()}")],
              )),
        );
      },
    );
  }
}

class DoubleButtonTrailer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final VoidCallback fullDetailFunc;
  const DoubleButtonTrailer({super.key, required this.box, required this.counter, required this.fullDetailFunc});

  @override
  State<DoubleButtonTrailer> createState() => _DoubleButtonTrailerState();
}

class _DoubleButtonTrailerState extends State<DoubleButtonTrailer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: fastAdd,
          icon: const Icon(Icons.plus_one),
        ),
        IconButton(
          onPressed: widget.fullDetailFunc,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void fastAdd() {
    widget.box.putAt(
        widget.counter.id,
        Counter(
            id: widget.counter.id,
            name: widget.counter.name,
            detailCount: widget.counter.detailCount + 1,
            properties: widget.counter.properties));
  }
}

class SingleButtonTrailer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final VoidCallback fullDetailFunc;
  const SingleButtonTrailer({super.key, required this.box, required this.counter, required this.fullDetailFunc});

  @override
  State<SingleButtonTrailer> createState() => _SingleButtonTrailerState();
}

class _SingleButtonTrailerState extends State<SingleButtonTrailer> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.fullDetailFunc,
      icon: const Icon(Icons.add),
    );
  }
}
