import 'package:flutter_riverpod/flutter_riverpod.dart';



//stateprovider is global var, whereever change occurs in its var, the particular widget will be listened and rebuilt without set state
final activeThemeProvider = StateProvider<Themes>((ref) => Themes.dark);

enum Themes {
  dark,
  light,
}
