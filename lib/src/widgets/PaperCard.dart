import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:widget_mask/widget_mask.dart';

class PaperCard extends StatelessWidget {
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

  /// Put image in assets and provide path for crayon texture (there is an example texture in example).
  final String? crayonAssetPath;

  /// If the texture of crayon should be on the card.
  final bool crayonTexture;

  /// BlendMode for the crayon texture.
  final BlendMode crayonTextureBlendMode;

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
    this.crayonTexture = true,
    this.crayonAssetPath,
    this.crayonTextureBlendMode = BlendMode.overlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
            ),
            child: CustomPaint(
              painter: PaintCard(
                borderThickness: borderThickness ?? 5,
                backgroundColor: backgroundColor ?? Colors.white,
                borderColor: borderColor ?? const Color(0xFF020202),
                borderRadius: borderRadius ?? 5,
                elevation: elevation ?? 1,
              ),
              child: PhysicalModel(
                color: Colors.transparent,
                elevation: 0.0,
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                child: Container(
                  padding: padding,
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(borderThickness ?? 5.0),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          if (crayonTexture && crayonAssetPath != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                child: SaveLayer(
                  paint: Paint()..blendMode = crayonTextureBlendMode,
                  child: RotatedBox(
                    quarterTurns: Random().nextInt(4),
                    child: Image(
                      image: AssetImage(crayonAssetPath!),
                      fit: BoxFit.cover,
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

  PaintCard({this.elevation = 1.0, required this.backgroundColor, required this.borderColor, required this.borderRadius, this.borderThickness = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;

    final paint = Paint()..color = backgroundColor;
    final borderPaint = Paint()..color = borderColor.withOpacity(0.5)
        // ..style = PaintingStyle.stroke
        // ..strokeJoin = StrokeJoin.round
        // ..strokeCap = StrokeCap.round
        // ..strokeWidth = borderThickness
        ;

    final path = Path();

    // Calculate adjusted radius considering half stroke width
    double a = borderRadius - borderPaint.strokeWidth / 2;
    // a = 5;
    double s = 0;
    // Start
    path.moveTo(a + s, s);
    // path.arcToPoint(Offset(0, adjustedRadius), radius: Radius.circular(adjustedRadius));
    // Generate random zigzag points
    int zigzagCountHorizontal = (h / 50).floor(); // Adjust the number of zigzags as needed
    int zigzagCountVertical = (w / 50).floor(); // Adjust the number of zigzags vertically as needed

    final random = Random();
    const zigzagHeight = 1.5; // Adjust this variable for zigzag height
    const zigzagWidth = 1.5; // Adjust this variable for zigzag height vertically

    var zigzagPoints = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              a + s + i * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              s + random.nextDouble() * zigzagHeight * 2 - zigzagHeight, // Randomize vertical position within range
            ));
    // Draw the zigzag path with rounded curves
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        path.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        path.quadraticBezierTo(
          (zigzagPoints[i - 1].dx + zigzagPoints[i].dx) / 2,
          zigzagPoints[i - 1].dy, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }
    // Top-right corner
    path.lineTo(w - a - s, s);
    path.arcToPoint(Offset(w - s, a + s), radius: Radius.circular(a));
    // Generate random zigzag points vertically
    zigzagPoints = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              w - s + random.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
              a + s + i * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

    // Draw the zigzag path with rounded curves vertically
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        path.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        path.quadraticBezierTo(
          zigzagPoints[i - 1].dx,
          (zigzagPoints[i - 1].dy + zigzagPoints[i].dy) / 2, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }

    // Bottom-right corner
    path.lineTo(w - s, h - a - s);
    path.arcToPoint(Offset(w - a - s, h - s), radius: Radius.circular(a));

    // Generate random zigzag points horizontally for the bottom part
    final randomBottom = Random();
    var zigzagPointsBottom = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              w - a - s - (i + 1) * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              h - s + randomBottom.nextDouble() * zigzagHeight * 2 - zigzagHeight, // Randomize vertical position within range
            ));

    // Draw the zigzag path with rounded curves for the bottom part
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        path.lineTo(zigzagPointsBottom[i].dx, zigzagPointsBottom[i].dy); // Move to first point
      } else {
        path.quadraticBezierTo(
          (zigzagPointsBottom[i - 1].dx + zigzagPointsBottom[i].dx) / 2,
          zigzagPointsBottom[i - 1].dy, // Control point for rounded curve
          zigzagPointsBottom[i].dx,
          zigzagPointsBottom[i].dy,
        );
      }
    }

    // Bottom-left corner
    path.lineTo(a + s, h - s);
    path.arcToPoint(Offset(s, h - a - s), radius: Radius.circular(a));

    // Generate random zigzag points vertically for the left side
    final randomLeft = Random();
    var zigzagPointsLeft = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              s + randomLeft.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
              h - a - s - (i + 1) * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

// Draw the zigzag path with rounded curves for the left side
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        path.lineTo(zigzagPointsLeft[i].dx, zigzagPointsLeft[i].dy); // Move to first point
      } else {
        path.quadraticBezierTo(
          zigzagPointsLeft[i - 1].dx,
          (zigzagPointsLeft[i - 1].dy + zigzagPointsLeft[i].dy) / 2, // Control point for rounded curve
          zigzagPointsLeft[i].dx,
          zigzagPointsLeft[i].dy,
        );
      }
    }

    // Top-left corner
    path.lineTo(s, a + s);
    path.arcToPoint(Offset(a + s, s), radius: Radius.circular(a));

    // Close the path
    path.close();

    s = borderThickness / 2;

    final pathInside = Path();
    // Start
    pathInside.moveTo(a + s, s);

    zigzagPoints = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              a + s + i * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              s + random.nextDouble() * zigzagHeight * 2 - zigzagHeight, // Randomize vertical position within range
            ));
    // Draw the zigzag pathInside with rounded curves
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        pathInside.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        pathInside.quadraticBezierTo(
          (zigzagPoints[i - 1].dx + zigzagPoints[i].dx) / 2,
          zigzagPoints[i - 1].dy, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }
    // Top-right corner
    pathInside.lineTo(w - a - s, s);
    pathInside.arcToPoint(Offset(w - s, a + s), radius: Radius.circular(a));
    // Generate random zigzag points vertically
    zigzagPoints = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              w - s + random.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
              a + s + i * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

    // Draw the zigzag pathInside with rounded curves vertically
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        pathInside.lineTo(zigzagPoints[i].dx, zigzagPoints[i].dy); // Move to first point
      } else {
        pathInside.quadraticBezierTo(
          zigzagPoints[i - 1].dx,
          (zigzagPoints[i - 1].dy + zigzagPoints[i].dy) / 2, // Control point for rounded curve
          zigzagPoints[i].dx,
          zigzagPoints[i].dy,
        );
      }
    }

    // Bottom-right corner
    pathInside.lineTo(w - s, h - a - s);
    pathInside.arcToPoint(Offset(w - a - s, h - s), radius: Radius.circular(a));

    // Generate random zigzag points horizontally for the bottom part
    zigzagPointsBottom = List.generate(
        zigzagCountHorizontal,
        (i) => Offset(
              w - a - s - (i + 1) * (w - 2 * a - 2 * s) / (zigzagCountHorizontal + 1),
              h - s + randomBottom.nextDouble() * zigzagHeight * 2 - zigzagHeight, // Randomize vertical position within range
            ));

    // Draw the zigzag pathInside with rounded curves for the bottom part
    for (int i = 0; i < zigzagCountHorizontal; i++) {
      if (i == 0) {
        pathInside.lineTo(zigzagPointsBottom[i].dx, zigzagPointsBottom[i].dy); // Move to first point
      } else {
        pathInside.quadraticBezierTo(
          (zigzagPointsBottom[i - 1].dx + zigzagPointsBottom[i].dx) / 2,
          zigzagPointsBottom[i - 1].dy, // Control point for rounded curve
          zigzagPointsBottom[i].dx,
          zigzagPointsBottom[i].dy,
        );
      }
    }

    // Bottom-left corner
    pathInside.lineTo(a + s, h - s);
    pathInside.arcToPoint(Offset(s, h - a - s), radius: Radius.circular(a));

    // Generate random zigzag points vertically for the left side
    zigzagPointsLeft = List.generate(
        zigzagCountVertical,
        (i) => Offset(
              s + randomLeft.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
              h - a - s - (i + 1) * (h - 2 * a - 2 * s) / (zigzagCountVertical + 1),
            ));

// Draw the zigzag pathInside with rounded curves for the left side
    for (int i = 0; i < zigzagCountVertical; i++) {
      if (i == 0) {
        pathInside.lineTo(zigzagPointsLeft[i].dx, zigzagPointsLeft[i].dy); // Move to first point
      } else {
        pathInside.quadraticBezierTo(
          zigzagPointsLeft[i - 1].dx,
          (zigzagPointsLeft[i - 1].dy + zigzagPointsLeft[i].dy) / 2, // Control point for rounded curve
          zigzagPointsLeft[i].dx,
          zigzagPointsLeft[i].dy,
        );
      }
    }

    // Top-left corner
    pathInside.lineTo(s, a + s);
    pathInside.arcToPoint(Offset(a + s, s), radius: Radius.circular(a));

    // Close the pathInside
    pathInside.close();

    // Calculate translation values
    double translateY = elevation * 2.5;
    double translateX = elevation * 2;
    // Create a copy of the original path
    Path copiedPath = Path.from(path);
    // Apply translation to the copied path
    copiedPath = copiedPath.shift(Offset(translateX, translateY));

    // Apply scaling to the copied path
    // Matrix4 scalingMatrix = Matrix4.identity()..scale(scaleFactor, scaleFactor, scaleFactor);
    // copiedPath = copiedPath.transform(scalingMatrix.storage);

    int opacity = 50; // Range from 0 (completely transparent) to 255 (completely opaque)

// Create a paint object with reduced opacity
    Paint paintCopied = Paint()..color = Colors.black.withOpacity(opacity / 255.0);
    canvas.drawPath(copiedPath, paintCopied);
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(pathInside, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
