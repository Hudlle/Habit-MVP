import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff196b52),
      surfaceTint: Color(0xff196b52),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa5f2d3),
      onPrimaryContainer: Color(0xff002116),
      secondary: Color(0xff4c6359),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee9db),
      onSecondaryContainer: Color(0xff082017),
      tertiary: Color(0xff3f6375),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc2e8fd),
      onTertiaryContainer: Color(0xff001f2b),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fbf6),
      onSurface: Color(0xff171d1a),
      onSurfaceVariant: Color(0xff404944),
      outline: Color(0xff707974),
      outlineVariant: Color(0xffbfc9c2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322f),
      inversePrimary: Color(0xff8ad6b7),
      primaryFixed: Color(0xffa5f2d3),
      onPrimaryFixed: Color(0xff002116),
      primaryFixedDim: Color(0xff8ad6b7),
      onPrimaryFixedVariant: Color(0xff00513c),
      secondaryFixed: Color(0xffcee9db),
      onSecondaryFixed: Color(0xff082017),
      secondaryFixedDim: Color(0xffb3ccbf),
      onSecondaryFixedVariant: Color(0xff354c42),
      tertiaryFixed: Color(0xffc2e8fd),
      onTertiaryFixed: Color(0xff001f2b),
      tertiaryFixedDim: Color(0xffa7cce0),
      onTertiaryFixedVariant: Color(0xff264b5c),
      surfaceDim: Color(0xffd5dbd6),
      surfaceBright: Color(0xfff5fbf6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae5),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004d39),
      surfaceTint: Color(0xff196b52),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff358268),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff31483e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff627a6f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff224758),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff55798c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fbf6),
      onSurface: Color(0xff171d1a),
      onSurfaceVariant: Color(0xff3c4540),
      outline: Color(0xff58615c),
      outlineVariant: Color(0xff737d77),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322f),
      inversePrimary: Color(0xff8ad6b7),
      primaryFixed: Color(0xff358268),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff156850),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff627a6f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a6157),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff55798c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3c6172),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd6),
      surfaceBright: Color(0xfff5fbf6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae5),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00281c),
      surfaceTint: Color(0xff196b52),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004d39),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff10261e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff31483e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002634),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff224758),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fbf6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1d2622),
      outline: Color(0xff3c4540),
      outlineVariant: Color(0xff3c4540),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322f),
      inversePrimary: Color(0xffaffcdc),
      primaryFixed: Color(0xff004d39),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003425),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff31483e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1b3128),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff224758),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff053141),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd6),
      surfaceBright: Color(0xfff5fbf6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae5),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ad6b7),
      surfaceTint: Color(0xff8ad6b7),
      onPrimary: Color(0xff003829),
      primaryContainer: Color(0xff00513c),
      onPrimaryContainer: Color(0xffa5f2d3),
      secondary: Color(0xffb3ccbf),
      onSecondary: Color(0xff1e352c),
      secondaryContainer: Color(0xff354c42),
      onSecondaryContainer: Color(0xffcee9db),
      tertiary: Color(0xffa7cce0),
      onTertiary: Color(0xff0a3445),
      tertiaryContainer: Color(0xff264b5c),
      onTertiaryContainer: Color(0xffc2e8fd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffdee4df),
      onSurfaceVariant: Color(0xffbfc9c2),
      outline: Color(0xff89938d),
      outlineVariant: Color(0xff404944),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inversePrimary: Color(0xff196b52),
      primaryFixed: Color(0xffa5f2d3),
      onPrimaryFixed: Color(0xff002116),
      primaryFixedDim: Color(0xff8ad6b7),
      onPrimaryFixedVariant: Color(0xff00513c),
      secondaryFixed: Color(0xffcee9db),
      onSecondaryFixed: Color(0xff082017),
      secondaryFixedDim: Color(0xffb3ccbf),
      onSecondaryFixedVariant: Color(0xff354c42),
      tertiaryFixed: Color(0xffc2e8fd),
      onTertiaryFixed: Color(0xff001f2b),
      tertiaryFixedDim: Color(0xffa7cce0),
      onTertiaryFixedVariant: Color(0xff264b5c),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8edabb),
      surfaceTint: Color(0xff8ad6b7),
      onPrimary: Color(0xff001b12),
      primaryContainer: Color(0xff549e83),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb7d1c4),
      onSecondary: Color(0xff041a12),
      secondaryContainer: Color(0xff7d968a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffabd0e5),
      onTertiary: Color(0xff001923),
      tertiaryContainer: Color(0xff7196a9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1512),
      onSurface: Color(0xfff6fcf7),
      onSurfaceVariant: Color(0xffc3cdc7),
      outline: Color(0xff9ba59f),
      outlineVariant: Color(0xff7c8580),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inversePrimary: Color(0xff00523d),
      primaryFixed: Color(0xffa5f2d3),
      onPrimaryFixed: Color(0xff00150d),
      primaryFixedDim: Color(0xff8ad6b7),
      onPrimaryFixedVariant: Color(0xff003f2e),
      secondaryFixed: Color(0xffcee9db),
      onSecondaryFixed: Color(0xff00150d),
      secondaryFixedDim: Color(0xffb3ccbf),
      onSecondaryFixedVariant: Color(0xff243b31),
      tertiaryFixed: Color(0xffc2e8fd),
      onTertiaryFixed: Color(0xff00131c),
      tertiaryFixedDim: Color(0xffa7cce0),
      onTertiaryFixedVariant: Color(0xff123a4b),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedfff5),
      surfaceTint: Color(0xff8ad6b7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8edabb),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedfff5),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb7d1c4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff7fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffabd0e5),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff3fdf6),
      outline: Color(0xffc3cdc7),
      outlineVariant: Color(0xffc3cdc7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inversePrimary: Color(0xff003123),
      primaryFixed: Color(0xffaaf7d7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8edabb),
      onPrimaryFixedVariant: Color(0xff001b12),
      secondaryFixed: Color(0xffd3eddf),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb7d1c4),
      onSecondaryFixedVariant: Color(0xff041a12),
      tertiaryFixed: Color(0xffcaecff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffabd0e5),
      onTertiaryFixedVariant: Color(0xff001923),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
