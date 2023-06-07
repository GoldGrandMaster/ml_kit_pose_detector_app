// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int code;
  String msg;
  Result result;

  Post({
    required this.code,
    required this.msg,
    required this.result,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        code: json["code"],
        msg: json["msg"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "result": result.toJson(),
      };
}

class Result {
  Data data;

  Result({
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  ActionInfo actionInfo;
  String actionId;
  String name;
  int type;
  List<Stage> stage1;
  List<Stage> stage2;
  Other other;

  Data({
    required this.actionInfo,
    required this.actionId,
    required this.name,
    required this.type,
    required this.stage1,
    required this.stage2,
    required this.other,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        actionInfo: ActionInfo.fromJson(json["action_info"]),
        actionId: json["action_id"],
        name: json["name"],
        type: json["type"],
        stage1: List<Stage>.from(json["stage1"].map((x) => Stage.fromJson(x))),
        stage2: List<Stage>.from(json["stage2"].map((x) => Stage.fromJson(x))),
        other: Other.fromJson(json["other"]),
      );

  Map<String, dynamic> toJson() => {
        "action_info": actionInfo.toJson(),
        "action_id": actionId,
        "name": name,
        "type": type,
        "stage1": List<dynamic>.from(stage1.map((x) => x.toJson())),
        "stage2": List<dynamic>.from(stage2.map((x) => x.toJson())),
        "other": other.toJson(),
      };
}

class ActionInfo {
  int id;
  dynamic uid;
  String title;
  String tTitle;
  String actionId;
  int catid;
  int type;
  dynamic lvl;
  dynamic time;
  dynamic device;
  dynamic showPower;
  dynamic showTime;
  int exchange;
  int pmSwitch;
  int weightSet;
  int pointing;
  dynamic duration;
  int repsOnly;
  dynamic score;
  int recommend;
  int numberScore;
  int numberMax;
  dynamic timeMax;
  dynamic timeScore;
  dynamic repMax;
  dynamic repScore;
  int timeOnly;
  dynamic secondSuccessMsg;
  dynamic tSecondSuccessMsg;
  dynamic isTop;
  int isDel;
  int orderlist;
  DateTime createTime;
  DateTime updateTime;
  int status;

  ActionInfo({
    required this.id,
    this.uid,
    required this.title,
    required this.tTitle,
    required this.actionId,
    required this.catid,
    required this.type,
    this.lvl,
    this.time,
    this.device,
    this.showPower,
    this.showTime,
    required this.exchange,
    required this.pmSwitch,
    required this.weightSet,
    required this.pointing,
    this.duration,
    required this.repsOnly,
    this.score,
    required this.recommend,
    required this.numberScore,
    required this.numberMax,
    this.timeMax,
    this.timeScore,
    this.repMax,
    this.repScore,
    required this.timeOnly,
    this.secondSuccessMsg,
    this.tSecondSuccessMsg,
    this.isTop,
    required this.isDel,
    required this.orderlist,
    required this.createTime,
    required this.updateTime,
    required this.status,
  });

  factory ActionInfo.fromJson(Map<String, dynamic> json) => ActionInfo(
        id: json["id"],
        uid: json["uid"],
        title: json["title"],
        tTitle: json["t_title"],
        actionId: json["action_id"],
        catid: json["catid"],
        type: json["type"],
        lvl: json["lvl"],
        time: json["time"],
        device: json["device"],
        showPower: json["show_power"],
        showTime: json["show_time"],
        exchange: json["exchange"],
        pmSwitch: json["pm_switch"],
        weightSet: json["weight_set"],
        pointing: json["pointing"],
        duration: json["duration"],
        repsOnly: json["reps_only"],
        score: json["score"],
        recommend: json["recommend"],
        numberScore: json["number_score"],
        numberMax: json["number_max"],
        timeMax: json["time_max"],
        timeScore: json["time_score"],
        repMax: json["rep_max"],
        repScore: json["rep_score"],
        timeOnly: json["time_only"],
        secondSuccessMsg: json["second_success_msg"],
        tSecondSuccessMsg: json["t_second_success_msg"],
        isTop: json["is_top"],
        isDel: json["is_del"],
        orderlist: json["orderlist"],
        createTime: DateTime.parse(json["create_time"]),
        updateTime: DateTime.parse(json["update_time"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "title": title,
        "t_title": tTitle,
        "action_id": actionId,
        "catid": catid,
        "type": type,
        "lvl": lvl,
        "time": time,
        "device": device,
        "show_power": showPower,
        "show_time": showTime,
        "exchange": exchange,
        "pm_switch": pmSwitch,
        "weight_set": weightSet,
        "pointing": pointing,
        "duration": duration,
        "reps_only": repsOnly,
        "score": score,
        "recommend": recommend,
        "number_score": numberScore,
        "number_max": numberMax,
        "time_max": timeMax,
        "time_score": timeScore,
        "rep_max": repMax,
        "rep_score": repScore,
        "time_only": timeOnly,
        "second_success_msg": secondSuccessMsg,
        "t_second_success_msg": tSecondSuccessMsg,
        "is_top": isTop,
        "is_del": isDel,
        "orderlist": orderlist,
        "create_time": createTime.toIso8601String(),
        "update_time": updateTime.toIso8601String(),
        "status": status,
      };
}

class Other {
  dynamic uid;
  int actionId;
  int line1Point1;
  int line1Point2;
  String line2Point1;
  String line2Point2;
  int lineLt;
  String lineLtMsg;
  String tLineLtMsg;
  String lineGt;
  String lineGtMsg;
  String tLineGtMsg;
  dynamic timeLt;
  dynamic timeLtMsg;
  dynamic tTimeLtMsg;
  dynamic timeSurplus;
  dynamic timeSurplusMsg;
  dynamic tTimeSurplusMsg;
  String numGt;
  String numGtMsg;
  String tNumGtMsg;
  String numSurplus;
  String numSurplusMsg;
  String tNumSurplusMsg;
  String secondSuccessMsg;
  String tSecondSuccessMsg;
  DateTime createTime;
  DateTime updateTime;
  dynamic sort;
  dynamic status;

  Other({
    this.uid,
    required this.actionId,
    required this.line1Point1,
    required this.line1Point2,
    required this.line2Point1,
    required this.line2Point2,
    required this.lineLt,
    required this.lineLtMsg,
    required this.tLineLtMsg,
    required this.lineGt,
    required this.lineGtMsg,
    required this.tLineGtMsg,
    this.timeLt,
    this.timeLtMsg,
    this.tTimeLtMsg,
    this.timeSurplus,
    this.timeSurplusMsg,
    this.tTimeSurplusMsg,
    required this.numGt,
    required this.numGtMsg,
    required this.tNumGtMsg,
    required this.numSurplus,
    required this.numSurplusMsg,
    required this.tNumSurplusMsg,
    required this.secondSuccessMsg,
    required this.tSecondSuccessMsg,
    required this.createTime,
    required this.updateTime,
    this.sort,
    this.status,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        uid: json["uid"],
        actionId: json["action_id"],
        line1Point1: json["line1_point1"],
        line1Point2: json["line1_point2"],
        line2Point1: json["line2_point1"],
        line2Point2: json["line2_point2"],
        lineLt: json["line_lt"],
        lineLtMsg: json["line_lt_msg"],
        tLineLtMsg: json["t_line_lt_msg"],
        lineGt: json["line_gt"],
        lineGtMsg: json["line_gt_msg"],
        tLineGtMsg: json["t_line_gt_msg"],
        timeLt: json["time_lt"],
        timeLtMsg: json["time_lt_msg"],
        tTimeLtMsg: json["t_time_lt_msg"],
        timeSurplus: json["time_surplus"],
        timeSurplusMsg: json["time_surplus_msg"],
        tTimeSurplusMsg: json["t_time_surplus_msg"],
        numGt: json["num_gt"],
        numGtMsg: json["num_gt_msg"],
        tNumGtMsg: json["t_num_gt_msg"],
        numSurplus: json["num_surplus"],
        numSurplusMsg: json["num_surplus_msg"],
        tNumSurplusMsg: json["t_num_surplus_msg"],
        secondSuccessMsg: json["second_success_msg"],
        tSecondSuccessMsg: json["t_second_success_msg"],
        createTime: DateTime.parse(json["create_time"]),
        updateTime: DateTime.parse(json["update_time"]),
        sort: json["sort"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "action_id": actionId,
        "line1_point1": line1Point1,
        "line1_point2": line1Point2,
        "line2_point1": line2Point1,
        "line2_point2": line2Point2,
        "line_lt": lineLt,
        "line_lt_msg": lineLtMsg,
        "t_line_lt_msg": tLineLtMsg,
        "line_gt": lineGt,
        "line_gt_msg": lineGtMsg,
        "t_line_gt_msg": tLineGtMsg,
        "time_lt": timeLt,
        "time_lt_msg": timeLtMsg,
        "t_time_lt_msg": tTimeLtMsg,
        "time_surplus": timeSurplus,
        "time_surplus_msg": timeSurplusMsg,
        "t_time_surplus_msg": tTimeSurplusMsg,
        "num_gt": numGt,
        "num_gt_msg": numGtMsg,
        "t_num_gt_msg": tNumGtMsg,
        "num_surplus": numSurplus,
        "num_surplus_msg": numSurplusMsg,
        "t_num_surplus_msg": tNumSurplusMsg,
        "second_success_msg": secondSuccessMsg,
        "t_second_success_msg": tSecondSuccessMsg,
        "create_time": createTime.toIso8601String(),
        "update_time": updateTime.toIso8601String(),
        "sort": sort,
        "status": status,
      };
}

class Stage {
  int id;
  dynamic uid;
  int actionId;
  String joint;
  int exchange;
  dynamic exchangeJoint;
  int stage;
  int isMove;
  dynamic enterActionMin;
  dynamic enterActionMax;
  dynamic pfEnterActionMin;
  dynamic pfEnterActionMax;
  String angle;
  String angle1;
  String angle2;
  String stageTime;
  String failTime;
  String failMsg;
  String tFailMsg;
  String variance;
  int pointOnly;
  int recommendOnly;
  String angleGt;
  String angleGtMsg;
  String tAngleGtMsg;
  String angleLt;
  String angleLtMsg;
  String? tAngleLtMsg;
  dynamic distanceGt;
  dynamic distanceGtMsg;
  dynamic tDistanceGtMsg;
  dynamic distanceLt;
  dynamic distanceLtMsg;
  dynamic tDistanceLtMsg;
  String timeLt;
  String timeLtMsg;
  String tTimeLtMsg;
  String timeGt;
  String timeGtMsg;
  String tTimeGtMsg;
  DateTime createTime;
  DateTime updateTime;
  int sort;
  dynamic status;

  Stage({
    required this.id,
    this.uid,
    required this.actionId,
    required this.joint,
    required this.exchange,
    this.exchangeJoint,
    required this.stage,
    required this.isMove,
    this.enterActionMin,
    this.enterActionMax,
    this.pfEnterActionMin,
    this.pfEnterActionMax,
    required this.angle,
    required this.angle1,
    required this.angle2,
    required this.stageTime,
    required this.failTime,
    required this.failMsg,
    required this.tFailMsg,
    required this.variance,
    required this.pointOnly,
    required this.recommendOnly,
    required this.angleGt,
    required this.angleGtMsg,
    required this.tAngleGtMsg,
    required this.angleLt,
    required this.angleLtMsg,
    this.tAngleLtMsg,
    this.distanceGt,
    this.distanceGtMsg,
    this.tDistanceGtMsg,
    this.distanceLt,
    this.distanceLtMsg,
    this.tDistanceLtMsg,
    required this.timeLt,
    required this.timeLtMsg,
    required this.tTimeLtMsg,
    required this.timeGt,
    required this.timeGtMsg,
    required this.tTimeGtMsg,
    required this.createTime,
    required this.updateTime,
    required this.sort,
    this.status,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        uid: json["uid"],
        actionId: json["action_id"],
        joint: json["joint"],
        exchange: json["exchange"],
        exchangeJoint: json["exchange_joint"],
        stage: json["stage"],
        isMove: json["is_move"],
        enterActionMin: json["enter_action_min"],
        enterActionMax: json["enter_action_max"],
        pfEnterActionMin: json["pf_enter_action_min"],
        pfEnterActionMax: json["pf_enter_action_max"],
        angle: json["angle"],
        angle1: json["angle1"],
        angle2: json["angle2"],
        stageTime: json["stage_time"],
        failTime: json["fail_time"],
        failMsg: json["fail_msg"],
        tFailMsg: json["t_fail_msg"],
        variance: json["variance"],
        pointOnly: json["point_only"],
        recommendOnly: json["recommend_only"],
        angleGt: json["angle_gt"],
        angleGtMsg: json["angle_gt_msg"],
        tAngleGtMsg: json["t_angle_gt_msg"],
        angleLt: json["angle_lt"],
        angleLtMsg: json["angle_lt_msg"],
        tAngleLtMsg: json["t_angle_lt_msg"],
        distanceGt: json["distance_gt"],
        distanceGtMsg: json["distance_gt_msg"],
        tDistanceGtMsg: json["t_distance_gt_msg"],
        distanceLt: json["distance_lt"],
        distanceLtMsg: json["distance_lt_msg"],
        tDistanceLtMsg: json["t_distance_lt_msg"],
        timeLt: json["time_lt"],
        timeLtMsg: json["time_lt_msg"],
        tTimeLtMsg: json["t_time_lt_msg"],
        timeGt: json["time_gt"],
        timeGtMsg: json["time_gt_msg"],
        tTimeGtMsg: json["t_time_gt_msg"],
        createTime: DateTime.parse(json["create_time"]),
        updateTime: DateTime.parse(json["update_time"]),
        sort: json["sort"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "action_id": actionId,
        "joint": joint,
        "exchange": exchange,
        "exchange_joint": exchangeJoint,
        "stage": stage,
        "is_move": isMove,
        "enter_action_min": enterActionMin,
        "enter_action_max": enterActionMax,
        "pf_enter_action_min": pfEnterActionMin,
        "pf_enter_action_max": pfEnterActionMax,
        "angle": angle,
        "angle1": angle1,
        "angle2": angle2,
        "stage_time": stageTime,
        "fail_time": failTime,
        "fail_msg": failMsg,
        "t_fail_msg": tFailMsg,
        "variance": variance,
        "point_only": pointOnly,
        "recommend_only": recommendOnly,
        "angle_gt": angleGt,
        "angle_gt_msg": angleGtMsg,
        "t_angle_gt_msg": tAngleGtMsg,
        "angle_lt": angleLt,
        "angle_lt_msg": angleLtMsg,
        "t_angle_lt_msg": tAngleLtMsg,
        "distance_gt": distanceGt,
        "distance_gt_msg": distanceGtMsg,
        "t_distance_gt_msg": tDistanceGtMsg,
        "distance_lt": distanceLt,
        "distance_lt_msg": distanceLtMsg,
        "t_distance_lt_msg": tDistanceLtMsg,
        "time_lt": timeLt,
        "time_lt_msg": timeLtMsg,
        "t_time_lt_msg": tTimeLtMsg,
        "time_gt": timeGt,
        "time_gt_msg": timeGtMsg,
        "t_time_gt_msg": tTimeGtMsg,
        "create_time": createTime.toIso8601String(),
        "update_time": updateTime.toIso8601String(),
        "sort": sort,
        "status": status,
      };
}
