import 'package:animate_do/animate_do.dart';
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
*/
class FadeAnimation extends StatelessWidget {
  final Widget child;

  const FadeAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 20,
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}


extension CapitalizeFirstLast on String {
  String capitalizedFirst() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();

  String capitalizeFirstLastSymbols() {
    if (isNotEmpty && contains('-')) {
      String firstSymbol = this[0].toUpperCase();
      String lastSymbol = this[length - 1].toUpperCase();
      return '$firstSymbol${substring(1, length - 1)}$lastSymbol';
    } else {
      return capitalizedFirst();
    }
  }
}


