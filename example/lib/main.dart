import 'package:flutter/material.dart';
import 'package:paper_card/paper_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'darya',
      ),
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PaperCard(
                height: 200,
                width: 200,
                borderColor: Colors.red,
                backgroundColor: Color(0xFF8BDEFF),
                borderRadius: 25,
                borderThickness: 20,
                elevation: 2,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                texture: true,
                textureAssetPath: 'assets/crayon_mask.png',
                textureBlendMode: BlendMode.overlay,
                child: Text(
                  'Hello World This is just a test text',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                  textDirection: TextDirection.rtl,
                ),
              ),
              // padding: EdgeInsets.all(0),
              // elevation: 5,
              // backgroundColor: Theme.of(context).colorScheme.surface,
              // borderColor: Theme.of(context).colorScheme.onSurface,
              // borderThickness: 4,
              PaperCard(
                height: 200,
                width: 150,
                // textureAssetPath: 'assets/crayon_mask.png',
                borderThickness: 10,
                elevation: 5,
                child: Text(
                  'تست فارسی 3: سلام دنیا',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color.fromARGB(255, 255, 205, 25),
                // textureOpacity: 0.1,
              ),
              PaperCard(
                height: 100,
                width: 200,
                borderRadius: 20,
                borderThickness: 5,
                elevation: 0,
                backgroundColor: Colors.red,
                child: Text(
                  'تست فارسی ۲: سلام دنیا',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                  textDirection: TextDirection.rtl,
                ),
              ),
              InkWell(
                onTap: () {
                  print('Card Tapped');
                  setState(() {});
                },
                child: PaperCard(
                  height: 100,
                  width: 200,
                  textureAssetPath: 'assets/crayon_mask.png',
                  backgroundColor: Color(0xFFFFF9E3),
                  child: Text(
                    'تست فارسیسسسسسس ۱: سلام دنیا',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
