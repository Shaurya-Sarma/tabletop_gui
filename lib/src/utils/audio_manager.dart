import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static AudioCache cache = AudioCache(prefix: 'audio/');
  static AudioPlayer player;

  AudioManager() {
    cache.loadAll([
      "pickup_fruit.mp3",
      "snake_death.mp3",
      "snake_music.mp3",
      "fifteen_tile_slide.mp3"
    ]);
  }

  static void playSound(String fileName, double volume) async {
    player = await cache.play(fileName, volume: volume);
  }

  static void playLoop(String fileName, double volume) async {
    player = await cache.loop(fileName, volume: volume);
    print("local $player");
  }

  static void stopFile() async {
    print(player);
    print(await player.stop());
    await player.stop();
    print("STOPPED MUSIC");
  }
}

//TODO ADD TO CREDITS: Trevor Lentz for snake_music, Little Robot
