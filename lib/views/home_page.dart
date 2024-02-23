import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pacman_game/widgets/ghost.dart';
import 'package:flutter_pacman_game/widgets/ghost2.dart';
import 'package:flutter_pacman_game/widgets/path.dart';
import 'package:flutter_pacman_game/widgets/pixel.dart';
import 'package:flutter_pacman_game/widgets/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getFood();

    super.initState();
  }

  static int numberInRow = 11;
  int player = numberInRow * 15 + 1;
  int ghost = numberInRow * 2 - 2;
  int ghost2p = numberInRow * 2 - 10;
  bool preGame = true;
  bool mouthClosed = false;
  int score = 0;
  static int numberOfSquares = numberInRow * 17;
  static List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    24,
    35,
    46,
    57,
    26,
    37,
    38,
    39,
    28,
    30,
    41,
    52,
    63,
    123,
    134,
    145,
    156,
    158,
    147,
    148,
    149,
    160,
    129,
    140,
    151,
    162,
    78,
    79,
    80,
    70,
    59,
    61,
    72,
    83,
    81,
    84,
    85,
    86,
    100,
    101,
    102,
    103,
    114,
    125,
    127,
    116,
    105,
    106,
    107,
    108
  ];
  List<int> food = [];
  String direction = 'right';
  String ghostDirection = 'left';
  void startGame() {
    preGame = false;

    // getFood();
    print(food);
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      print('check');
      setState(() {
        mouthClosed = !mouthClosed;
      });
      if (food.contains(player)) {
        print('l');
        food.remove(player);
        score++;
      }
      if (!barriers.contains(ghost - 1)) {
        setState(() {
          ghost--;
        });
      }
      if (player == ghost) {
        player = -1;
      }
      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      moveGhost();
    });
  }

  void moveGhost() {
    // Move the ghost in the current direction
    print('Ghost Direction' + ghostDirection.toString());
    switch (ghostDirection) {
      case 'left':
        if (!barriers.contains(ghost - 1)) {
          setState(() {
            print('check1');
            ghost--;
            //    ghost2p--;
          });
        } else {
          // If a barrier is encountered, change direction randomly
          changeGhostDirection();
        }
        break;
      case 'right':
        if (!barriers.contains(ghost + 1)) {
          print('right direction ser0' + ghost.toString());
          setState(() {
            ghost++;
            //    ghost2p++;
          });
        } else {
          changeGhostDirection();
        }
        break;
      case 'up':
        if (!barriers.contains(ghost - numberInRow)) {
          setState(() {
            ghost -= numberInRow;
            //  ghost2p -= numberInRow;
          });
        } else {
          changeGhostDirection();
        }
        break;
      case 'down':
        if (!barriers.contains(ghost + numberInRow)) {
          setState(() {
            ghost += numberInRow;
            // ghost2p += numberInRow;
          });
        } else {
          changeGhostDirection();
        }
        break;
    }
  }

  void changeGhostDirection() {
    print('change');
    // Randomly choose a new direction for the ghost
    Random random = Random();
    int randomDirection = random.nextInt(4);
    print('number' + randomDirection.toString());
    switch (randomDirection) {
      case 0:
        ghostDirection = 'left';
        break;
      case 1:
        ghostDirection = 'up';
        break;
      case 2:
        ghostDirection = 'right';
        break;
      case 3:
        ghostDirection = 'down';
        break;
    }
  }

  void getFood() {
    print('KK');
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
        print('kf');
      }
    }
  }

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
        print(player);
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 0) {
                        direction = 'down';
                        print(direction);
                      } else if (details.delta.dy < 0) {
                        direction = 'up';
                        print(direction);
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 0) {
                        direction = 'right';
                        print(direction);
                      } else if (details.delta.dx < 0) {
                        direction = 'left';
                        print(direction);
                      }
                    },
                    child: GridView.builder(
                        itemCount: numberOfSquares,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: numberInRow),
                        itemBuilder: (BuildContext context, int index) {
                          if (mouthClosed && player == index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                            );
                          }
                          if (ghost == index) {
                            return MyGhost();
                          } else if (player == index) {
                            switch (direction) {
                              case "left":
                                return Transform.rotate(
                                    angle: pi, child: MyPlayer());
                                break;
                              case "right":
                                return MyPlayer();
                                break;
                              case "up":
                                return Transform.rotate(
                                    angle: 3 + pi / 2, child: MyPlayer());
                                break;
                              case "down":
                                return Transform.rotate(
                                    angle: pi / 2, child: MyPlayer());
                                break;
                              default:
                                MyPlayer();
                            }
                          } else if (barriers.contains(index))
                            return MyPixel(
                              child: Text(''),
                              innerColor: Colors.blue[800],
                              outerColor: Colors.blue[900],
                            );
                          else if (food.contains(index) || preGame) {
                            return MyPath(
                              innerColor: Colors.yellow,
                              outerColor: Colors.black,
                            );
                          } else
                            return MyPath(
                              child: Text(''),
                              innerColor: Colors.grey[800],
                            );
                        }),
                  ),
                )),
            Expanded(
                child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Scores $score",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    GestureDetector(
                      onTap: () => startGame(),
                      child: Text(
                        "P L A Y",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    )
                  ]),
            ))
          ],
        ));
  }
}
