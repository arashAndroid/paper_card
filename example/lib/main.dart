import 'package:flutter/material.dart';
import 'package:paper_card/paper_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'darya',
      ),
      home: const Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PaperCard(
                height: 200,
                width: 200,
                child: Text(
                  'راه اندازیسرویس ارسال نتیجه صدور مجوزهای اعلانی',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
              PaperCard(
                height: 100,
                width: 200,
                child: Text(
                  'راه اندازیسرویس ارسال نتیجه صدور مجوزهای اعلانی',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
              PaperCard(
                height: 100,
                width: 200,
                child: Text(
                  'راه اندازیسرویس ارسال نتیجه صدور مجوزهای اعلانی',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
              PaperCard(
                height: 100,
                width: 200,
                child: Text(
                  'راه اندازیسرویس ارسال نتیجه صدور مجوزهای اعلانی',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
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
