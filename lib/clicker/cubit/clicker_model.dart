class ClickerModel {
  final int clicks;
  final int clicksIncrement;
  final int clicksPerSecond;

  const ClickerModel({
    this.clicks = 0,
    this.clicksIncrement = 1,
    this.clicksPerSecond = 0,
  });

  ClickerModel copyWith({
    int? clicks,
    int? clicksIncrement,
    int? clicksPerSecond,
  }) {
    return ClickerModel(
      clicks: clicks ?? this.clicks,
      clicksIncrement: clicksIncrement ?? this.clicksIncrement,
      clicksPerSecond: clicksPerSecond ?? this.clicksPerSecond,
    );
  }

  factory ClickerModel.fromJson(Map<String, dynamic> json) {
    return ClickerModel(
      clicks: json['clicks'],
      clicksIncrement: json['clicksIncrement'],
      clicksPerSecond: json['clicksPerSecond'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clicks': clicks,
      'clicksIncrement': clicksIncrement,
      'clicksPerSecond': clicksPerSecond,
    };
  }
}
