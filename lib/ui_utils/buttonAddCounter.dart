import 'package:contini_statisticini/models/counter.dart';
import 'package:contini_statisticini/models/count_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class TrailerButtonContainer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final bool requiredAdditionalData;

  TrailerButtonContainer(
      {super.key,
      required this.requiredAdditionalData,
      required this.box,
      required this.counter, 
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
                box: widget.box,
                counter: widget.counter,
                fullDetailFunc: fullDetailsAdd)
            : DoubleButtonTrailer(
                box: widget.box,
                counter: widget.counter,
                fullDetailFunc: fullDetailsAdd));
  }

  void fullDetailsAdd() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return detailedCountModal(counter: widget.counter, box: widget.box);
      },
    );
  }
}

class detailedCountModal extends StatefulWidget {
  final Counter counter;
  final Box<Counter> box;
  final Map<String, dynamic> countDetails = {
    'selectedDate':
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    'selectedTime': TimeOfDay.now()
  };

  detailedCountModal({super.key, required this.counter, required this.box});

  @override
  State<detailedCountModal> createState() => _detailedCountModalState();
}

class _detailedCountModalState extends State<detailedCountModal> {
  final GlobalKey<FormState> _addDetailedCount = GlobalKey<FormState>();
  final Box<CountDetail> _countDetailBox = Hive.box<CountDetail>('count_detail');
      
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addDetailedCount,
      child: AlertDialog(
          title: Center(child: Text('${widget.counter.name} Count')),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Count \nTime'),
                  DateTimePickerRow(countDetails: widget.countDetails),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.counter.properties.map((item) {
                  return countDetailForm(item);
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
                  // add --- await widget.countDetails.put(data);
                  await _countDetailBox.add(CountDetail(id: _countDetailBox.length, counterId: widget.counter.id, countNumber: widget.counter.detailCount));
                  print(widget.countDetails);
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
      case 'Numero Intero':
        return TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: "${item['fieldname']}"),
          onChanged: (value) {
            widget.countDetails[item['fieldname']] = value;
          },
          validator: (value) {
            if (item['required'] == true) {
              return "Must enter a number";
            }
            return null;
          },
          keyboardType: TextInputType.number,
        );
      case 'Testo':
        return TextFormField(
          decoration: InputDecoration(labelText: "${item['fieldname']}"),
          onChanged: (value) {
            widget.countDetails[item['fieldname']] = value;
          },
          validator: (value) {
            if (item['required'] == true) {
              return "Must enter some text";
            }
            return null;
          },
        );
      case 'Set di valori':
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
            if (item['required'] == true) {
              return "Must enter some text";
            }
            return null;
          },
          items: dropdownItems,
        );
      case 'Data':
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${item['fieldname']}'),
              DateTimePickerRow(
                countDetails: widget.countDetails,
                fieldname: item['fieldname'],
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
  Map<String, dynamic> countDetails;
  final String? fieldname;

  DateTimePickerRow({super.key, required this.countDetails, this.fieldname}) {
    if (fieldname != null) {
      countDetails[fieldname!] = <String, dynamic>{};
      countDetails = countDetails[fieldname!];
    }
  }

  @override
  State<DateTimePickerRow> createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
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
        Text(
          widget.countDetails['selectedDate'] != null
              ? "${widget.countDetails['selectedDate']!.toLocal()}"
                  .split(' ')[0]
              : "No date selected",
        ),
        const SizedBox(width: 16),
        Text(
          widget.countDetails['selectedTime'] != null
              ? widget.countDetails['selectedTime']!.format(context)
              : "No time selected",
        ),
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
      initialDate: widget.countDetails['selectedDate'] ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != widget.countDetails['selectedDate']) {
      setState(() {
        widget.countDetails['selectedDate'] = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.countDetails['selectedTime'] ?? TimeOfDay.now(),
    );
    if (picked != null && picked != widget.countDetails['selectedTime']) {
      setState(() {
        widget.countDetails['selectedTime'] = picked;
      });
    }
  }
}

class DoubleButtonTrailer extends StatefulWidget {
  final Box<Counter> box;
  final Counter counter;
  final VoidCallback fullDetailFunc;
  const DoubleButtonTrailer(
      {super.key,
      required this.box,
      required this.counter,
      required this.fullDetailFunc});

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
  const SingleButtonTrailer(
      {super.key,
      required this.box,
      required this.counter,
      required this.fullDetailFunc});

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
