# xinyue

Flutter 管理端项目，基于 `flutter_riverpod + go_router + dio` 搭建。

## 快速开始

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define=APP_ENV=dev
```

生产环境可切换为：

```bash
flutter run --dart-define=APP_ENV=prod
```