import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts
import 'tile.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  int _blackScore = 0;
  int _whiteScore = 0;
  int _drawScore = 0;

  void _resetBoard() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
    });
  }

  void _resetScores() {
    setState(() {
      _blackScore = 0;
      _whiteScore = 0;
      _drawScore = 0;
      _resetBoard();
    });
  }

  void _onTileTap(int index) {
    if (_board[index] == '') {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWin(_currentPlayer)) {
          if (_currentPlayer == 'X') {
            _blackScore++;
          } else {
            _whiteScore++;
          }
          _showWinDialog(_currentPlayer);
        } else if (!_board.contains('')) {
          _drawScore++;
          _showDrawDialog();
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWin(String player) {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == player &&
          _board[pattern[1]] == player &&
          _board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'GAME OVER',
          style: GoogleFonts.pressStart2p(),  // Apply the Google Font
        ),
        content: Text(
          '${winner == 'X' ? 'BLUE' : 'RED'} WINS!',
          style: GoogleFonts.pressStart2p(),  // Apply the Google Font
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetBoard();
            },
            child: Text(
              'PLAY AGAIN',
              style: GoogleFonts.pressStart2p(),  // Apply the Google Font
            ),
          ),
        ],
      ),
    );
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'GAME OVER',
          style: GoogleFonts.pressStart2p(),  // Apply the Google Font
        ),
        content: Text(
          'IT\'S A DRAW!',
          style: GoogleFonts.pressStart2p(),  // Apply the Google Font
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetBoard();
            },
            child: Text(
              'PLAY AGAIN',
              style: GoogleFonts.pressStart2p(),  // Apply the Google Font
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TIC-TAC-TOE',
          style: GoogleFonts.pressStart2p(),
          // Apply the Google Font
        ),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.grey,  // Set the background color to green
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, 50), // Adjust the Y-offset to move the box down
            child: Center(
              child: Container(
                width: 470,  // Increased size for a larger board
                height: 470,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) => Tile(
                    index: index,
                    value: _board[index],
                    onTap: _onTileTap,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  'BLUE: $_blackScore - RED: $_whiteScore',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'DRAWS: $_drawScore',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _resetScores,
                  child: Text(
                    'RESET SCORES',
                    style: GoogleFonts.pressStart2p(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
