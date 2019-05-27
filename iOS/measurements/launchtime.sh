#!/bin/bash

# Assumes that the application terminates
# Output containts 

RUN_TIMES=50;

# APP_PATH="/Users/tjarco/Development/thesis-pwa/iOS/ThesisPWA/build/Debug-iphoneos/Thesis iOS.app";
APP_PATH="/Users/Tjarco/Library/Developer/Xcode/DerivedData/Thesis_iOS-cydrhkpzjvjbboeyoworqkrlfzoi/Build/Products/Debug-iphoneos/Thesis iOS.app"
OPTIONS="--noninteractive --debug -s DYLD_PRINT_STATISTICS=1";
OUTPUT=/Users/tjarco/Development/thesis-pwa/iOS/measurements/launchtimes.txt;

DEPLOY="/Users/tjarco/Development/iOS/ios-deploy/build/Release/ios-deploy $OPTIONS --bundle";

# $DEPLOY "$APP_PATH";

for i in $(seq 1 $RUN_TIMES)
do
    echo "RUN $i";
    $DEPLOY "$APP_PATH" | awk '/main time/{print $0}' | awk -F' ' '{print $4}' >> $OUTPUT;
done

