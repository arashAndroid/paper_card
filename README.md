<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

It is a card that looks like a cartoon paper. it is kinda customizable

## Features

borderColor: changed the border color.
backgroundColor: changed the background color.
borderRadius: changed the border radius.
borderThickness: thickness of the border.
elevation: elevation or the shadow behind card.
crayonTexture: If the texture of crayon should be on the card.
crayonAssetPath: Put image in assets and provide path for crayon texture (there is an example texture in example).
crayonTextureBlendMode: BlendMode for the crayon texture.
margin: margin.
padding: padding inside border.
height: change the height.
width: change the width.
child: child to your widget.

## Usage

```dart
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
                crayonTextureBlendMode: BlendMode.overlay,
                child: Text(
                  'Hello World This is just a test text',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textDirection: TextDirection.rtl,
                ),
              )
```
