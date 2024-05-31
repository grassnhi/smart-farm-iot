import 'package:flutter/material.dart';

class AnimatedSwitch extends StatelessWidget {
  final bool isPumpIn;
  final void Function(bool) onTap;

  const AnimatedSwitch({
    Key? key,
    required this.isPumpIn,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(!isPumpIn); // Toggle the pump state
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Text(
              isPumpIn ? 'PUMP IN' : 'PUMP OUT',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 28,
              width: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Stack(
                children: [
                  AnimatedCrossFade(
                    firstChild: Container(
                      height: 30,
                      width: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.transparent,
                      ),
                    ),
                    secondChild: Container(
                      height: 30,
                      width: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    crossFadeState: isPumpIn
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 200),
                  ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment: isPumpIn
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      height: 42 * 0.5,
                      width: 42 * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPumpIn
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}