import 'package:aXX_am/components/home_page.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import 'skier_game.dart';
import 'hud/game_over.dart';
import 'hud/pause_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  final game = SkierGame();

  await FlameAudio.audioCache.loadAll([
    'coin.wav',
    'jump.wav',
    'game_over.wav',
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: game,
        overlayBuilderMap: {
          'HomePage': (context, game) =>
              HomePageOverlay(game: game as SkierGame),
          'GameOverMenu': (context, game) =>
              GameOverMenu(game: game as SkierGame),
          'PauseOverlay': (context, game) =>
              PauseOverlay(game: game as SkierGame),
        },
        initialActiveOverlays: const ['HomePage'],
      ),
    ),
  );
}
