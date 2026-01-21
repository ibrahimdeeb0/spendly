import 'package:flutter/material.dart';
import 'package:spendly/l10n/app_localizations.dart' show AppLocalizations;

extension L10nX on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);
}
