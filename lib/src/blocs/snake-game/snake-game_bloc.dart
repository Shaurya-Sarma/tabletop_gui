import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tabletop_gui/src/utils/audio_manager.dart';

class SnakeGameBloc {
  static int numOfTiles = 405;
  static int tilesPerRow = 15;

  static Random randomPos = Random();

  int foodPos = randomPos.nextInt(numOfTiles - tilesPerRow);
  void generateFruitPos() {
    foodPos = randomPos.nextInt(numOfTiles - tilesPerRow);
  }

  int spikePos;
  void generateSpikePos() {
    if (randomPos.nextInt(5) == 0 && snakeCellPos.length > 6) {
      spikePos = randomPos.nextInt(numOfTiles - tilesPerRow);
    } else {
      spikePos = null;
    }
  }

  List<List<dynamic>> snakeCellPos = [
    [197, 'right'],
    [198, 'right'],
    [199, 'right'],
    [200, 'right']
  ];

  Duration tickSpeed = Duration(milliseconds: 300);

  String snakeDirection = "right";
  void moveSnake() {
    switch (snakeDirection) {
      case "right":
        if ((snakeCellPos.last[0] + 1) % tilesPerRow == 0) {
          snakeCellPos.add([snakeCellPos.last[0] + 1 - tilesPerRow, 'right']);
        } else {
          snakeCellPos.add([snakeCellPos.last[0] + 1, 'right']);
        }
        break;
// ----------------------------------------------------------------------------------
      case "up":
        if (snakeCellPos.last[0] < tilesPerRow) {
          snakeCellPos
              .add([snakeCellPos.last[0] + numOfTiles - tilesPerRow, "up"]);
        } else {
          snakeCellPos.add([snakeCellPos.last[0] - tilesPerRow, "up"]);
        }
        break;
// ----------------------------------------------------------------------------------
      case "down":
        if (snakeCellPos.last[0] > (numOfTiles - tilesPerRow)) {
          snakeCellPos
              .add([snakeCellPos.last[0] + tilesPerRow - numOfTiles, "down"]);
        } else {
          snakeCellPos.add([snakeCellPos.last[0] + tilesPerRow, "down"]);
        }
        break;
// ----------------------------------------------------------------------------------
      case "left":
        if (snakeCellPos.last[0] % tilesPerRow == 0) {
          snakeCellPos.add([snakeCellPos.last[0] + tilesPerRow - 1, "left"]);
        } else {
          snakeCellPos.add([snakeCellPos.last[0] - 1, "left"]);
        }
        break;
// ----------------------------------------------------------------------------------
      default:
    }

    if (snakeCellPos.last[0] == foodPos) {
      generateFruitPos();
      generateSpikePos();
      AudioManager.playSound("pickup_fruit.mp3", 1.2);
    } else {
      snakeCellPos.removeAt(0);
    }
  }

  void switchSnakeVerticalDirection(DragUpdateDetails value) {
    if (snakeDirection != "down" && value.delta.dy < 0) {
      snakeDirection = "up";
    } else if (snakeDirection != "up" && value.delta.dy > 0) {
      snakeDirection = "down";
    }
  }

  void switchSnakeHorizontalDirection(DragUpdateDetails value) {
    if (snakeDirection != "left" && value.delta.dx > 0) {
      snakeDirection = "right";
    } else if (snakeDirection != "right" && value.delta.dx < 0) {
      snakeDirection = "left";
    }
  }

  bool isGameOver() {
    for (int i = 0; i < snakeCellPos.length; i++) {
      int counter = 0;
      for (int j = 0; j < snakeCellPos.length; j++) {
        if (snakeCellPos[i][0] == snakeCellPos[j][0]) {
          counter += 1;
        }
        if (counter == 2) {
          AudioManager.playSound("snake_death.mp3", 1.3);
          return true;
        }
      }
    }

    if (snakeCellPos.last[0] == spikePos) {
      AudioManager.playSound("snake_death.mp3", 1.3);
      return true;
    }

    return false;
  }
}
