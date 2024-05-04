import 'package:muffin_clicker/skins/views/backgrounds/angry_background.dart';
import 'package:muffin_clicker/skins/views/backgrounds/zombie_background.dart';

class SkinModel {
  final String name;
  final String image;
  final String backgroundId;
  final bool isBought;
  final int price;

  const SkinModel({
    required this.name,
    required this.image,
    required this.backgroundId,
    required this.isBought,
    required this.price,
  });

  factory SkinModel.fromJson(Map<String, dynamic> json) {
    return SkinModel(
      name: json['name'],
      image: json['image'],
      backgroundId: json['backgroundId'],
      isBought: json['isBought'],
      price: json['price'],
    );
  }
  
  Map<String, dynamic> toJson() {
     return {
      'name': name,
      'image': image,
      'backgroundId': backgroundId,
      'isBought': isBought,
      'price': price,
    };
  }
}

const angryBackgroundId = 'angryBackgroundId';
const zombieBackgroundId = 'zombieBackgroundId';

const skins = [
  SkinModel(
    name: 'Chocolate',
    image: 'assets/img/chocolateMuffin.png',
    backgroundId: angryBackgroundId,
    isBought: true,
    price: 0,
  ),
  SkinModel(
    name: 'Zombie',
    image: 'assets/img/zombieMuffin.png',
    backgroundId: zombieBackgroundId,
    isBought: false,
    price: 1,
  )
];

final defaultSkin = skins[0];

final mapBackgorundIdToPainter = {
  angryBackgroundId: AngryBackground(),
  zombieBackgroundId: ZombieBackground(),
};
