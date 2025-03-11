import 'package:flutter/widgets.dart';
import 'theme.dart';
import 'theme_wrapper.dart';
import '../../flutter_neumorphic.dart';


typedef NeumorphicThemeUpdater = NeumorphicThemeData Function(
    NeumorphicThemeData? current);

class NeumorphicThemeInherited extends InheritedWidget {
  final Widget child;
  final ThemeWrapper value;
  final ValueChanged<ThemeWrapper> onChanged;

  NeumorphicThemeInherited(
      {Key? key,
      required this.child,
      required this.value,
      required this.onChanged})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(NeumorphicThemeInherited old) => value != old.value;

  //Eirik 10.03.25: Old code
/*  NeumorphicThemeData? get current {
    return this.value.current;
  }*/

  //Eirik 10.03.25: Updated code
  NeumorphicThemeData get current {
    return this.value.current ?? neumorphicDefaultTheme;
  }

  bool get isUsingDark {
    return value.useDark;
  }

  ThemeMode get themeMode => value.themeMode;

  set themeMode(ThemeMode currentTheme) {
    this.onChanged(value.copyWith(currentTheme: currentTheme));
  }

  void updateCurrentTheme(NeumorphicThemeData update) {
    if (value.useDark) {
      final newValue = value.copyWith(darkTheme: update);
      //this.value = newValue;
      this.onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      //this.value = newValue;
      this.onChanged(newValue);
    }
  }

  void update(NeumorphicThemeUpdater themeUpdater) {
    final update = themeUpdater(value.current);
    if (value.useDark) {
      final newValue = value.copyWith(darkTheme: update);
      //this.value = newValue;
      this.onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      //this.value = newValue;
      this.onChanged(newValue);
    }
  }
}