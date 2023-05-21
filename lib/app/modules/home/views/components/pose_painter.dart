import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'coordinate_translator.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as vector;

class PosePainter extends CustomPainter {
  PosePainter(this.poses, this.absoluteImageSize, this.rotation);

  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  int cnt = 0;
  int tp_cnt = 0;
  int prv = -1, cur = -1;
  bool bf1 = false, bf2 = false, bf3 = false, bf4 = false;

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

    double floorWithFixedDecimal(double number, int decimalPlaces) =>
        (number * pow(10, decimalPlaces)).floorToDouble() /
        pow(10, decimalPlaces);

    //Calcuate angle of 3 joint points
    double calculateAngle(Offset p1, Offset p2, Offset p3) {
      final vector.Vector2 v1 = vector.Vector2(p1.dx - p2.dx, p1.dy - p2.dy);
      final vector.Vector2 v2 = vector.Vector2(p3.dx - p2.dx, p3.dy - p2.dy);
      final double dotProduct = v1.dot(v2);
      final double cosAngle = dotProduct / (v1.length * v2.length);
      final double angle = acos(cosAngle);
      double degrees = angle * 180 / pi; // Convert to degrees
      if (degrees > 180.0) degrees = 360 - degrees;
      return degrees;
    }

    //Angle of joint
    double angleShow(joint1, joint2, joint3) {
      return calculateAngle(
        Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
            translateY(joint1.y, rotation, size, absoluteImageSize)),
        Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
            translateY(joint2.y, rotation, size, absoluteImageSize)),
        Offset(translateX(joint3.x, rotation, size, absoluteImageSize),
            translateY(joint3.y, rotation, size, absoluteImageSize)),
      );
    }

    int leftElbowAngle, rightElbowAngle;

    for (final pose in poses) {
      final PoseLandmark jointNose = pose.landmarks[PoseLandmarkType.nose]!;
      final PoseLandmark jointLeftEyeInner =
          pose.landmarks[PoseLandmarkType.leftEyeInner]!;
      final PoseLandmark jointLeftEye =
          pose.landmarks[PoseLandmarkType.leftEye]!;
      final PoseLandmark jointLeftEyeOuter =
          pose.landmarks[PoseLandmarkType.leftEyeOuter]!;
      final PoseLandmark jointRightEyeInner =
          pose.landmarks[PoseLandmarkType.rightEyeInner]!;
      final PoseLandmark jointRightEye =
          pose.landmarks[PoseLandmarkType.rightEye]!;
      final PoseLandmark jointRightEyeOuter =
          pose.landmarks[PoseLandmarkType.rightEyeOuter]!;
      final PoseLandmark jointLeftEar =
          pose.landmarks[PoseLandmarkType.leftEar]!;
      final PoseLandmark jointRightEar =
          pose.landmarks[PoseLandmarkType.rightEar]!;
      final PoseLandmark jointLeftMouth =
          pose.landmarks[PoseLandmarkType.leftMouth]!;
      final PoseLandmark jointRightMouth =
          pose.landmarks[PoseLandmarkType.rightMouth]!;
      final PoseLandmark jointLeftShoulder =
          pose.landmarks[PoseLandmarkType.leftShoulder]!;
      final PoseLandmark jointRightShoulder =
          pose.landmarks[PoseLandmarkType.rightShoulder]!;
      final PoseLandmark jointLeftElbow =
          pose.landmarks[PoseLandmarkType.leftElbow]!;
      final PoseLandmark jointRightElbow =
          pose.landmarks[PoseLandmarkType.rightElbow]!;
      final PoseLandmark jointLeftWrist =
          pose.landmarks[PoseLandmarkType.leftWrist]!;
      final PoseLandmark jointRightWrist =
          pose.landmarks[PoseLandmarkType.rightWrist]!;
      final PoseLandmark jointLeftPinky =
          pose.landmarks[PoseLandmarkType.leftPinky]!;
      final PoseLandmark jointRightPinky =
          pose.landmarks[PoseLandmarkType.rightPinky]!;
      final PoseLandmark jointLeftIndex =
          pose.landmarks[PoseLandmarkType.leftIndex]!;
      final PoseLandmark jointRightIndex =
          pose.landmarks[PoseLandmarkType.rightIndex]!;
      final PoseLandmark jointLeftThumb =
          pose.landmarks[PoseLandmarkType.leftThumb]!;
      final PoseLandmark jointRightThumb =
          pose.landmarks[PoseLandmarkType.rightThumb]!;
      final PoseLandmark jointLeftHip =
          pose.landmarks[PoseLandmarkType.leftHip]!;
      final PoseLandmark jointRightHip =
          pose.landmarks[PoseLandmarkType.rightHip]!;
      final PoseLandmark jointLeftKnee =
          pose.landmarks[PoseLandmarkType.leftKnee]!;
      final PoseLandmark jointRightKnee =
          pose.landmarks[PoseLandmarkType.rightKnee]!;
      final PoseLandmark jointLeftAnkle =
          pose.landmarks[PoseLandmarkType.leftAnkle]!;
      final PoseLandmark jointRightAnkle =
          pose.landmarks[PoseLandmarkType.rightAnkle]!;
      final PoseLandmark jointLeftHeel =
          pose.landmarks[PoseLandmarkType.leftHeel]!;
      final PoseLandmark jointRightHeel =
          pose.landmarks[PoseLandmarkType.rightHeel]!;
      final PoseLandmark jointLeftFootIndex =
          pose.landmarks[PoseLandmarkType.leftFootIndex]!;
      final PoseLandmark jointRightFootIndex =
          pose.landmarks[PoseLandmarkType.rightFootIndex]!;

      double tp = 0.99;
      bool bf = true;
      bf = bf &&
          (jointNose.likelihood >= tp) &&
          (jointLeftEyeInner.likelihood >= tp) &&
          (jointLeftEye.likelihood >= tp) &&
          (jointLeftEyeOuter.likelihood >= tp) &&
          (jointRightEyeInner.likelihood >= tp) &&
          (jointRightEye.likelihood >= tp) &&
          (jointRightEyeOuter.likelihood >= tp) &&
          (jointLeftEar.likelihood >= tp) &&
          (jointRightEar.likelihood >= tp) &&
          (jointLeftMouth.likelihood >= tp) &&
          (jointRightMouth.likelihood >= tp) &&
          (jointLeftShoulder.likelihood >= tp) &&
          (jointRightShoulder.likelihood >= tp) &&
          (jointLeftElbow.likelihood >= tp) &&
          (jointRightElbow.likelihood >= tp) &&
          (jointLeftWrist.likelihood >= tp) &&
          (jointRightWrist.likelihood >= tp) &&
          (jointLeftPinky.likelihood >= tp) &&
          (jointRightPinky.likelihood >= tp) &&
          (jointLeftIndex.likelihood >= tp) &&
          (jointRightIndex.likelihood >= tp) &&
          (jointLeftThumb.likelihood >= tp) &&
          (jointRightThumb.likelihood >= tp) &&
          (jointLeftHip.likelihood >= tp) &&
          (jointRightHip.likelihood >= tp) &&
          (jointLeftKnee.likelihood >= tp) &&
          (jointRightKnee.likelihood >= tp) &&
          (jointLeftAnkle.likelihood >= tp) &&
          (jointRightAnkle.likelihood >= tp) &&
          (jointLeftHeel.likelihood >= tp) &&
          (jointRightHeel.likelihood >= tp) &&
          (jointLeftFootIndex.likelihood >= tp) &&
          (jointRightFootIndex.likelihood >= tp);

      //Notificiation when user's body not fully visible or correct distance
      if (!bf) {
        final notification = TextSpan(
          text:
              'Please Keep your body fully\nvisible on camera to start or\nKeep distance as 5 to 6 ft!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        );
        final notificationText = TextPainter(
          text: notification,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        notificationText.layout();

        final notificationPosition = Offset(
            195 - (notificationText.width * 0.5),
            50 - (notificationText.height * 0.5));
        notificationText.paint(canvas, notificationPosition);
      }

      //Display Inframelikelihood value of joints
      final likelihood = TextSpan(
        text: 'inframeLikelihood\n' +
            'Nose:${floorWithFixedDecimal(jointNose.likelihood, 4)}\n' +
            'LeftEyeIneer:${floorWithFixedDecimal(jointLeftEyeInner.likelihood, 4)}\n' +
            'LeftEye:${floorWithFixedDecimal(jointLeftEye.likelihood, 4)}\n' +
            'LeftEyeOuter:${floorWithFixedDecimal(jointLeftEyeOuter.likelihood, 4)}\n' +
            'RightEyeInner:${floorWithFixedDecimal(jointRightEyeInner.likelihood, 4)}\n' +
            'RightEye:${floorWithFixedDecimal(jointRightEye.likelihood, 4)}\n' +
            'RightEyeOuter:${floorWithFixedDecimal(jointRightEyeOuter.likelihood, 4)}\n' +
            'LeftEar:${floorWithFixedDecimal(jointLeftEar.likelihood, 4)}\n' +
            'RightEar:${floorWithFixedDecimal(jointRightEar.likelihood, 4)}\n' +
            'LeftMouth:${floorWithFixedDecimal(jointLeftMouth.likelihood, 4)}\n' +
            'RightMouth:${floorWithFixedDecimal(jointRightMouth.likelihood, 4)}\n' +
            'LeftShoulder:${floorWithFixedDecimal(jointLeftShoulder.likelihood, 4)}\n' +
            'RightShoulder:${floorWithFixedDecimal(jointRightShoulder.likelihood, 4)}\n' +
            'LeftElbow:${floorWithFixedDecimal(jointLeftElbow.likelihood, 4)}\n' +
            'RightElbow:${floorWithFixedDecimal(jointRightElbow.likelihood, 4)}\n' +
            'LeftWrist:${floorWithFixedDecimal(jointLeftWrist.likelihood, 4)}\n' +
            'RightWrist:${floorWithFixedDecimal(jointRightWrist.likelihood, 4)}\n' +
            'LeftPinky:${floorWithFixedDecimal(jointLeftPinky.likelihood, 4)}\n' +
            'RightPinky:${floorWithFixedDecimal(jointRightPinky.likelihood, 4)}\n' +
            'LeftIndex:${floorWithFixedDecimal(jointLeftIndex.likelihood, 4)}\n' +
            'RightIndex:${floorWithFixedDecimal(jointRightIndex.likelihood, 4)}\n' +
            'LeftThumb:${floorWithFixedDecimal(jointLeftThumb.likelihood, 4)}\n' +
            'RightThumb:${floorWithFixedDecimal(jointRightThumb.likelihood, 4)}\n' +
            'LeftHip:${floorWithFixedDecimal(jointLeftHip.likelihood, 4)}\n' +
            'LeftRightHip:${floorWithFixedDecimal(jointRightHip.likelihood, 4)}\n' +
            'LeftKnee:${floorWithFixedDecimal(jointLeftKnee.likelihood, 4)}\n' +
            'RightKnee:${floorWithFixedDecimal(jointRightKnee.likelihood, 4)}\n' +
            'LeftAnkle:${floorWithFixedDecimal(jointLeftAnkle.likelihood, 4)}\n' +
            'RightAnkle:${floorWithFixedDecimal(jointRightAnkle.likelihood, 4)}\n' +
            'LeftHeel:${floorWithFixedDecimal(jointLeftHeel.likelihood, 4)}\n' +
            'RightHeel:${floorWithFixedDecimal(jointRightHeel.likelihood, 4)}\n' +
            'LeftFootIndex:${floorWithFixedDecimal(jointLeftFootIndex.likelihood, 4)}\n' +
            'RightFootIndex:${floorWithFixedDecimal(jointRightFootIndex.likelihood, 4)}\n',
        style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 15,
        ),
      );
      final likelihoodText = TextPainter(
        text: likelihood,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      likelihoodText.layout();

      final likelihoodPosition = Offset(90 - (likelihoodText.width * 0.5),
          430 - (likelihoodText.height * 0.5));
      likelihoodText.paint(canvas, likelihoodPosition);

      //Points of pose
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
            Offset(
              translateX(landmark.x, rotation, size, absoluteImageSize),
              translateY(landmark.y, rotation, size, absoluteImageSize),
            ),
            1,
            paint);
      });

      //Line between two joints
      void paintLine(joint1, joint2, Paint paintType) {
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            paintType);
      }

      //Draw arms
      paintLine(jointLeftElbow, jointLeftWrist, leftPaint);
      paintLine(jointLeftShoulder, jointLeftElbow, leftPaint);
      paintLine(jointRightShoulder, jointRightElbow, rightPaint);
      paintLine(jointRightElbow, jointRightWrist, rightPaint);

      //Draw hands
      paintLine(jointLeftWrist, jointLeftThumb, leftPaint);
      paintLine(jointLeftWrist, jointLeftIndex, leftPaint);
      paintLine(jointLeftWrist, jointLeftPinky, leftPaint);
      paintLine(jointRightWrist, jointRightThumb, rightPaint);
      paintLine(jointRightWrist, jointRightIndex, rightPaint);
      paintLine(jointRightWrist, jointRightPinky, rightPaint);

      //Draw body
      paintLine(jointLeftShoulder, jointLeftHip, leftPaint);
      paintLine(jointRightShoulder, jointRightHip, rightPaint);
      paintLine(jointLeftShoulder, jointRightShoulder, whitePaint);
      paintLine(jointLeftHip, jointRightHip, whitePaint);

      //Draw legs
      paintLine(jointLeftHip, jointLeftKnee, leftPaint);
      paintLine(jointLeftKnee, jointLeftAnkle, leftPaint);
      paintLine(jointLeftAnkle, jointLeftHeel, leftPaint);
      paintLine(jointLeftHeel, jointLeftFootIndex, leftPaint);
      paintLine(jointLeftAnkle, jointLeftFootIndex, leftPaint);
      paintLine(jointRightHip, jointRightKnee, rightPaint);
      paintLine(jointRightKnee, jointRightAnkle, rightPaint);
      paintLine(jointRightAnkle, jointRightHeel, rightPaint);
      paintLine(jointRightHeel, jointRightFootIndex, rightPaint);
      paintLine(jointRightAnkle, jointRightFootIndex, rightPaint);

      //Display angle of joints
      final angleJoints = TextSpan(
        text: '${angleShow(jointLeftElbow, jointLeftWrist, jointLeftIndex).toInt()}°(L_Wr)\n' +
            '${angleShow(jointRightElbow, jointRightWrist, jointRightIndex).toInt()}°(R_Wr)\n' +
            '${angleShow(jointLeftShoulder, jointLeftHip, jointLeftKnee).toInt()}°(L_Hp L_Kn)\n' +
            '${angleShow(jointRightShoulder, jointRightHip, jointRightKnee).toInt()}°(R_Hp R_Kn)\n' +
            '${angleShow(jointLeftShoulder, jointLeftHip, jointLeftAnkle).toInt()}°(L_Hp L_Ak)\n' +
            '${angleShow(jointRightShoulder, jointRightHip, jointRightAnkle).toInt()}°(R_Hp R_Ak)\n' +
            '${angleShow(jointLeftAnkle, jointLeftKnee, jointLeftHip).toInt()}°(L_Kn)\n' +
            '${angleShow(jointRightAnkle, jointRightKnee, jointRightHip).toInt()}°(R_Kn)\n' +
            '${angleShow(jointLeftKnee, jointLeftAnkle, jointLeftFootIndex).toInt()}°(L_Ft)\n' +
            '${angleShow(jointRightKnee, jointRightAnkle, jointRightFootIndex).toInt()}°(R_Ft)\n' +
            '${angleShow(jointLeftShoulder, jointLeftElbow, jointLeftWrist).toInt()}°(L_Eb)\n' +
            '${angleShow(jointRightShoulder, jointRightElbow, jointRightWrist).toInt()}°(R_Eb)\n' +
            '${angleShow(jointLeftHip, jointLeftShoulder, jointLeftWrist).toInt()}°(L_Sh L_Wr)\n' +
            '${angleShow(jointRightHip, jointRightShoulder, jointRightWrist).toInt()}°(R_Sh R_Wr)\n' +
            '${angleShow(jointLeftHip, jointLeftShoulder, jointLeftElbow).toInt()}°(L_Sh L_Eb)\n' +
            '${angleShow(jointRightHip, jointRightShoulder, jointRightElbow).toInt()}°(R_Sh R_Eb)\n',
        style: TextStyle(
          color: Colors.cyanAccent,
          fontSize: 18,
        ),
      );

      final angleJointsText = TextPainter(
        text: angleJoints,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );

      angleJointsText.layout();
      // Draw the text centered around the point (x, y) for instance
      final angleJointsPosition = Offset(333 - (angleJointsText.width * 0.5),
          400 - (angleJointsText.height * 0.5));
      angleJointsText.paint(canvas, angleJointsPosition);

      //Count of repetitions
      leftElbowAngle =
          angleShow(jointLeftShoulder, jointLeftElbow, jointLeftWrist).toInt();
      rightElbowAngle =
          angleShow(jointRightShoulder, jointRightElbow, jointRightWrist)
              .toInt();
      int downLimit = 90, upLimit = 90;
      if (leftElbowAngle >= downLimit && rightElbowAngle >= downLimit) {
        prv = cur;
        cur = -1;
      } else /*if (leftElbowAngle < upLimit && rightElbowAngle < upLimit) */ {
        prv = cur;
        cur = 1;
      }
      if (prv == 1 && cur == -1) {
        print("------------ok-------------");
        cnt++;
      }
      // if (!bf1 && prv == -1 && cur == 0) {
      //   bf1 = true;
      //   tp_cnt++;
      //   prv = cur;
      // }
      // if (!bf2 && prv == 0 && cur == 1) {
      //   bf2 = true;
      //   tp_cnt++;
      //   prv = cur;
      // }
      // if (!bf3 && prv == 1 && cur == 0) {
      //   bf3 = true;
      //   tp_cnt++;
      //   prv = cur;
      // }
      // if (!bf4 && prv == 0 && cur == -1) {
      //   bf4 = true;
      //   tp_cnt++;
      //   prv = cur = -1;
      // }
      // if (tp_cnt == 4) {
      //   bf1 = bf2 = bf3 = bf4 = false;
      //   tp_cnt = 0;
      //   cnt++;
      // }
      // print()

      final repetition = TextSpan(
        text: 'prv:${prv} ' + 'cur:${cur} ' + 'cnt:${cnt}\n',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
      final repetitionText = TextPainter(
        text: repetition,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      repetitionText.layout();

      final repetitionPosition = Offset(400 - (repetitionText.width * 0.5),
          150 - (repetitionText.height * 0.5));
      repetitionText.paint(canvas, repetitionPosition);
      // prv = cur;
    }
    print('**************************************************');
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
