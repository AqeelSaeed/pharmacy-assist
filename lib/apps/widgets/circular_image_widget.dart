import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  final Image child;
  final double size;

  const CircularImageWidget({super.key, required this.child, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(size),
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: child,
        ),
      ),
    );
  }
}
