import 'dart:math';
import 'package:aXX_am/hud/game_hud.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'components/background/background.dart';
import 'components/background/tree.dart';
import 'components/background/ground.dart';
import 'components/player.dart';
import 'components/obstacle.dart';
import 'components/coin.dart';

class SkierGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Player player;
  GameHud? hud;

  int coins = 0;
  int duration = 0;
  String playerName = "Guest";
  bool isGameOver = false;
  bool isPausedByButton = false;

  double spawnTimerObstacle = 0;
  double spawnTimerCoin = 0;
  double timeAccumulator = 0;

  final Random random = Random();

  final double _yLeftFactor = 0.9;
  final double _yRightFactor = 0.97;

  double groundAt(double x) {
    final y1 = size.y * _yLeftFactor;
    final y2 = size.y * _yRightFactor;
    final double clampedX = x.clamp(0.0, size.x).toDouble();
    return y1 + (y2 - y1) * (clampedX / size.x);
  }

  double groundSlopeAngle() {
    final y1 = size.y * _yLeftFactor;
    final y2 = size.y * _yRightFactor;
    return atan2(y2 - y1, size.x);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    pauseEngine();

    await _addWorld();
  }

  Future<void> _addWorld() async {
    await add(Background()..priority = -2);
    await add(Tree()..priority = -1);
    await add(Ground(size)..priority = 0);

    player = Player()..priority = 1;
    await add(player);

    hud = GameHud()..priority = 10;
    await add(hud!);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPausedByButton) return;

    if (!isGameOver) {
      timeAccumulator += dt;
      if (timeAccumulator >= 1.0) {
        duration += 1;
        timeAccumulator = 0;
      }

      spawnTimerObstacle += dt;
      if (spawnTimerObstacle > 2.0) {
        spawnTimerObstacle = 0;
        final spawnX = size.x + 100;
        final spawnY = groundAt(spawnX);
        add(Obstacle(Vector2(spawnX, spawnY))..priority = 1);
      }

      spawnTimerCoin += dt;
      if (spawnTimerCoin > 3.0) {
        spawnTimerCoin = 0;
        final spawnX = size.x + 120;
        final spawnY = groundAt(spawnX);
        add(Coin(Vector2(spawnX, spawnY))..priority = 1);
      }
    }
  }

  @override
  void onTap() {
    if (!isPausedByButton && !isGameOver) {
      player.jump();
    }
  }

  void showGameOver() {
    if (isGameOver) return;
    isGameOver = true;
    pauseEngine();

    hud?.removeFromParent();

    overlays.add('GameOverMenu');
    // остановка всех звуков
    FlameAudio.bgm.stop();
    FlameAudio.play('game_over.wav')
        .catchError((e) => debugPrint('audio error: $e'));
  }

  Future<void> resetGame() async {
    // удаляем только игровые объекты, не сам движок
    children.where((c) => c != player).toList().forEach((c) => c.removeFromParent());
    player.removeFromParent();

    coins = 0;
    duration = 0;
    timeAccumulator = 0;
    spawnTimerObstacle = 0;
    spawnTimerCoin = 0;
    isGameOver = false;
    isPausedByButton = false;

    await _addWorld();

    resumeEngine();
  }
}
