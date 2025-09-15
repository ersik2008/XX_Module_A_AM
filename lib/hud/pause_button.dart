import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import '../skier_game.dart';

class PauseButton extends PositionComponent with TapCallbacks, HasGameRef<SkierGame> {
  late Sprite pauseSprite;
  late Sprite playSprite;
  late SpriteComponent icon;
  bool isPausedLocal = false;

  @override
  bool get ignorePause => true;

  @override
  Future<void> onLoad() async {
    size = Vector2(100, 100);

    pauseSprite = await gameRef.loadSprite('icons/pause.png'); // path inside assets/images/
    playSprite = await gameRef.loadSprite('icons/play.png');

    icon = SpriteComponent(sprite: pauseSprite, size: Vector2(60, 60), anchor: Anchor.center, position: size / 2);
    add(icon);

    // хитбокс больше, чтобы легче нажималось
    final box = RectangleHitbox()..collisionType = CollisionType.passive; // passive достаточно для тапов
    box.size = size;
    add(box);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // блокируем проброс, чтобы onTap в игре не срабатывал
    event.handled = true;

    // переключаем паузу
    if (!isPausedLocal) {
      gameRef.isPausedByButton = true;
      gameRef.pauseEngine();
      gameRef.overlays.add('PauseOverlay');
      icon.sprite = playSprite;
    } else {
      // лучше снимать паузу из overlay Resume (чтобы синхронизовано)
      // но если пользователь тапнул по кнопке — тоже можем снять
      gameRef.overlays.remove('PauseOverlay');
      gameRef.resumeEngine();
      gameRef.isPausedByButton = false;
      icon.sprite = pauseSprite;
    }
    isPausedLocal = !isPausedLocal;
  }

  // метод для внешнего восстановления иконки (вызывается из PauseOverlay при Resume)
  void setPauseIcon() {
    isPausedLocal = false;
    icon.sprite = pauseSprite;
  }
}
