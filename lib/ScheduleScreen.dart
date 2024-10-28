import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // แบ่งวิชาเรียนตามวันและช่วงเวลา
  Map<String, Map<String, dynamic>> scheduleByDay = {
    'จันทร์': {'timePeriod': '', 'courses': <dynamic>[]},
    'อังคาร': {'timePeriod': '', 'courses': <dynamic>[]},
    'พฤหัสบดี': {'timePeriod': '', 'courses': <dynamic>[]},
    'ศุกร์': {'timePeriod': '', 'courses': <dynamic>[]},
  };

  @override
  void initState() {
    super.initState();
    loadScheduleData();
  }

  Future<void> loadScheduleData() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/schedule.json');
    final List<dynamic> data = await json.decode(response);

    setState(() {
      for (var item in data) {
        String day = item['day'];
        String timePeriod = item['time_period'];

        if (scheduleByDay.containsKey(day)) {
          scheduleByDay[day]?['courses'].add(item);
          if (scheduleByDay[day]?['timePeriod'] == '') {
            scheduleByDay[day]?['timePeriod'] = timePeriod;
          } else if (scheduleByDay[day]?['timePeriod'] != timePeriod) {
            scheduleByDay[day]?['timePeriod'] = 'เช้า-บ่าย';
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตารางเรียน',
          style: GoogleFonts.mitr(),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: scheduleByDay.entries.map((entry) {
          String day = entry.key;
          String timePeriod = entry.value['timePeriod'] ?? '';
          List<dynamic> courses = entry.value['courses'] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'วัน$day [$timePeriod]',
                  style: GoogleFonts.mitr(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...courses.map((item) {
                return Card(
                  child: ListTile(
                    title: Text(
                        '${item['course_code']} - ${item['course_name']}',
                        style: GoogleFonts.mitr()),
                    subtitle: Text(
                      'หมู่: ${item['section']} | ผู้สอน: ${item['instructor']} \n'
                      'เวลา: ${item['schedule']} | ห้องเรียน: ${item['location']}',
                      style: GoogleFonts.mitr(),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('${item['course_name']}',
                              style: GoogleFonts.mitr()),
                          content: Text(
                            'รหัสวิชา: ${item['course_code']}\n'
                            'หมู่: ${item['section']}\n'
                            'ผู้สอน: ${item['instructor']}\n'
                            'เวลา: ${item['schedule']}\n'
                            'ห้องเรียน: ${item['location']}',
                            style: GoogleFonts.mitr(),
                          ),
                          actions: [
                            TextButton(
                              child: Text('ปิด', style: GoogleFonts.mitr()),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        }).toList(),
      ),
      backgroundColor: Colors.lightBlue[50], // เปลี่ยนสีพื้นหลัง
    );
  }
}
