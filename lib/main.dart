import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/colors.dart';

import 'game_logic.dart';

void main() {
  runApp(TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastPlayer = "X";
  Game game = Game();
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0]; // 행 3개, 열 3개, 대각선 2개
  int turn = 0;
  bool isGameOver = false;

  @override
  void initState() {
    game.board = Game.initGameBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "It's $lastPlayer turn".toUpperCase(),
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
                width: size.width * 0.9,
                height: size.width * 0.9,
                padding: EdgeInsets.all(size.width * 0.01),
                child: GridView.count(
                  crossAxisCount: Game.boardLength ~/ 3,
                  mainAxisSpacing: size.width * 0.01,
                  crossAxisSpacing: size.width * 0.01,
                  children: List.generate(
                      Game.boardLength,
                      (index) => InkWell(
                            onTap: isGameOver
                                ? null
                                : () {
                                    if (game.board[index] == Player.empty) {
                                      setState(() {
                                        game.board[index] = lastPlayer;
                                        turn++;

                                        isGameOver = game.isGameOver(
                                            lastPlayer, index, scoreboard, 3);
                                        if (isGameOver) {
                                          result = "$lastPlayer is the winner";
                                        } else if (!isGameOver && turn == 9) {
                                          result = "It's a Draw";
                                        }

                                        lastPlayer = lastPlayer == Player.x
                                            ? Player.o
                                            : Player.x;
                                      });
                                    }
                                  },
                            child: Container(
                              width: size.width * 0.28,
                              height: size.width * 0.28,
                              decoration: BoxDecoration(
                                  color: ThemeColor.secondaryColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                  child: Text(
                                game.board[index],
                                style: TextStyle(
                                    color: game.board[index] == "X"
                                        ? Colors.blue
                                        : Colors.pink,
                                    fontSize: 55),
                              )),
                            ),
                          )),
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              result,
              style: TextStyle(color: Colors.white, fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
