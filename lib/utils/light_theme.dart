
import 'package:flutter/material.dart';
import 'package:picgalapp/utils/colors.dart';

import 'custom_theme.dart';

class LightTheme implements CustomTheme {
  @override
  var shimmer_colors = [
    cFFFFFF.withOpacity(.1),
    c737373.withOpacity(0.7),
    cFFFFFF.withOpacity(.1),
  ];
  @override
  var cFFFFFF_c0B0F1C = cFFFFFF;
  @override
  var cE7E8EA_c444444 = cE7E8EA;
  @override
  var cFFFFFF_c1E2230 = cE7E8EA;
}
