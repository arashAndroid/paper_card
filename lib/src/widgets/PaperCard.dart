import 'dart:math';

import 'package:flutter/material.dart';

import 'package:widget_mask/widget_mask.dart';

class PaperCard extends StatefulWidget {
  /// child to your widget.
  final Widget? child;

  /// padding inside border.
  final EdgeInsetsGeometry? padding;

  /// margin.
  final EdgeInsetsGeometry? margin;

  /// changed the background color.
  final Color? backgroundColor;

  /// changed the border color.
  final Color? borderColor;

  /// thickness of the border.
  final double? borderThickness;

  /// changed the border radius.
  final double? borderRadius;

  /// elevation or the shadow behind card.
  final double? elevation;

  /// change the height.
  final double? height;

  /// change the width.
  final double? width;

  /// change the width.
  final double? shadowOpacity;

  /// Put image in assets and provide path for crayon texture (there is an example texture in example).
  final String? textureAssetPath;

  /// If the texture of crayon should be on the card.
  final bool texture;

  /// BlendMode for the crayon texture.
  final BlendMode textureBlendMode;

  /// BlendMode for the crayon texture.
  final double? textureOpacity;

  /// BlendMode for the crayon texture.
  final BoxFit textureFit;

  const PaperCard({
    Key? key,
    this.child,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(8),
    this.margin,
    this.backgroundColor = const Color(0xFFFFF9E3),
    this.borderColor = const Color(0xFF1A2421),
    this.borderThickness = 6,
    this.borderRadius = 5,
    this.elevation = 2,
    this.shadowOpacity = 0.2,
    this.texture = true,
    this.textureAssetPath,
    this.textureBlendMode = BlendMode.overlay,
    this.textureOpacity,
    this.textureFit = BoxFit.cover,
  }) : super(key: key);

  @override
  State<PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
  List<double> verticalZigZagRandomSeed = [];
  List<double> horizontalZigZagRandomSeed = [];
  int randomTextureQuarterRotation = 0;

  @override
  void initState() {
    verticalZigZagRandomSeed = _generateZigZagRandomSeed();
    horizontalZigZagRandomSeed = _generateZigZagRandomSeed();
    randomTextureQuarterRotation = Random().nextInt(4);
    super.initState();
  }

  List<double> _generateZigZagRandomSeed() {
    List<double> randomSeed = [];
    for (int i = 0; i < 100; i++) {
      randomSeed.add(Random().nextDouble());
    }
    return randomSeed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
            ),
            child: CustomPaint(
              painter: PaintCard(
                borderThickness: widget.borderThickness ?? 5,
                backgroundColor: widget.backgroundColor ?? Colors.white,
                borderColor: widget.borderColor ?? const Color(0xFF020202),
                borderRadius: widget.borderRadius ?? 5,
                elevation: widget.elevation ?? 1,
                shadowOpacity: widget.shadowOpacity ?? 50,
                horizontalZigZagRandomSeed: horizontalZigZagRandomSeed,
                verticalZigZagRandomSeed: verticalZigZagRandomSeed,
              ),
              child: PhysicalModel(
                color: Colors.transparent,
                elevation: 0.0,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
                child: Container(
                  padding: widget.padding,
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.borderThickness ?? 5.0),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
          if (widget.texture && widget.textureAssetPath != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
                child: Opacity(
                  opacity: widget.textureOpacity ?? 1,
                  child: SaveLayer(
                    paint: Paint()..blendMode = widget.textureBlendMode,
                    child: RotatedBox(
                      quarterTurns: randomTextureQuarterRotation,
                      child: Image(
                        image: AssetImage(widget.textureAssetPath!),
                        fit: widget.textureFit,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

//  The  PaperCard  widget is a simple wrapper around the  Card  widget. It takes the same parameters as the  Card  widget and passes them to the  Card  widget.
//  The  PaperCard  widget is used in the  PaperButton  widget.

class PaintCard extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;

  final double borderThickness;
  final double borderRadius;
  final double elevation;
  final double shadowOpacity;
  final List<double> horizontalZigZagRandomSeed;
  final List<double> verticalZigZagRandomSeed;

  PaintCard({
    this.elevation = 1.0,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.horizontalZigZagRandomSeed,
    required this.verticalZigZagRandomSeed,
    this.borderThickness = 5.0,
    this.shadowOpacity = 50,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;

    final pathBorder = Path();

    // Calculate adjusted radius considering half stroke width
    double a = borderRadius - borderThickness / 2;
    // a = 5;
    double s = 0;
    // Start

    pathBorder.moveTo(a + s, s);
    // path.arcToPoint(Offset(0, adjustedRadius), radius: Radius.circular(adjustedRadius));
    // Generate random zigzag points
    int zigzagCountHorizontal = (h / 50).floor(); // Adjust the number of zigzags as needed
    int zigzagCountVertical = (w / 50).floor(); // Adjust the number of zigzags vertically as needed

    const zigzagHeight = 1.5; // Adjust this variable for zigzag height
    const zigzagWidth = 1.5; // Adjust this variable for zigzag height vertically

    var zigzagPoints = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              a + s + i * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              s +
                  horizontalZigZagRandomSeed[(zigzagCountHorizontal * 1) + i] * zigzagHeight * 2 -
                  zigzagHeight, // Randomize vertical position within range
            ));
    // Draw the zigzag path with rounded curves
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        pathBorder.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        pathBorder.quadraticBezierTo(
          (zigzagPoints[i - 1].dx + zigzagPoints[i].dx) / 2,
          zigzagPoints[i - 1].dy, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }
    // Top-right corner
    pathBorder.lineTo(w - a - s, s);
    pathBorder.arcToPoint(Offset(w - s, a + s), radius: Radius.circular(a));

    // Generate random zigzag points vertically
    zigzagPoints = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              w -
                  s +
                  verticalZigZagRandomSeed[(zigzagCountVertical * 1) + i] * zigzagWidth * 2 -
                  zigzagWidth, // Randomize horizontal position within range
              a + s + i * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

    // Draw the zigzag path with rounded curves vertically
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        pathBorder.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        pathBorder.quadraticBezierTo(
          zigzagPoints[i - 1].dx,
          (zigzagPoints[i - 1].dy + zigzagPoints[i].dy) / 2, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }

    // Bottom-right corner
    pathBorder.lineTo(w - s, h - a - s);
    pathBorder.arcToPoint(Offset(w - a - s, h - s), radius: Radius.circular(a));

    // Generate random zigzag points horizontally for the bottom part
    var zigzagPointsBottom = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              w - a - s - (i + 1) * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              h -
                  s +
                  horizontalZigZagRandomSeed[(zigzagCountHorizontal * 2) + i] * zigzagHeight * 2 -
                  zigzagHeight, // Randomize vertical position within range
            ));

    // Draw the zigzag path with rounded curves for the bottom part
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        pathBorder.lineTo(zigzagPointsBottom[i].dx, zigzagPointsBottom[i].dy); // Move to first point
      } else {
        pathBorder.quadraticBezierTo(
          (zigzagPointsBottom[i - 1].dx + zigzagPointsBottom[i].dx) / 2,
          zigzagPointsBottom[i - 1].dy, // Control point for rounded curve
          zigzagPointsBottom[i].dx,
          zigzagPointsBottom[i].dy,
        );
      }
    }

    // Bottom-left corner
    pathBorder.lineTo(a + s, h - s);
    pathBorder.arcToPoint(Offset(s, h - a - s), radius: Radius.circular(a));

    // Generate random zigzag points vertically for the left side
    var zigzagPointsLeft = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              s + verticalZigZagRandomSeed[(zigzagCountVertical * 2) + i] * zigzagWidth * 2 - zigzagWidth,
              h - a - s - (i + 1) * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

    // Draw the zigzag path with rounded curves for the left side
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        pathBorder.lineTo(zigzagPointsLeft[i].dx, zigzagPointsLeft[i].dy); // Move to first point
      } else {
        pathBorder.quadraticBezierTo(
          zigzagPointsLeft[i - 1].dx,
          (zigzagPointsLeft[i - 1].dy + zigzagPointsLeft[i].dy) / 2, // Control point for rounded curve
          zigzagPointsLeft[i].dx,
          zigzagPointsLeft[i].dy,
        );
      }
    }

    // Top-left corner
    pathBorder.lineTo(s, a + s);
    pathBorder.arcToPoint(Offset(a + s, s), radius: Radius.circular(a));

    // Close the path
    pathBorder.close();

    s = borderThickness / 2;

    final pathFill = Path();
    // Start
    pathFill.moveTo(a + s, s);

    zigzagPoints = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              a + s + i * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              s +
                  horizontalZigZagRandomSeed[(zigzagCountHorizontal * 3) + i] * zigzagHeight * 2 -
                  zigzagHeight, // Randomize vertical position within range
            ));
    // Draw the zigzag pathInside with rounded curves
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        pathFill.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        pathFill.quadraticBezierTo(
          (zigzagPoints[i - 1].dx + zigzagPoints[i].dx) / 2,
          zigzagPoints[i - 1].dy, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }
    // Top-right corner
    pathFill.lineTo(w - a - s, s);
    pathFill.arcToPoint(Offset(w - s, a + s), radius: Radius.circular(a));
    // Generate random zigzag points vertically
    zigzagPoints = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              w -
                  s +
                  verticalZigZagRandomSeed[(zigzagCountVertical * 3) + i] * zigzagWidth * 2 -
                  zigzagWidth, // Randomize horizontal position within range
              a + s + i * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

    // Draw the zigzag pathInside with rounded curves vertically
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        pathFill.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        pathFill.quadraticBezierTo(
          zigzagPoints[i - 1].dx,
          (zigzagPoints[i - 1].dy + zigzagPoints[i].dy) / 2, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }

    // Bottom-right corner
    pathFill.lineTo(w - s, h - a - s);
    pathFill.arcToPoint(Offset(w - a - s, h - s), radius: Radius.circular(a));

    // Generate random zigzag points horizontally for the bottom part
    zigzagPointsBottom = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              w - a - s - (i + 1) * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              h -
                  s +
                  horizontalZigZagRandomSeed[(zigzagCountHorizontal * 4) + i] * zigzagHeight * 2 -
                  zigzagHeight, // Randomize vertical position within range
            ));

    // Draw the zigzag pathInside with rounded curves for the bottom part
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        pathFill.lineTo(zigzagPointsBottom[i].dx, zigzagPointsBottom[i].dy); // Move to first point
      } else {
        pathFill.quadraticBezierTo(
          (zigzagPointsBottom[i - 1].dx + zigzagPointsBottom[i].dx) / 2,
          zigzagPointsBottom[i - 1].dy, // Control point for rounded curve
          zigzagPointsBottom[i].dx,
          zigzagPointsBottom[i].dy,
        );
      }
    }

    // Bottom-left corner
    pathFill.lineTo(a + s, h - s);
    pathFill.arcToPoint(Offset(s, h - a - s), radius: Radius.circular(a));

    // Generate random zigzag points vertically for the left side
    zigzagPointsLeft = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              s +
                  verticalZigZagRandomSeed[(zigzagCountVertical * 4) + i] * zigzagWidth * 2 -
                  zigzagWidth, // Randomize horizontal position within range
              h - a - s - (i + 1) * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

// Draw the zigzag pathInside with rounded curves for the left side
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        pathFill.lineTo(zigzagPointsLeft[i].dx, zigzagPointsLeft[i].dy); // Move to first point
      } else {
        pathFill.quadraticBezierTo(
          zigzagPointsLeft[i - 1].dx,
          (zigzagPointsLeft[i - 1].dy + zigzagPointsLeft[i].dy) / 2, // Control point for rounded curve
          zigzagPointsLeft[i].dx,
          zigzagPointsLeft[i].dy,
        );
      }
    }

    // Top-left corner
    pathFill.lineTo(s, a + s);
    pathFill.arcToPoint(Offset(a + s, s), radius: Radius.circular(a));

    // Close the pathInside
    pathFill.close();

    // Calculate translation values
    double translateY = elevation * 2.5;
    double translateX = elevation * 2;
    // Create a copy of the original path
    Path shadowPath = Path.from(pathBorder);
    // Apply translation to the copied path
    shadowPath = shadowPath.shift(Offset(translateX, translateY));

    // Create a paint object with reduced opacity
    Paint shadowPaint = Paint()..color = Colors.black.withOpacity(shadowOpacity);

    final paint = Paint()
      ..color = backgroundColor
      ..blendMode = BlendMode.src
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()..color = borderColor;

    if (elevation > 0) canvas.drawPath(shadowPath, shadowPaint);
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
    if (borderThickness > 0) canvas.drawPath(pathBorder, borderPaint);
    canvas.drawPath(pathFill, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
