import 'package:sudoku_api/sudoku_api.dart';

class SudokuBloc {
  static int gridSize = 9;

  void generatePuzzle() {
    PuzzleOptions puzzleOptions = PuzzleOptions(difficulty: 20);

    Puzzle puzzle = Puzzle(puzzleOptions);

    puzzle.generate();
    print(puzzle.board().toMap());
  }
}
