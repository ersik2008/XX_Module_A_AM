import 'package:aXX_am/skier_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Obstacle extends SpriteComponent with HasGameRef<SkierGame>, CollisionCallbacks{
  
  @override
  Future<void> onLoad() async {

  }
}