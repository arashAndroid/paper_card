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
                borderColor: Colors.red,
                backgroundColor: Color.fromARGB(255, 139, 222, 255),
                borderRadius: 25,
                borderThickness: 20,
                elevation: 2,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                crayonTexture: true,
                crayonAssetPath: 'assets/crayon_mask.png',
                crayonTextureBlendMode: BlendMode.overlay,
                child: Text(
                  'Hello World This is just a test text',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                  textDirection: TextDirection.rtl,
                ),
              ),
              PaperCard(
                height: 200,
                width: 150,
                crayonAssetPath: 'assets/crayon_mask.png',
                borderThickness: 0,
                child: Text(
                  'تست فارسی ۱: سلام دنیا',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
              PaperCard(
                height: 100,
                width: 200,
                borderRadius: 20,
                borderThickness: 5,
                child: Text(
                  'تست فارسی ۱: سلام دنیا',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Color(0xFFFFF9E3),
              ),
              PaperCard(
                height: 100,
                width: 200,
                crayonAssetPath: 'assets/crayon_mask.png',
                child: Text(
                  'تست فارسی ۱: سلام دنیا',
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
