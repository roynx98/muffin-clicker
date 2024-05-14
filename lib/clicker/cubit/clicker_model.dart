class ClickerModel {
  final int clicks;
  final int clicksIncrement;
  final int clicksPerSecond;
  final int multiplier;

  const ClickerModel({
    this.clicks = 0,
    this.clicksIncrement = 1,
    this.clicksPerSecond = 0,
    this.multiplier = 1,
  });

  ClickerModel copyWith({
    int? clicks,
    int? clicksIncrement,
    int? clicksPerSecond,
    int? multiplier,
  }) {
    return ClickerModel(
      clicks: clicks ?? this.clicks,
      clicksIncrement: clicksIncrement ?? this.clicksIncrement,
      clicksPerSecond: clicksPerSecond ?? this.clicksPerSecond,
      multiplier: multiplier ?? this.multiplier,
    );
  }

  factory ClickerModel.fromJson(Map<String, dynamic> json) {
    return ClickerModel(
      clicks: json['clicks'],
      clicksIncrement: json['clicksIncrement'],
      clicksPerSecond: json['clicksPerSecond'],
      multiplier: json['multiplier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clicks': clicks,
      'clicksIncrement': clicksIncrement,
      'clicksPerSecond': clicksPerSecond,
      'multiplier': multiplier,
    };
  }

}
