import 'package:muffin_clicker/skins/views/backgrounds/chocolate_background.dart';
import 'package:muffin_clicker/skins/views/backgrounds/moku_background.dart';
import 'package:muffin_clicker/skins/views/backgrounds/zombie_background.dart';

class SkinModel {
  final String name;
  final String image;
  final String backgroundId;
  final bool isBought;
  final int price;
  final int level;
  final double levelProgress;

  const SkinModel({
    required this.name,
    required this.image,
    required this.backgroundId,
    required this.isBought,
    required this.price,
    required this.level,
    required this.levelProgress,
  });

  SkinModel copyWith({bool? isBought, double? levelProgress, int? level}) {
    return SkinModel(
      name: name,
      image: image,
      backgroundId: backgroundId,
      isBought: isBought ?? this.isBought,
      price: price,
      level: level ?? this.level,
      levelProgress: levelProgress ?? this.levelProgress,
    );
  }

  factory SkinModel.fromJson(Map<String, dynamic> json) {
    return SkinModel(
      name: json['name'],
      image: json['image'],
      backgroundId: json['backgroundId'],
      isBought: json['isBought'],
      price: json['price'],
      level: json['level'],
      levelProgress: json['levelProgress'],
    );
  }
  
  Map<String, dynamic> toJson() {
     return {
      'name': name,
      'image': image,
      'backgroundId': backgroundId,
      'isBought': isBought,
      'price': price,
      'level': level,
      'levelProgress': levelProgress,
    };
  }
}

const chocolateBackgroundId = 'chocolateBackgroundId';
const zombieBackgroundId = 'zombieBackgroundId';
const mokuBackgroundId = 'mokuBackgroundId';

const skins = [
  SkinModel(
    name: 'Chocolate',
    image: 'assets/img/chocolate.png',
    backgroundId: chocolateBackgroundId,
    isBought: true,
    price: 0,
    level: 0,
    levelProgress: 0.0
  ),
  SkinModel(
    name: 'Zombie',
    image: 'assets/img/zombie.png',
    backgroundId: zombieBackgroundId,
    isBought: false,
    price: 100,
    level: 0,
    levelProgress: 0.0
  ),
   SkinModel(
    name: 'Moku',
    image: 'assets/img/moku.png',
    backgroundId: mokuBackgroundId,
    isBought: false,
    price: 10,
    level: 0,
    levelProgress: 0.0
  )
];

final defaultSkin = skins[0];

final mapBackgorundIdToPainter = {
  chocolateBackgroundId: ChocolateBackground(),
  zombieBackgroundId: ZombieBackground(),
  mokuBackgroundId: MokuBackground(),
};
