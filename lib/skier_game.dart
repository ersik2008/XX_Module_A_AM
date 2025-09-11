import 'package:aXX_am/components/background.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class SkierGame extends FlameGame with HasCollisionDetection, TapDetector {
  double spawnTimerObstacle = 0;
  double spawnTimerCoin = 0;

  int coins = 0;
  int duration = 0;

  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    add(Background());
  }
}
