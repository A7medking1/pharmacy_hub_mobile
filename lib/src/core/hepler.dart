import 'package:flutter/material.dart';

extension ThemeText on BuildContext {
  TextTheme get style => Theme.of(this).textTheme;

  TextStyle get titleSmall => style.titleSmall!;

  TextStyle get titleMedium => style.titleMedium!;

  TextStyle get titleLarge => style.titleLarge!;
}

/*

extension UrlLauncherExtension on String {
  Future<void> goToUrl() async {
    if (!await launchUrl(Uri.parse(this))) {
      throw Exception('Could not launch $this');
    }
  }
}

class FadeAnimation extends StatelessWidget {
  final Widget child;

  const FadeAnimation({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 20,
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
*/
