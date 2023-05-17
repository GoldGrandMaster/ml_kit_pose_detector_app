import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'coordinate_translator.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as vector;

//description: pose_painter and calculate_angle



class PosePainter extends CustomPainter {
  PosePainter(this.poses, this.absoluteImageSize, this.rotation);

  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.yellow;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.green;

    final whitePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.white;

    for (final pose in poses) {
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
            Offset(
              translateX(landmark.x, rotation, size, absoluteImageSize),
              translateY(landmark.y, rotation, size, absoluteImageSize),
            ),
            1,
            paint);
      });

      void paintLine(PoseLandmarkType type1, PoseLandmarkType type2,
          Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            paintType);
      }

      double CalculateAngle(Offset p1, Offset p2, Offset p3) {
        final vector.Vector2 v1 = vector.Vector2(p1.dx - p2.dx, p1.dy - p2.dy);
        final vector.Vector2 v2 = vector.Vector2(p3.dx - p2.dx, p3.dy - p2.dy);
        final double dotProduct = v1.dot(v2);
        final double cosAngle = dotProduct / (v1.length * v2.length);
        final double angle = acos(cosAngle);
        double degrees = angle * 180 / pi; // Convert to degrees
        if (degrees > 180.0) degrees = 360 - degrees;
        return degrees;
      }

      double angleShow(PoseLandmarkType type1, PoseLandmarkType type2,
          PoseLandmarkType type3) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        final PoseLandmark joint3 = pose.landmarks[type3]!;
        return CalculateAngle(
          Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
              translateY(joint1.y, rotation, size, absoluteImageSize)),
          Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
              translateY(joint2.y, rotation, size, absoluteImageSize)),
          Offset(translateX(joint3.x, rotation, size, absoluteImageSize),
              translateY(joint3.y, rotation, size, absoluteImageSize)),
        );
      }

      //Draw arms
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);

      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

      //Draw hands
      paintLine(
          PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb, leftPaint);
      paintLine(
          PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndex, leftPaint);
      paintLine(
          PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinky, leftPaint);

      paintLine(
          PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb, rightPaint);
      paintLine(
          PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndex, rightPaint);
      paintLine(
          PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinky, rightPaint);

      //Draw body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightPaint);
      paintLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder,
          whitePaint);
      paintLine(
          PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, whitePaint);

      //Draw legs
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel, leftPaint);
      paintLine(
          PoseLandmarkType.leftHeel, PoseLandmarkType.leftFootIndex, leftPaint);
      paintLine(PoseLandmarkType.leftAnkle, PoseLandmarkType.leftFootIndex,
          leftPaint);

      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
      paintLine(
          PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel, rightPaint);
      paintLine(PoseLandmarkType.rightHeel, PoseLandmarkType.rightFootIndex,
          rightPaint);
      paintLine(PoseLandmarkType.rightAnkle, PoseLandmarkType.rightFootIndex,
          rightPaint);


      final textPainter = TextPainter(
          text: TextSpan(
            text: '${angleShow(
                PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist,
                PoseLandmarkType.leftIndex).toInt()}°(L_Wr)\n'
                + '${angleShow(
                    PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist,
                    PoseLandmarkType.rightIndex).toInt()}°(R_Wr)\n'
                + '${angleShow(
                    PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip,
                    PoseLandmarkType.leftKnee).toInt()}°(L_Hp L_Kn)\n'
                + '${angleShow(
                    PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
                    PoseLandmarkType.rightKnee).toInt()}°(R_Hp R_Kn)\n'
                + '${angleShow(
                    PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip,
                    PoseLandmarkType.leftAnkle).toInt()}°(L_Hp L_Ak)\n'
                + '${angleShow(
                    PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
                    PoseLandmarkType.rightAnkle).toInt()}°(R_Hp R_Ak)\n'
                + '${angleShow(
                    PoseLandmarkType.leftAnkle, PoseLandmarkType.leftKnee,
                    PoseLandmarkType.leftHip).toInt()}°(L_Kn)\n'
                + '${angleShow(
                    PoseLandmarkType.rightAnkle, PoseLandmarkType.rightKnee,
                    PoseLandmarkType.rightHip).toInt()}°(R_Kn)\n'
                + '${angleShow(
                    PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle,
                    PoseLandmarkType.leftFootIndex).toInt()}°(L_Ft)\n'
                + '${angleShow(
                    PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle,
                    PoseLandmarkType.rightFootIndex).toInt()}°(R_Ft)\n'
                + '${angleShow(
                    PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow,
                    PoseLandmarkType.leftWrist).toInt()}°(L_Eb)\n'
                + '${angleShow(
                    PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
                    PoseLandmarkType.rightWrist).toInt()}°(R_Eb)\n'
                + '${angleShow(
                    PoseLandmarkType.leftHip, PoseLandmarkType.leftShoulder,
                    PoseLandmarkType.leftWrist).toInt()}°(L_Sh L_Wr)\n'
                + '${angleShow(
                    PoseLandmarkType.rightHip, PoseLandmarkType.rightShoulder,
                    PoseLandmarkType.rightWrist).toInt()}°(R_Sh R_Wr)\n'
                + '${angleShow(
                    PoseLandmarkType.leftHip, PoseLandmarkType.leftShoulder,
                    PoseLandmarkType.leftElbow).toInt()}°(L_Sh L_Eb)\n'
                + '${angleShow(
                    PoseLandmarkType.rightHip, PoseLandmarkType.rightShoulder,
                    PoseLandmarkType.rightElbow).toInt()}°(R_Sh R_Eb)\n',

            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right
      );
      textPainter.layout();

      // Draw the text centered around the point (50, 100) for instance
      final offset = Offset(
          50 - (textPainter.width / 2), 100 - (textPainter.height / 2));
      textPainter.paint(canvas, offset);
    }
  }

  // Offset transform(Offset point, Size size) {
  //   return Offset(transformX(point.dx, size), transformY(point.dy, size));
  // }
  //
  // double transformX(double x, Size size) {
  //   switch (rotation) {
  //     case InputImageRotation.ROTATION_90:
  //       return x * size.width / imageSize.height;
  //     case InputImageRotation.ROTATION_270:
  //       return size.width - x * size.width / imageSize.height;
  //     default:
  //       return x * size.width / imageSize.width;
  //   }
  // }
  //
  // double transformY(double y, Size size) {
  //   switch (rotation) {
  //     case InputImageRotation.ROTATION_90:
  //     case InputImageRotation.ROTATION_270:
  //       return y * size.height / imageSize.width;
  //     default:
  //       return y * size.height / imageSize.height;
  //   }
  // }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
