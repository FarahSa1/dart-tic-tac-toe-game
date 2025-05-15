import 'dart:io';

List<String> board = List.filled(9, ' ');
String currentPlayer = 'X';

void main() {
  while (true) {
    printBoard(); // Display the board at the beginning of each turn.
    playerMove(); // Prompt the current player to make a move.
    // Check if the current player has won.
    if (checkWin()) {
      printBoard();
      print('Player $currentPlayer wins!');
      if (askToRestart())  // Ask if the players want to restart the game.
        resetGame();
      else 
        break;      
    }
    // Check if the board is full
    if (isBoardFull()) {
      printBoard();
      print('It\'s a draw!');
      if (askToRestart()) 
        resetGame();
      else 
        break;      
    }
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X'; // Switch to the next player.
  }
}


// This function prints the current state of the board.
void printBoard() {
  print('''
  ${board[0]} | ${board[1]} | ${board[2]}
 ---+---+---
  ${board[3]} | ${board[4]} | ${board[5]}
 ---+---+---
  ${board[6]} | ${board[7]} | ${board[8]}
  ''');
}


// This function asks the current player to make a move and updates the board.
void playerMove() {
  while (true) {
    stdout.write('Player $currentPlayer, choose (1-9): ');
    String? input = stdin.readLineSync();
    int? move = int.tryParse(input ?? '');

    if (move != null && move >= 1 && move <= 9 && board[move - 1] == ' ') {
      board[move - 1] = currentPlayer;
      break;
    } else {
      print('Invalid move. Try again.');
    }
  }
}


// This function checks if the current player has won the game.
bool checkWin() {
  List<List<int>> wins = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
    [0, 4, 8], [2, 4, 6]             // diagonals
  ];
  
  // Iterate through each winning combination.
  for (var line in wins) {
    // Check if the current player occupies all 3 positions in the winning line.
    if (board[line[0]] == currentPlayer &&
        board[line[1]] == currentPlayer &&
        board[line[2]] == currentPlayer) {
      return true;
    }
  }
  return false;
}


// This function checks if the board is full
bool isBoardFull() {
  return board.every((cell) => cell != ' ');
}

// This function asks the players if they want to restart the game.
bool askToRestart() {
  stdout.write('Do you want to restart the game? (y/n): ');
  String? restart = stdin.readLineSync();
  if (restart?.toLowerCase() == 'y') {
    return true;
  } else {
    print('Thanks for playing!');
    return false;
  }
}

// This function resets the game board and sets the current player back to 'X'.
void resetGame() {
  board = List.filled(9, ' ');  
  currentPlayer = 'X';  
}