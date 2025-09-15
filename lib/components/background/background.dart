import 'package:aXX_am/skier_game.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef<SkierGame> {
  Background() : super(size: Vector2.zero());

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bg.jpg');
    size = gameRef.size;
    position = Vector2.zero();
  }
}
