import 'package:aXX_am/skier_game.dart';
import 'package:flame/components.dart';

class Tree extends SpriteComponent with HasGameRef<SkierGame> {
  Tree() : super(size: Vector2.zero(), priority: -1);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('trees.png');

    // Делаем деревья шире (на 1.4 экрана) и выше (60% экрана)
    size = Vector2(gameRef.size.x * 1.2, gameRef.size.y * 0.6);

    // Смещаем левее и чуть ниже
    position = Vector2(-gameRef.size.x * 0.2, gameRef.size.y - size.y * 0.85);
  }
}
