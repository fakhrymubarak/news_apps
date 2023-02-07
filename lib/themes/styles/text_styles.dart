part of 'app_themes.dart';

class TextStyles {
  TextStyles._();

  // Bold(w700), 16pt
  static TextStyle bold16pt([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins',
      color: color ?? Colors.black,
    );
  }

  // SemiBold(w600), 14pt
  static TextStyle semiBold14pt([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: color ?? Colors.black,
    );
  }

  // Regular(w400), 12pt
  static TextStyle regular12pt([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
      color: color ?? Colors.black,
    );
  }

  // Regular(w400), 10pt
  static TextStyle regular10pt([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
      color: color ?? Colors.gray,
    );
  }
}
