import 'package:flutter/material.dart';
import 'package:pheeraphat/%E0%B9%89%E0%B9%89homescreen.dart';

void main() {
  runApp(const ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  const ScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Krub'),
      home: const HomeScreen(),
    );
  }
}


// หน้าจอที่แสดงตารางเรียนพร้อมช่วงเวลา

