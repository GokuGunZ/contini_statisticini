import 'package:contini_statisticini/models/counter.dart';
import 'package:contini_statisticini/models/count_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class TrailerButtonContainer extends StatefulWidget {
  final Box<Counter> counterBox;
  final Box<CountDetail> counterDetailBox;
  final Counter counter;
  final bool requiredAdditionalData;

  TrailerButtonContainer({
    super.key,
    required this.requiredAdditionalData,
    required this.counterBox,
    required this.counter,
    required this.counterDetailBox,
  });

  @override
  State<TrailerButtonContainer> createState() => _TrailerButtonContainerState();
}

class _TrailerButtonContainerState extends State<TrailerButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: widget.requiredAdditionalData
            ? SingleButtonTrailer(
                box: widget.counterBox,
                counter: widget.counter,
                fullDetailFunc: fullDetailsAdd,
                counterDetailBox: widget.counterDetailBox)
            : DoubleButtonTrailer(
                box: widget.counterBox,
                counter: widget.counter,
                fullDetailFunc: fullDetailsAdd,
                counterDetailBox: widget.counterDetailBox));
  }

  void fullDetailsAdd() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return detailedCountModal(
            counter: widget.counter, box: widget.counterBox);
      },
    );
  }
}

class detailedCountModal extends StatefulWidget {
  final Counter counter;
  final Box<Counter> box;
  final Map<String, dynamic> countDetails = {};

  detailedCountModal({super.key, required this.counter, required this.box});

  @override
  State<detailedCountModal> createState() => _detailedCountModalState();
}

class _detailedCountModalState extends State<detailedCountModal> {
  final GlobalKey<FormState> _addDetailedCount = GlobalKey<FormState>();
  final Box<CountDetail> _countDetailBox = Hive.box<CountDetail>('countDetail');
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addDetailedCount,
      child: AlertDialog(
          title: Center(child: Text('${widget.counter.name} count')),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Count Time'),
                ],
              ),
              DateTimePickerRow(
                onDateSelected: (newDateTime) {
                  setState(() {
                    date = newDateTime;
                  });
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.counter.properties.map((item) {
                  return Column(
                    children: [
                      countDetailForm(item),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                }).toList(),
              ),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_addDetailedCount.currentState!.validate()) {
                  _addDetailedCount.currentState!.save();
                  String uniqueId = Uuid().v1();
                  await _countDetailBox.put(
                      uniqueId,
                      CountDetail(
                        id: uniqueId,
                        date: date,
                        counterId: widget.counter.id,
                        attributes: widget.countDetails,
                      ));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Count'),
            ),
          ]),
    );
  }

  Widget countDetailForm(Map<dynamic, dynamic> item) {
    switch (item['fieldtype']) {
      case "Integer Number field":
        return TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: "${item['fieldname']}"),
          onChanged: (value) {
            widget.countDetails[item['fieldname']] = value;
          },
          validator: (value) {
            if (item['required'] == true && (value == null || value.isEmpty)) {
              return "Must enter a number";
            }
            return null;
          },
          keyboardType: TextInputType.number,
        );
      case "Text field":
        return TextFormField(
          decoration: InputDecoration(labelText: "${item['fieldname']}"),
          onChanged: (value) {
            widget.countDetails[item['fieldname']] = value;
          },
          validator: (value) {
            if (item['required'] == true && (value == null || value.isEmpty)) {
              return "Must enter some text";
            }
            return null;
          },
        );
      case "Category field":
        List<DropdownMenuItem> dropdownItems = <DropdownMenuItem>[];
        for (String val in item['values']) {
          dropdownItems.add(DropdownMenuItem(value: val, child: Text(val)));
        }
        return DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: item['fieldname'],
          ),
          onChanged: (value) {
            widget.countDetails[item['fieldname']] = value;
          },
          validator: (value) {
            if (item['required'] == true && (value == null || value.isEmpty)) {
              return "Must enter some text";
            }
            return null;
          },
          items: dropdownItems,
        );
      case "Date field":
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${item['fieldname']}'),
            ],
          ),
          DateTimePickerRow(
            onDateSelected: (newDateTime) {
              setState(() {
                widget.countDetails[item['fieldname']] = newDateTime;
              });
            },
          )
        ]);
      default:
        return TextFormField(
          decoration: InputDecoration(labelText: "${item['fieldname']}"),
        );
    }
  }
}

class DateTimePickerRow extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;

  const DateTimePickerRow({super.key, this.onDateSelected});

  @override
  State<DateTimePickerRow> createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
  var selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  var selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _pickDate(context),
        ),
        const SizedBox(width: 16),
        Text("${selectedDate.toLocal()}".split(' ')[0]),
        const SizedBox(width: 16),
        Text(selectedTime.format(context)),
        const SizedBox(width: 16),
        IconButton(
          icon: Icon(Icons.access_time),
          onPressed: () => _pickTime(context),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDateTime = DateTime(picked.year, picked.month, picked.day,
            selectedDateTime.hour, selectedDateTime.minute, 00);
        selectedDate = picked;
        widget.onDateSelected!(selectedDateTime);
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedDateTime = DateTime(
            selectedDateTime.year,
            selectedDateTime.month,
            selectedDateTime.day,
            picked.hour,
            picked.minute,
            00);
        selectedTime = picked;
        widget.onDateSelected!(selectedDateTime);
      });
    }
  }
}

class DoubleButtonTrailer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final VoidCallback fullDetailFunc;
  final Box<CountDetail> counterDetailBox;
  const DoubleButtonTrailer(
      {super.key,
      required this.box,
      required this.counter,
      required this.fullDetailFunc,
      required this.counterDetailBox});

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
    String uniqueId = Uuid().v1();
    widget.box.put(
        widget.counter.id,
        Counter(
            id: widget.counter.id,
            name: widget.counter.name,
            properties: widget.counter.properties));
    widget.counterDetailBox.put(
        uniqueId,
        CountDetail(
          id: uniqueId,
          date: DateTime.now(),
          counterId: widget.counter.id,
        ));
  }
}

class SingleButtonTrailer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final VoidCallback fullDetailFunc;
  final Box<CountDetail> counterDetailBox;
  const SingleButtonTrailer(
      {super.key,
      required this.box,
      required this.counter,
      required this.fullDetailFunc,
      required this.counterDetailBox});

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
