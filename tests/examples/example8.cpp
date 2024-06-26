#include <cstdlib>
#include <iostream>

/*
 * See SudokuPuzzle.cpp for implementation and detailed API.
 */
class SudokuPuzzle {
private:
  // Represents the boards state. 0 means "no value set yet", and 1-9 are valid
  // values.
  short int board[9][9];

  // Set to true to turn on tracers
  bool debug;

  // Print tracer: print trying value
  void printTracerTryingValue(int x_cord, int y_cord);

  // Recursive method that solves board one block at time
  bool solve(int x_cord, int y_cord);

  // Verifies that set value at certain coordinate is valid
  bool verifyValue(int x_cord, int y_cord);

public:
  // Constructor
  SudokuPuzzle();

  // Print puzzle in current state
  void print();

  // Set a value on the board. Used for laying out board and solving
  void setBoardValue(int x_cord, int y_cord, int value);

  // Get a value on the board.
  int getBoardValue(int x_cord, int y_cord);

  // Solve the puzzle. Returns true if in solved state, returns false if
  // unsolvable.
  bool solve();
};

/*
 * Constructor. Initializes puzzle board to zeros, which signify that a value
 * has not been found yet.
 */
SudokuPuzzle::SudokuPuzzle() {

  // Set to true to turn on tracers
  debug = false;

  // Initialize board
  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 9; x++) {
      board[x][y] = 0;
    }
  }

} // Constructor

/*
 * Print out current state of board. E.g., here's an unsolved puzzle:
 * -------------------------------
 * | 1  .  . | .  .  7 | .  9  . |
 * | .  3  . | .  2  . | .  .  8 |
 * | .  .  9 | 6  .  . | 5  .  . |
 * -------------------------------
 * | .  .  5 | 3  .  . | 9  .  . |
 * | .  1  . | .  8  . | .  .  2 |
 * | 6  .  . | .  .  4 | .  .  . |
 * -------------------------------
 * | 3  .  . | .  .  . | .  1  . |
 * | .  4  . | .  .  . | .  .  7 |
 * | .  .  7 | .  .  . | 3  .  . |
 * -------------------------------
 *
 * And here's the same puzzle, solved:
 * -------------------------------
 * | 1  6  2 | 8  5  7 | 4  9  3 |
 * | 5  3  4 | 1  2  9 | 6  7  8 |
 * | 7  8  9 | 6  4  3 | 5  2  1 |
 * -------------------------------
 * | 4  7  5 | 3  1  2 | 9  8  6 |
 * | 9  1  3 | 5  8  6 | 7  4  2 |
 * | 6  2  8 | 7  9  4 | 1  3  5 |
 * -------------------------------
 * | 3  5  6 | 4  7  8 | 2  1  9 |
 * | 2  4  1 | 9  3  5 | 8  6  7 |
 * | 8  9  7 | 2  6  1 | 3  5  4 |
 * -------------------------------
 */
void SudokuPuzzle::print() {
  // For each row
  for (int y = 0; y < 9; y++) {
    // Draw horizontal lines between blocks
    if (y % 3 == 0) {
      std::cout << "-------------------------------" << std::endl;
    }

    // For each cell in row
    for (int x = 0; x < 9; x++) {
      if (x % 3 == 0) {
        std::cout << "|";
      }

      if (board[x][y] != 0) {
        std::cout << " " << board[x][y] << " ";
      } else {
        std::cout << " . ";
      }
    }

    // Draw columns between blocks
    std::cout << "|" << std::endl;
  }
  std::cout << "-------------------------------" << std::endl;

} // SudokuPuzzle::print()

/*
 * Set a value on the board. This happens under two conditions:
 * i) When caller function is laying out the initial board
 * ii) Found a value we're testing as part of the solution
 *
 * Note that if you set a test value and it doesn't work,
 * you should set value back to zero so that solution algorithm
 * doesn't mistakenly treat wrong value as part of board.
 *
 * Parameters:
 *   x_cord: The x-coordinate on the board. Should be between 0
 *           and 8, inclusive
 *   y_cord: The y-coordinate on the board. Should be between 0
 *           and 8, inclusive.
 *   value:  The value to try, or (when creating board) the initial
 *           value of the board
 */
void SudokuPuzzle::setBoardValue(int x_cord, int y_cord, int value) {
  board[x_cord][y_cord] = value;
} // SudokuPuzzle::setBoardValue(int, int, int)

/*
 * Solve the Sudoku puzzle. Uses whatever state the current board
 * is in to solve.
 *
 * Return:
 *   True if solved, false if unsolvable. If solved, the puzzle's
 *   current state is solved. You can print the puzzle to see
 *   the solution.
 */
bool SudokuPuzzle::solve() { return solve(0, 0); } // SudokuPuzzle::solve()

int SudokuPuzzle::getBoardValue(int x_cord, int y_cord) {
  return board[x_cord][y_cord];
} // SudokuPuzzle::getBoardValue(int, int)

/*
 * Internal method that recursively solves the puzzle.
 *
 * Parameters:
 *   x_cord: The x-coordinate on the board. Should be between 0
 *           and 8, inclusive
 *   y_cord: The y-coordinate on the board. Should be between 0
 *           and 8, inclusive.
 *
 * Return:
 *   True if solved, false if unsolvable. If solved, the puzzle's
 *   current state is solved. You can print the puzzle to see
 *   the solution.
 */
bool SudokuPuzzle::solve(int x_cord, int y_cord) {

  // Only solve piece if not already solved (given)
  if (board[x_cord][y_cord] != 0) {

    // If value works, on to next
    if (verifyValue(x_cord, y_cord)) {

      // If last piece, puzzle solved!
      if (x_cord == 8 && y_cord == 8) {
        return true;
      }

      // Find next slot on this row
      int next_x = x_cord + 1;
      int next_y = y_cord;

      // If at end of row, start next
      if (next_x >= 9) {
        next_x = 0;
        next_y++;
      }

      // Move on to next piece
      return solve(next_x, next_y);
    }

    // Value doesn't work. Early guess is bad
    else {
      return false;
    }

  } // If value already defined

  // There isn't a value already for position.
  // Guess all the values until one works
  for (int val = 1; val < 10; val++) {

    setBoardValue(x_cord, y_cord, val);

    // If value works, on to next
    if (verifyValue(x_cord, y_cord)) {

      // If last piece, puzzle solved!
      if (x_cord == 8 && y_cord == 8) {
        return true;
      }

      // Find next slot on this row
      int next_x = x_cord + 1;
      int next_y = y_cord;

      // If at end of row, start next
      if (next_x >= 9) {
        next_x = 0;
        next_y++;
      }

      // Move on to next piece
      // return solve(next_x, next_y);
      if (solve(next_x, next_y)) {
        return true;
      }
    }
  }

  // Remove value. Going to backtrack. If value remained,
  // then would think its part of solution.
  board[x_cord][y_cord] = 0;

  // If gets here, must backtrack. No solution
  // for path.
  return false;

} // SudokuPuzzle::solve(int, int)

/*
 * Verifies that a value set at a particular location follows
 * all the Sudoku rules.
 *
 * Parameters:
 *   x_cord: The x-coordinate on the board. Should be between 0
 *           and 8, inclusive
 *   y_cord: The y-coordinate on the board. Should be between 0
 *           and 8, inclusive.
 *
 * Return:
 *   True if valid (follows all the rules), false otherwise.
 */
bool SudokuPuzzle::verifyValue(int x_cord, int y_cord) {

  printTracerTryingValue(x_cord, y_cord);

  int value = board[x_cord][y_cord];

  // Make sure no vertical collision
  for (int x_verify = 0; x_verify < 9; x_verify++) {
    // Skip self.
    if (x_verify == x_cord) {
      continue;
    }

    // If same value, failed
    int verifyValue = board[x_verify][y_cord];
    if (verifyValue == value) {
      return false;
    }
  }

  // Make sure no horizontal collision
  for (int y_verify = 0; y_verify < 9; y_verify++) {
    // Skip self.
    if (y_verify == y_cord) {
      continue;
    }

    // If same value, failed
    int verifyValue = board[x_cord][y_verify];
    if (verifyValue == value) {
      return false;
    }
  }

  // Make sure no collision in box
  int box_x = x_cord / 3; // If this box 0, 1, 2 on x-cord
  int box_y = y_cord / 3; // Is this box 0, 1, 2 on y-cord

  // For each y in the same box
  for (int y_verify = box_y * 3; y_verify < box_y * 3 + 3; y_verify++) {
    // For each x in the same box
    for (int x_verify = box_x * 3; x_verify < box_x * 3 + 3; x_verify++) {
      // Skip self.
      if (x_verify == x_cord && y_verify == y_cord) {
        continue;
      }

      // If same value, failed
      int verifyValue = board[x_verify][y_verify];
      if (verifyValue == value) {
        return false;
      }
    }
  }

  // Passed all of the tests, so valid
  return true;

} // SudokuPuzzle::verifyValue(int, int)

/*
 * Prints tracers for every attempt while recursively solving the
 * puzzle on if debug is set to true in the constructor.
 *
 * Parameters:
 *   x_cord: The x-coordinate on the board. Should be between 0
 *           and 8, inclusive
 *   y_cord: The y-coordinate on the board. Should be between 0
 *           and 8, inclusive.
 */
void SudokuPuzzle::printTracerTryingValue(int x_cord, int y_cord) {
  if (debug) {
    // Indent for easier reading
    for (int i = 0; i < x_cord + y_cord; i++) {
      std::cout << " ";
    }

    std::cout << "Trying value " << board[x_cord][y_cord] << " at board["
              << x_cord << "][" << y_cord << "]" << std::endl;
  }

} // SudokuPuzzle::printTracerTryingValue

/*
 * Create and solve a Sudoku puzzle. Will print
 * the board, then try to solve. If solves, will
 * print the solution. If unsolvable, will display
 * message.
 */
int main(int argc, char* const argv[]) {

  SudokuPuzzle puzzle;

  /*
   * Create board below. For each initial
   * value on the board, specify using:
   *
   * puzzle.setBoardValue(int x-cord, y-cord, val);
   *
   * Where:
   *   x-cord: X coordinate on the Sudoku field.
   *   y-cord: Y coordinate on the Sudoku field.
   *   val:    The value to place on the board.
   *
   * Use the following to determine x- and y-
   * coordinates:
   *
   *       X
   *        0  1  2   3  4  5   6  7  8
   *      -------------------------------
   * Y 0  | .  .  . | .  .  . | .  .  . |
   *   1  | .  .  . | .  .  . | .  .  . |
   *   2  | .  .  . | .  .  . | .  .  . |
   *      -------------------------------
   *   3  | .  .  . | .  .  . | .  .  . |
   *   4  | .  .  . | .  .  . | .  .  . |
   *   5  | .  .  . | .  .  . | .  .  . |
   *      -------------------------------
   *   6  | .  .  . | .  .  . | .  .  . |
   *   7  | .  .  . | .  .  . | .  .  . |
   *   8  | .  .  . | .  .  . | .  .  . |
   *      -------------------------------
   *
   */
  //	for(int x = 0;x<9;x++){
  //		for(int y = 0;y<9;y++){
  //			bool decide = (std::rand())%2;
  //                        if(decide)continue;
  //
  //                        int value = (std::rand())%9 + 1;
  //                        puzzle.setBoardValue(x,y,value);
  //		}
  //	}
  // Set known values on board block 1
  puzzle.setBoardValue(0, 0, 1);
  puzzle.setBoardValue(1, 1, 3);
  puzzle.setBoardValue(2, 2, 9);

  // Set known values on board block 2
  puzzle.setBoardValue(3, 2, 6);
  puzzle.setBoardValue(4, 1, 2);
  puzzle.setBoardValue(5, 0, 7);

  // Set known values on board block 3
  puzzle.setBoardValue(6, 2, 5);
  puzzle.setBoardValue(7, 0, 9);
  puzzle.setBoardValue(8, 1, 8);

  // Set known values on board block 4
  puzzle.setBoardValue(0, 5, 6);
  puzzle.setBoardValue(1, 4, 1);
  puzzle.setBoardValue(2, 3, 5);

  // Set known values on board block 5
  puzzle.setBoardValue(3, 3, 3);
  puzzle.setBoardValue(4, 4, 8);
  puzzle.setBoardValue(5, 5, 4);

  // Set known values on board block 6
  puzzle.setBoardValue(6, 3, 9);
  puzzle.setBoardValue(8, 4, 2);

  // Set known values on board block 7
  puzzle.setBoardValue(0, 6, 3);
  puzzle.setBoardValue(1, 7, 4);
  puzzle.setBoardValue(2, 8, 7);

  // Board block 8 is empty

  // Set known values on board block 9
  puzzle.setBoardValue(6, 8, 3);
  puzzle.setBoardValue(7, 6, 1);
  puzzle.setBoardValue(8, 7, 7);

  // Print the board before solving.
  puzzle.print();

  std::cout << std::endl;

  // Now solve. If not solvable, say.
  if (puzzle.solve()) {

    std::cout << "Here is the solution:" << std::endl;
    puzzle.print();

  } else {
    std::cout << "Puzzle is not solvable.";
  }

  std::cout << std::endl;

  // Exit normally
  return 0;

} // main
