import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../skier_game.dart';

class Obstacle extends SpriteComponent with HasGameRef<SkierGame>, CollisionCallbacks {
  final double speed;

  Obstacle(Vector2 position, {this.speed = 200})
      : super(size: Vector2(40, 40), position: position, anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('obstacle.png');
    add(RectangleHitbox.relative(Vector2(0.7, 0.7), parentSize: size, collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= speed * dt;

    // всегда корректируем Y по линии пола (использует clamp внутри)
    position.y = gameRef.groundAt(position.x);

    if (position.x < -size.x) {
      removeFromParent();
    }
  }
}
