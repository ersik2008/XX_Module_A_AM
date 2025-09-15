import 'package:flutter/material.dart';
import '../skier_game.dart';

class PauseOverlay extends StatelessWidget {
  final SkierGame game;
  const PauseOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54, // затемнение
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Paused', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // снять паузу
                game.overlays.remove('PauseOverlay');
                game.resumeEngine();
                game.isPausedByButton = false;

                // восстановить иконку Pause: найди PauseButton в children и вызови метод
                final btn = game.children.whereType<dynamic>().firstWhere(
                  (c) => c.runtimeType.toString() == 'PauseButton',
                  orElse: () => null,
                );
                if (btn != null && (btn as dynamic).setPauseIcon != null) {
                  try {
                    (btn as dynamic).setPauseIcon();
                  } catch (_) {}
                }
              },
              child: const Text('Resume'),
            ),
          ],
        ),
      ),
    );
  }
}
