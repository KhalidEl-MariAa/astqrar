# Astarar (Eng. Sami Alfattani)

A new Flutter project.

## flutter and Android in $PATH
```bash
PATH="$PATH:$HOME/Documents/programs/flutter/bin"
PATH="$PATH:$HOME/Documents/programs/flutter/dart-sdk/bin"
PATH="$PATH:$HOME/Documents/programs/flutter/cmake/bin"

export ANDROID_HOME=$HOME/Documents/programs/android_sdk
PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
PATH="$PATH:$ANDROID_HOME/emulator"
PATH="$PATH:$ANDROID_HOME/platform-tools"
```

## Create AVD
`avdmanager` can be found in `/path/to/command-tools/bin/latest`

```bash
# get installed AVDs
> avdmanager list avd 
```

## Run Emulator
`emulator.exe` can be found in `/path/to/sdk/emulator/`

```bash
emulator -avd Resizable_API_33
emulator -avd Resizable_Experimental_API_33
```


## Run
```
flutter clean

# get availavle connected (running) devices
> flutter devices

cd "~\Downloads\Dating-kaheelan\astqrar"

flutter run
flutter run -d emulator-5554 
flutter run -d ce10171a81158d3101

```


## Deploy to Android
1. you can read this [article](https://docs.flutter.dev/deployment/android)
2. Make sure you are using same *.jks file (Upload Sining Key) that is already uploaded toe Google Play.
3. *.jks file need a password to be read properly which can be found in `key.properties` file.
```
flutter build apk

# for AAB file
flutter build appbundle
```
4. upload Sybmols file. compress all folders in:
```
  astqrar/build/app/intermediates/merged_native_libs/release/out/lib
```

## Deploy to IOS

1. Make sure that `gem` installer is ready to use.
2. Install Flutter 
```bash
# install cocoapods (building tool like Gradle)
$ sudo gem install cocoapods

# check installation 
$ gem which cocoapods
```
3. Edit project configurations using XCode

4. build API package
```bash
$ flutter build ipa
```
5. Upload using Transporter, this app can be found in apple store.

## Configure Firebase for (Notifications)
1. Make sure `npm` is ready to use
2. Create a Firebase Project from Google Firebase Console.
```bash
# install Firebase CLI
$ npm install -g firebase-tools

# check ...
$ firebase --version

# login to your Gmail account that contains the Firebase project and authorize it.
$ firebase login

$ cd Downloads/Dating/astqrar/

# Add or Update the flutter package 
$ flutter pub add firebase_core

# Install flutterfire_cli 
$  dart pub global activate flutterfire_cli

# Add it to PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"

# This will creates the 'firebase_options.dart' in your Flutter project
$ flutterfire configure --project=astqrar-b5dbd
```

6. in flutter initialize the firebase object like this
```dart
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  name: "astqrar", //project name in Firebase Console
  options: DefaultFirebaseOptions.currentPlatform,
);

```