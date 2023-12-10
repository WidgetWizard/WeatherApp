

import 'package:flutter/material.dart';

class _ContextDurationExtension{
  Duration get durationFast=> const Duration(milliseconds: 350);
  Duration get durationNormal => const Duration(seconds: 1);
  Duration get durationSlow => const Duration(seconds: 2);
}

extension DurationExtension on BuildContext{
  _ContextDurationExtension get duration => _ContextDurationExtension();
}