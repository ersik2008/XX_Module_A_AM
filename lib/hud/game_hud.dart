import 'package:aXX_am/hud/pause_button.dart';
import 'package:aXX_am/skier_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameHud extends Component with HasGameRef<SkierGame> {
  late TextComponent playerNameText;
  late PositionComponent coinsGroup;
  late SpriteComponent coinIcon;
  late TextComponent coinsText;
  late TextComponent durationText;
  late PauseButton pauseButton;

  @override
  bool get ignorePause => true;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Кнопка паузы
    pauseButton = PauseButton()
      ..position = Vector2(20, 20)
      ..anchor = Anchor.topLeft;
    add(pauseButton);

    final double rightMargin = 10;

    // Имя игрока
    playerNameText = TextComponent(
      text: gameRef.playerName, // <-- берём из gameRef
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      anchor: Anchor.topRight,
      position: Vector2(gameRef.size.x - rightMargin, 20),
    );
    add(playerNameText);

    // Таймер
    durationText = TextComponent(
      text: '0 s',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      anchor: Anchor.topRight,
      position: Vector2(gameRef.size.x - 20, 90),
    );
    add(durationText);

    // Монеты
    coinsGroup = PositionComponent(
      anchor: Anchor.topRight,
      position: Vector2(gameRef.size.x - 85, 70),
    );

    coinIcon = SpriteComponent(
      sprite: await gameRef.loadSprite('coin.png'),
      size: Vector2(36, 36),
      anchor: Anchor.centerLeft,
      position: Vector2(0, 0),
    );

    coinsText = TextComponent(
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black45,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
      anchor: Anchor.centerLeft,
      position: Vector2(50, 0),
    );

    coinsGroup.add(coinIcon);
    coinsGroup.add(coinsText);
    add(coinsGroup);
  }

  @override
  void update(double dt) {
    super.update(dt);

    coinsText.text = '${gameRef.coins}';
    durationText.text = '${gameRef.duration} s';
    playerNameText.text = gameRef.playerName; // <-- обновляем
  }
}


