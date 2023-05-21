# astarar

A new Flutter project.

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
```


## Run
```
flutter clean

# get availavle connected (running) devices
> flutter devices

flutter run
flutter run -d emulator-5554 

```
