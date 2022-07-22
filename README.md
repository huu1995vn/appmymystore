# raoxe

A new Flutter project.

## Getting Started

IOS: $ flutter build ios -t lib/main_[env].dart --flavor [env] --release
APK: $ flutter build apk -t lib/main_[env].dart --flavor [env] --release
Appbundle stg: $ flutter build appbundle -t lib/main_[env].dart --flavor [env] --release
Run $ flutter run -t lib/main_[env].dart --flavor [env] --release

## Build icon
$ flutter pub run flutter_launcher_icons:main

## flutter clean for update AndroidManifest.xml
flutter clean

## code generation libraries
flutter pub run build_runner watch --delete-conflicting-outputs
