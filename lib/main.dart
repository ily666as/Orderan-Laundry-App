import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'form_orderan.dart';
import 'list_orderan.dart';
import 'model/orderan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Orderan Laundry',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ListOrderanPage(),
    );
  }
}
