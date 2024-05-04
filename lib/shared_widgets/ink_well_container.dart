import 'package:flutter/material.dart';

class InkWellContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Color? color;
  final Function() onTap;

  const InkWellContainer({
    super.key,
    this.child,
    this.width = 50,
    this.height = 50,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.3),
          child: child
        ),
      ),
    );
  }
}
