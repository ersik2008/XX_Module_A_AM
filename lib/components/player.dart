import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import '../skier_game.dart';
import 'coin.dart';
import 'obstacle.dart';

class Player extends SpriteComponent
    with HasGameRef<SkierGame>, CollisionCallbacks {
  bool isJumping = false;
  double jumpVelocity = 0;

  Player() : super(size: Vector2(72, 72), anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('skiing_person.png');

    // начальная X-позиция
    final double startX = 50.0;
    final double groundY = gameRef.groundAt(startX);

    // anchor = bottomCenter => position.y = groundY (нижняя точка спрайта = земля)
    position = Vector2(startX, groundY);

    // угол наклона пола для ориентации лыжника
    angle = gameRef.groundSlopeAngle();

    // хитбокс добавляем один раз
    add(
      RectangleHitbox.relative(
        Vector2(0.7, 0.7),
        parentSize: size,
        collisionType: CollisionType.active,
      ),
    );
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      jumpVelocity = -500;
      FlameAudio.play('jump.wav');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // если не в прыжке — держим ноги на склоне
    if (!isJumping) {
      position.y = gameRef.groundAt(position.x);
    } else {
      // физика прыжка (Y)
      position.y += jumpVelocity * dt;
      jumpVelocity += 1000 * dt;

      final groundY = gameRef.groundAt(position.x);
      if (position.y >= groundY) {
        position.y = groundY;
        isJumping = false;
        jumpVelocity = 0;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);

    if (other is Coin) {
      gameRef.coins += 1;
      other.removeFromParent();
      FlameAudio.play('coin.wav');
    }

    if (other is Obstacle) {
      gameRef.showGameOver();
    }
  }
}
