import 'package:flutter/material.dart';

class AlertDialogComponent extends StatefulWidget {
  final Widget child;

  const AlertDialogComponent({super.key, required this.child});

  @override
  State<AlertDialogComponent> createState() => _AlertDialogComponentState();
}

class _AlertDialogComponentState extends State<AlertDialogComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: widget.child,
        ),
      ),
    );
  }
}
