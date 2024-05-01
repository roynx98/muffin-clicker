import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Clicker extends StatefulWidget {
  final Function(Offset) onCick;
  const Clicker({super.key, required this.onCick});

  @override
  State<Clicker> createState() {
    return _ClickerState();
  }
}

class _ClickerState extends State<Clicker> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  late final AnimationController _scaleAnimationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300))
      ..repeat(reverse: true);
    const angle = 0.01;
    _animation =
        Tween<double>(begin: -angle, end: angle).animate(_animationController);

    _scaleAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.9).animate(_scaleAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const _LightBeam(),
        GestureDetector(
          onTapDown: (details) {
            final origin =
                Offset(details.globalPosition.dx, details.globalPosition.dy);
            startShrinkAnimation();
            widget.onCick(origin);
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: RotationTransition(
              turns: _animation,
              child: Image.asset(
                'assets/img/muffin.png',
                width: 200,
              ),
            ),
          ),
        )
      ],
    );
  }

  startShrinkAnimation() {
    _scaleAnimationController.forward().then((value) {
      _scaleAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }
}

class _LightBeam extends StatefulWidget {

  const _LightBeam();

  @override
  State<_LightBeam> createState() {
    return _LightBeamState();
  }
}

class _LightBeamState extends State<_LightBeam> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Image.asset(
        'assets/img/light.png',
        width: 300,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
