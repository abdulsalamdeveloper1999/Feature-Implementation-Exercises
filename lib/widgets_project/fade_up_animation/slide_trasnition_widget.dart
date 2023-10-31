import 'package:flutter/material.dart';

class TransitionWidget extends StatelessWidget {
  const TransitionWidget({
    super.key,
    required this.animationController,
    required this.child,
  });

  final AnimationController animationController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1.0), // Start from the bottom
        end: const Offset(0, 0), // End at the top
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.1 * 1, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: child,
    );
  }
}
