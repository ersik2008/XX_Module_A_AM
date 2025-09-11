import 'package:aXX_am/skier_game.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef<SkierGame> {
  @override
  Future<void> onLoad() async {
    SpriteComponent(sprite: await gameRef.loadSprite('bg.jpg'));
    size = gameRef.size;
  }
}

