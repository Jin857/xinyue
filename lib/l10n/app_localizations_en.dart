// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'My Flutter App';

  @override
  String hello(String userName) {
    return 'Hello, $userName!';
  }

  @override
  String get home => 'Home';

  @override
  String get messages => 'Messages';

  @override
  String get profile => 'My';
}
