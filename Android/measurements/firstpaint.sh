#!/bin/bash

# Installs and executes the android appliction multiple times and saves the first paint time in the file paint.txt

RUN_TIMES=50;

PACKAGE=com.example.androidpwathesis;
ACTIVITY=.MainActivity;
APK_LOCATION=/Users/tjarco/Development/thesis-pwa/Android/AndroidPWAThesis/app/build/outputs/apk/debug/app-debug.apk;

adb uninstall $PACKAGE;
adb install $APK_LOCATION;

echo "Starting $ACTIVITY $RUN_TIMES times";

adb shell am start -R $RUN_TIMES -S -W -n $PACKAGE/$ACTIVITY | awk '/TotalTime/ {print $2}' >> paint.txt;
