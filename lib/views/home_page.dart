import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  child: GridView.builder(
                      itemCount: numberOfSquares,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numberInRow),
                      itemBuilder: (BuildContext context, int index) {
                        if (barriers.contains(index))
                          return Container(
                            color: Colors.blue,
                            child: Text(index.toString()),
                          );
                        else
                          return Container(
                            color: Colors.grey,
                            child: Text(index.toString()),
                          );
                      }),
                )),
            Expanded(
                child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Scores",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    )
                  ]),
            ))
          ],
        ));
  }
}
