import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    this.size = 28,
    super.key,
  });

  final double size;

  static const String _assetPath = 'assets/muscleup.svg';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticsLabel: 'Muscleup logo',
    );
  }
}
