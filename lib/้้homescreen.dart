import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheeraphat/ScheduleScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // แสดงรูปโลโก้
            Image.asset(
              'assets/images/udru.png',
              width: 200, // ปรับขนาดตามต้องการ
              height: 200,
            ),
            const SizedBox(height: 20), // เพิ่มระยะห่าง
            Text(
              'ตารางเรียน เทอม 2/2567',
              style: GoogleFonts.mitr(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // ปรับสีพื้นหลังของปุ่ม
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12), // เพิ่ม padding
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleScreen()),
                );
              },
              child: Text(
                'ดูตารางเรียน',
                style: GoogleFonts.mitr(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // เปลี่ยนสีพื้นหลัง
    );
  }
}
