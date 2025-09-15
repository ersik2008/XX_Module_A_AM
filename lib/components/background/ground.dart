import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Ground extends PolygonComponent {
  Ground(Vector2 gameSize)
      : super(
          [
            // Левый верх (начало пола, повыше)
            Vector2(0, gameSize.y * 0.9),

            // Правый верх (ниже, делаем уклон вправо)
            Vector2(gameSize.x, gameSize.y * 0.97),

            // Правый низ (замыкание внизу экрана)
            Vector2(gameSize.x, gameSize.y),

            // Левый низ (замыкание внизу экрана)
            Vector2(0, gameSize.y),
          ],
          paint: Paint()..color = const Color(0xFFFFFFFF),
        );
}
