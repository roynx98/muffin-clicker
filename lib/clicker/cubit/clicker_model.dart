class ClickerModel {
  int clicks;
  int clicksIncrement;
  int clicksPerSecond;

  ClickerModel({
    this.clicks = 0,
    this.clicksIncrement = 1,
    this.clicksPerSecond = 0,
  });

  ClickerModel copyWith({ int? clicks, }) {

    return ClickerModel(
      clicks: clicks ?? this.clicks,
      clicksIncrement: clicksIncrement,
      clicksPerSecond: clicksPerSecond,
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
