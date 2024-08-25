import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int index;
  final String value;
  final void Function(int) onTap;

  const Tile({
    required this.index,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: (index < 3) ? BorderSide.none : BorderSide(color: Colors.black, width: 2), // No top border for the first row
            bottom: (index >= 6) ? BorderSide.none : BorderSide(color: Colors.black, width: 2), // No bottom border for the last row
            left: (index % 3 == 0) ? BorderSide.none : BorderSide(color: Colors.black, width: 2), // No left border for the first column
            right: ((index + 1) % 3 == 0) ? BorderSide.none : BorderSide(color: Colors.black, width: 2), // No right border for the last column
          ),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: value == 'X' ? Colors.black : Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 15.0,
                  color: value == 'X' ? Colors.blue : Colors.red,
                  offset: Offset(0, 0),
                ),
                Shadow(
                  blurRadius: 15.0,
                  color: value == 'X' ? Colors.blue : Colors.red,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
