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
## Fix auth not sync/clone: username alow access source
git remote set-url origin https://[username]@dev.azure.com/gianhangvn/DailyXe/_git/RaoXe
## Generate SHA-1
Mac keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Windows keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore 

Linux keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android