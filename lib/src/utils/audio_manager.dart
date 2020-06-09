import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static AudioCache cache = AudioCache(prefix: 'audio/');
  static AudioPlayer player;

  AudioManager() {
    cache.loadAll(["pickup_fruit.mp3", "snake_death.mp3", "snake_music.mp3"]);
  }

  static void playSound(String fileName, double volume) async {
    player = await cache.play(fileName, volume: volume);
  }

  static void playLoop(String fileName, double volume) async {
    player = await cache.loop(fileName, volume: volume);
  }

  static void stopFile() {
    print("GOING TO STOP MUSIC");
    cache.clear("snake_music.mp3");
    print("STOPPED MUSIC");
  }
}

//TODO ADD TO CREDITS: Trevor Lentz for snake_music
