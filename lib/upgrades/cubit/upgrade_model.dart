class UpgradeModel {
  final String name;
  final String description;
  final int level;
  final int price;
  final double priceMultiplier;
  final String iconName;
  final int clicksIncrementMultiplier;
  final int clicksPerSecondIncrement;

  const UpgradeModel({
    required this.name,
    required this.description,
    required this.level,
    required this.price,
    required this.priceMultiplier,
    required this.iconName,
    required this.clicksIncrementMultiplier,
    required this.clicksPerSecondIncrement,
  });

  UpgradeModel copyWith({ int? level, int? price }) {
    return UpgradeModel(
      name: name,
      description: description,
      level: level ?? this.level,
      price: price ?? this.price,
      priceMultiplier: priceMultiplier,
      iconName: iconName,
      clicksIncrementMultiplier: clicksIncrementMultiplier,
      clicksPerSecondIncrement: clicksPerSecondIncrement,
    );
  }

  factory UpgradeModel.fromJson(Map<String, dynamic> json) {
    return UpgradeModel(
      name: json['name'],
      description: json['description'],
      level: json['level'],
      price: json['price'],
      priceMultiplier: json['priceMultiplier'],
      iconName: json['iconName'],
      clicksIncrementMultiplier: json['clicksIncrementMultiplier'],
      clicksPerSecondIncrement: json['clicksPerSecondIncrement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'level': level,
      'price': price,
      'priceMultiplier': priceMultiplier,
      'iconName': iconName,
      'clicksIncrementMultiplier': clicksIncrementMultiplier,
      'clicksPerSecondIncrement': clicksPerSecondIncrement,
    };
  }
}

const initialUpgrades = [
  UpgradeModel(
    name: 'Muffin clicker',
    description: "Makes your clicks 2 times as powerful",
    level: 1,
    price: 20,
    priceMultiplier: 10,
    iconName: "assets/img/chocolate.png",
    clicksIncrementMultiplier: 2,
    clicksPerSecondIncrement: 0
  ),
  UpgradeModel(
    name: 'Auto muffin',
    description: "Produces 1 muffin per second",
    level: 1,
    price: 100,
    priceMultiplier: 1.15,
    iconName: "assets/img/chocolate.png",
    clicksIncrementMultiplier: 1,
    clicksPerSecondIncrement: 1
  ),
];
