import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;
  // final dayMonth;

  const ChartBar({
    super.key,
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 10,
              height: 150,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FittedBox(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
