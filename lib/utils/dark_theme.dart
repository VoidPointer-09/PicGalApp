import 'package:flutter/material.dart';
import 'package:picgalapp/utils/colors.dart';
import 'custom_theme.dart';

class DarkTheme implements CustomTheme {
  @override
  var shimmer_colors = [
    cFFFFFF.withOpacity(.1),
    cFFFFFF.withOpacity(.7),
    cFFFFFF.withOpacity(.1),
  ];
  @override
  var cFFFFFF_c0B0F1C = c0B0F1C;
  @override
  var cE7E8EA_c444444 = c444444;
  @override
  var cFFFFFF_c1E2230 = c1E2230;
}
