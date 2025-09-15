import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../skier_game.dart';

class Coin extends SpriteComponent with HasGameRef<SkierGame>, CollisionCallbacks {
  final double speed;

  Coin(Vector2 position, {this.speed = 200})
      : super(size: Vector2(32, 32), position: position, anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('coin.png');
    add(RectangleHitbox.relative(Vector2(0.7, 0.7), parentSize: size, collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= speed * dt;
    position.y = gameRef.groundAt(position.x);

    if (position.x < -size.x) {
      removeFromParent();
    }
  }
}
