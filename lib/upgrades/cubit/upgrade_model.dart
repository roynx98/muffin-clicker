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
    name: 'Muffin Clicker',
    description: "Makes your clicks 2 times as powerful",
    level: 1,
    price: 20,
    priceMultiplier: 10,
    iconName: "assets/img/clicker.png",
    clicksIncrementMultiplier: 2,
    clicksPerSecondIncrement: 0
  ),
  UpgradeModel(
    name: 'Muffin Stand',
    description: "Produces 1 muffin per second",
    level: 1,
    price: 100,
    priceMultiplier: 3,
    iconName: "assets/img/stand.png",
    clicksIncrementMultiplier: 1,
    clicksPerSecondIncrement: 1,
  ),
  UpgradeModel(
    name: 'Muffin Bakery',
    description: "Produces 10 muffin per second",
    level: 1,
    price: 1000,
    priceMultiplier: 3,
    iconName: "assets/img/bakery.png",
    clicksIncrementMultiplier: 1,
    clicksPerSecondIncrement: 10,
  ),
  UpgradeModel(
    name: 'Muffin Factory',
    description: "Produces 100 muffin per second",
    level: 1,
    price: 10000,
    priceMultiplier: 3,
    iconName: "assets/img/factory.png",
    clicksIncrementMultiplier: 1,
    clicksPerSecondIncrement: 100,
  ),
];
