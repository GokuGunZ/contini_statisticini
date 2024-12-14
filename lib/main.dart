import 'screens/home.dart';
import 'screens/counter_details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:contini_statisticini/models/counter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();

  Hive.registerAdapter(CounterAdapter());

  await Hive.openBox<Counter>('counters');
  
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home' : (context) => HomeScreen(),
        '/counter_details': (context) => CounterDetails(id: 0),
        },
      title: 'Contini Statisticini',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}