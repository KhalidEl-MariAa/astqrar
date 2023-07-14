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


## Deploy
you can read this [article](https://docs.flutter.dev/deployment/android)
```
flutter build apk

```


55555555