import 'dart:math';

import 'package:flutter/cupertino.dart';

class SnakeGameBloc {
  static int numOfTiles = 405;
  static int tilesPerRow = 15;

  static Random randomPos = Random();
  int foodPos = randomPos.nextInt(numOfTiles);
  void generateFruitPos() {
    foodPos = randomPos.nextInt(numOfTiles);
  }

  // static int snakeStartingPoint =
  //     14 * ((numOfTiles ~/ tilesPerRow) ~/ 2) + (tilesPerRow ~/ 2);

  List<int> snakeCellPos = [197, 198, 199, 200];

  Duration tickSpeed = Duration(milliseconds: 300);

  String snakeDirection = "right";
  void moveSnake() {
    switch (snakeDirection) {
      case "right":
        if ((snakeCellPos.last + 1) % tilesPerRow == 0) {
          snakeCellPos.add(snakeCellPos.last + 1 - tilesPerRow);
        } else {
          snakeCellPos.add(snakeCellPos.last + 1);
        }
        break;
// ----------------------------------------------------------------------------------
      case "up":
        if (snakeCellPos.last < tilesPerRow) {
          snakeCellPos.add(snakeCellPos.last + numOfTiles - tilesPerRow);
        } else {
          snakeCellPos.add(snakeCellPos.last - tilesPerRow);
        }
        break;
// ----------------------------------------------------------------------------------
      case "down":
        if (snakeCellPos.last > (numOfTiles - tilesPerRow)) {
          snakeCellPos.add(snakeCellPos.last + tilesPerRow - numOfTiles);
        } else {
          snakeCellPos.add(snakeCellPos.last + tilesPerRow);
        }
        break;
// ----------------------------------------------------------------------------------
      case "left":
        if (snakeCellPos.last % tilesPerRow == 0) {
          snakeCellPos.add(snakeCellPos.last + tilesPerRow - 1);
        } else {
          snakeCellPos.add(snakeCellPos.last - 1);
        }
        break;
// ----------------------------------------------------------------------------------
      default:
    }

    if (snakeCellPos.last == foodPos) {
      generateFruitPos();
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
        if (snakeCellPos[i] == snakeCellPos[j]) {
          counter += 1;
        }
        if (counter == 2) {
          return true;
        }
      }
    }

    return false;
  }

  void dispose() {}
}
