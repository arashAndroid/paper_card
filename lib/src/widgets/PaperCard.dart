import 'dart:math';

import 'package:flutter/material.dart';

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

  /// change the width.
  final double? shadowOpacity;

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
    this.shadowOpacity = 0.2,
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
                shadowOpacity: shadowOpacity ?? 50,
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
  final double shadowOpacity;

  PaintCard({
    this.elevation = 1.0,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
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
              w - s + random.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
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
              s + random.nextDouble() * zigzagHeight * 2 - zigzagHeight, // Randomize vertical position within range
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
              w - s + random.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
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
              h - s + randomBottom.nextDouble() * zigzagHeight * 2 - zigzagHeight, // Randomize vertical position within range
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
              s + randomLeft.nextDouble() * zigzagWidth * 2 - zigzagWidth, // Randomize horizontal position within range
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

    Path combinedPath = Path.combine(PathOperation.difference, pathBorder, pathFill);

    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()..color = borderColor;

    if (elevation > 0) canvas.drawPath(shadowPath, shadowPaint);
    if (borderThickness > 0) canvas.drawPath(combinedPath, borderPaint);
    canvas.drawPath(pathFill, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
