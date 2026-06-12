// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get title => '我的Flutter应用';

  @override
  String hello(String userName) {
    return '你好, $userName!';
  }

  @override
  String get home => '首页';

  @override
  String get messages => '消息';

  @override
  String get profile => '我的';
}
