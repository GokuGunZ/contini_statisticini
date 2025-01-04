import 'package:contini_statisticini/screens/DetailListBottomSheet.dart';
import 'package:contini_statisticini/models/counter.dart';
import 'package:contini_statisticini/models/count_detail.dart';
import 'package:contini_statisticini/ui_utils/increaseCountButtons.dart';
import 'package:contini_statisticini/ui_utils/createCounterModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainHomeScaffold();
  }
}

class MainHomeScaffold extends StatefulWidget {
  @override
  State<MainHomeScaffold> createState() => _MainHomeScaffoldState();
}

class _MainHomeScaffoldState extends State<MainHomeScaffold> {
  final Box<Counter> _countersBox = Hive.box<Counter>('counters');

  final Box<CountDetail> _counterDetailBox =
      Hive.box<CountDetail>('countDetail');

  int getCountNumber(String id) {
    return _counterDetailBox.values
        .where((item) => item.counterId == id)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    // Manually add line
    // _countersBox.add(new Counter(id: 0, name: 'Seghe', detailCount: 15));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contini Statisticini'),
      ),
      body: ValueListenableBuilder(
          valueListenable: _countersBox.listenable(),
          builder: (context, Box<Counter> box, _) {
            if (box.isEmpty) {
              return const Center(
                  child: Text("No counters yet!\n Create a new counter!"));
            }
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final counter = box.getAt(index);
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
                                    child: Text(
                                        '${getCountNumber(counter!.id)}'))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(counter.name,
                              style: const TextStyle(fontSize: 20.0)),
                        ],
                      ),
                      trailing: TrailerButtonContainer(
                        requiredAdditionalData: counter.requiredAdditionalData,
                        counterBox: box,
                        counter: counter,
                        counterDetailBox: _counterDetailBox,
                      ),
                      tileColor: Colors.amber[300],
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                  initialChildSize: 0.5,
                                  minChildSize: 0.2,
                                  maxChildSize: 0.91,
                                  expand: false,
                                  builder: (context, scrollController) {
                                    return DetailListBottomSheet(
                                        id: counter.id,
                                        counterName: counter.name,
                                        scrollController: scrollController,
                                        counterDetailsBox: _counterDetailBox);
                                  });
                            }).whenComplete(() => setState(() {}));
                      },
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CreateCounterModel(
                    id: _countersBox.length, countersBox: _countersBox);
              },
            );
          },
          label: const Text('Counter', style: TextStyle(fontSize: 18.0)),
          icon: const Icon(Icons.plus_one_sharp)),
    );
  }
}
