import 'package:flutter/material.dart';
import 'package:paper_card/paper_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PaperCard(
                height: 200,
                width: 200,
                child: Text(
                  'راه اندازیسرویس ارسال نتیجه صدور مجوزهای اعلانی',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
              PaperCard(
                height: 100,
                width: 200,
                child: Text(
                  'راه اندازیسرویس ارسال نتیجه صدور مجوزهای اعلانی',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
