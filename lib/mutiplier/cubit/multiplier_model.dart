class MultiplierModel {
  final int deltaTime;
  final int rewardTotalTime;

  const MultiplierModel({this.deltaTime = 0, this.rewardTotalTime = 6000});

  MultiplierModel copyWith({deltaTime}) {
    return MultiplierModel(
      deltaTime: deltaTime ?? this.deltaTime,
      rewardTotalTime: rewardTotalTime,
    );
  }

  factory MultiplierModel.fromJson(Map<String, dynamic> json) {
    return MultiplierModel(
      deltaTime: json['deltaTime'],
      rewardTotalTime: json['totalTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deltaTime': deltaTime,
      'totalTime': rewardTotalTime,
    };
  }
}
