import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// common class for make a smooth effect

class SmootherView extends StatelessWidget {
  final Widget child;
  const SmootherView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(delay: 50.ms, duration: 400.ms);
  }
}

class SmoothView extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final double? downValue;

  const SmoothView({
    required this.child,
    this.duration,
    this.downValue,
    super.key,
  });

  @override
  _SmoothViewState createState() => _SmoothViewState();
}

class _SmoothViewState extends State<SmoothView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double opacity = _animation.value;
        double translateY = (1 - _animation.value) * (widget.downValue ?? 5);
        return Transform.translate(
          offset: Offset(0, translateY),
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

// made drop down effect

class DropDownEffect extends StatelessWidget {
  final Widget child;
  const DropDownEffect({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .slideY(
            begin: -0.2,
            end: 0.0,
            duration: 300.ms,
            curve: Curves.easeOut)
        .fadeIn(duration: 1000.ms);
  }
}
