import 'package:flutter/material.dart';

part 'colors.dart';
part 'text_styles.dart';

// App Themes
ThemeData getAppTheme(BuildContext context) => ThemeData(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.primary,
            onPrimary: Colors.white,
            secondary: Colors.secondary,
            error: Colors.redError,
          ),
      unselectedWidgetColor: Colors.gray,
      textTheme: TextTheme(
        bodyText2: TextStyles.reg12pt(),
        button: TextStyles.semiBold14pt(),
      ),
    );
