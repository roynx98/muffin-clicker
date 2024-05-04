import 'package:flutter/material.dart';

class InkWellContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final Function() onTap;

  const InkWellContainer({
    super.key,
    this.child,
    this.width = 50,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      width: width,
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.3),
          child: child
        ),
      ),
    );
  }
}
