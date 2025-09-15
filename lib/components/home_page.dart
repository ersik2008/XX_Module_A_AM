import 'package:flutter/material.dart';
import '../skier_game.dart';

class HomePageOverlay extends StatefulWidget {
  final SkierGame game;
  const HomePageOverlay({super.key, required this.game});

  @override
  State<HomePageOverlay> createState() => _HomePageOverlayState();
}

class _HomePageOverlayState extends State<HomePageOverlay> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material( // ✅ фикс для TextField
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Go Skiing",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Player name",
                      border: OutlineInputBorder(),
                      filled: true, // ✅ фон для читаемости
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    widget.game.playerName =
                        _controller.text.isEmpty ? "Guest" : _controller.text;
                    widget.game.overlays.remove('HomePage');
                    widget.game.resumeEngine(); // запускаем игру
                  },
                  child: const Text("Start Game"),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    // TODO: Rankings
                  },
                  child: const Text("Rankings"),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    // TODO: Settings
                  },
                  child: const Text("Settings"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
