import 'package:flutter/material.dart';

import '../main_barrel.dart';

class CustomAnimatedDialog extends StatefulWidget {
  final String title;
  final String message;
  final bool info;
  final IconData? icon;
  final VoidCallback onPositiveClick;
  const CustomAnimatedDialog({
    super.key,
    required this.title,
    required this.message,
    this.info = false,
    this.icon,
    required this.onPositiveClick,
  });
  @override
  // ignore: library_private_types_in_public_api
  _CustomAnimatedDialogState createState() => _CustomAnimatedDialogState();
}

class _CustomAnimatedDialogState extends State<CustomAnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.info
                  ? Icon(
                      widget.icon ?? Icons.check_circle_outline,
                      color: Theme.of(context).primaryColor,
                      size: 90,
                    )
                  : Icon(
                      widget.icon ?? Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 90,
                    ),
              const SizedBox(height: 16.0),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Palette.loginGradiant2,
                      Palette.primary,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(8), // Optional: Add border radius
                ),
                child: ElevatedButton(
                  onPressed: widget.onPositiveClick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Makes the button's default color transparent
                    minimumSize: const Size(120, 50),
                    shadowColor:
                        Colors.transparent, // Optional: Remove shadow if needed
                  ),
                  child: Text(
                    okay.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Palette.secondary,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
