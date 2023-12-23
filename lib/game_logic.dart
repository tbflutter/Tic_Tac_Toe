class Game {
  static final boardLength = 9;
  late List<String> board;

  static List<String> initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);

  void play(String player, int index, List<int> scoreboard, int gridSize){
    int row = index ~/ gridSize;
    int col = index % gridSize;
    int score = player == "X" ? 1 : -1;
    // (row, col)

    // 0, 1, 2
    // 0, 1, 2
    // 0 ~ 7 -> 0 ~ 2: row의 점수, 3 ~ 5 : col의 점수, 6 ~ 7: 대각선 점수
    scoreboard[row] += score; // 행
    scoreboard[col + gridSize] += score; // 열

    if(row == col){ // 왼쪽에서 오른쪽으로 내려가는 대각선
      scoreboard[gridSize * 2] += score;
    }

    if(col + row == 2){ // 오른쪽에서 왼쪽으로 내려가는 대각선
      scoreboard[gridSize * 2 + 1] += score;
    }
  }

  bool isGameOver(String player, int index, List<int> scoreboard, int gridSize){
    play(player, index, scoreboard, gridSize);

    if(scoreboard.contains(3) || scoreboard.contains(-3)){
      return true;
    }
    return false;
  }
}

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}
