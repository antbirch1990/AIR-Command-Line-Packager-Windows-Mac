#!/bin/bash

### iOS Variables ###
ios_platform=ios
ios_test_interpreter_target=ipa-test-interpreter
ios_debug_interpreter_target=ipa-debug-interpreter
ios_test_target=ipa-test
ios_debug_target=ipa-debug
ios_ad_hoc_target=ipa-ad-hoc
ios_app_store_target=ipa-app-store

### Android Variables ###
android_platform=android
android_target=apk
android_debug_target=apk-debug
android_captive_runtime_target=apk-captive-runtime

### Amazon Variables ###
amazon_platform=amazon

## Generic Variables ###
packaging_action=null
packaging_platform=null
device_platform=null

### Export Variables ###
export airsdk=null
export target=null
export certificate=null
export password=null
export provisionalprofile=null
export filename=null
export manifest=null
export swfname=null
export platform=null
export bundleid=null

### Allow Permissions ###
chmod +x ./commands/compile_ios.sh
chmod +x ./commands/compile_android.sh
chmod +x ./commands/compile_amazon.sh
chmod +x ./commands/remove_from_device.sh
chmod +x ./commands/push_to_device.sh
chmod +x ./commands/setup_app.sh

### Setup Variables ###
source ./commands/setup_app.sh

airsdk="$air_sdk";

function packageApp() {
	### Package Selected App ###

    if [ "$packaging_action" = "compile" ]; then
        if [ "$packaging_platform" = "$ios_platform" ]; then
            echo ""
            bash ./commands/compile_ios.sh
            echo "Compile for iOS complete"
            echo ""
            
        elif [ "$packaging_platform" = "$android_platform" ]; then
            echo ""
            bash ./commands/compile_android.sh
            echo ""
            echo "Compile for Android complete"
            echo ""
        
        elif [ "$packaging_platform" = "$amazon_platform" ]; then
            echo ""
            bash ./commands/compile_amazon.sh
            echo ""
            echo "Compile for Amazon complete"
            echo ""
        fi
        
    elif [ "$packaging_action" = "compileremovepush" ]; then
        if [ "$packaging_platform" = "$ios_platform" ]; then
            echo ""
            bash ./commands/compile_ios.sh
            echo "Compile for iOS complete"
            echo ""
            
        elif [ "$packaging_platform" = "$android_platform" ]; then
            echo ""
            bash ./commands/compile_android.sh
            echo ""
            echo "Compile for Android complete"
        
        elif [ "$packaging_platform" = "$amazon_platform" ]; then
            echo ""
            bash ./commands/compile_amazon.sh
            echo ""
            echo "Compile for Amazon complete"
        fi

        bash ./commands/remove_from_device.sh
        bash ./commands/push_to_device.sh
        
        if [ "$packaging_platform" = "$ios_platform" ]; then 
            echo ""
        fi
        
    else
        
        if [ "$packaging_platform" = "$ios_platform" ]; then 
            echo ""
        fi
        
        bash ./commands/remove_from_device.sh
        bash ./commands/push_to_device.sh
        echo ""
        echo "----------"
        echo ""
    fi
}

function showIOSTargets() {
    ### iOS Target Selection ###
    echo ""
    echo "----------"
    echo ""
    echo "Select iOS Target:"
    echo ""
    echo "[1] fast test (ipa-test-interpreter)"
    echo "[2] fast debug (ipa-debug-interpreter)"
    echo "[3] slow test (ipa-test)"
    echo "[4] slow debug (ipa-debug)"
    
    if [ "$packaging_action" = "compile" ]; then
        echo "[5] ad-hoc (ipa-ah-hoc)"
        echo "[6] app store (ipa-app-store)"
    fi
    
    echo ""
    echo "[0] Exit"
    echo ""
    echo -n "Target: "

    while :
    do
    
    read targetselection
    
    case $targetselection in
        1 ) target="$ios_test_interpreter_target";
            certificate="$ios_development_certificate";
            password="$ios_development_password";
            provisionalprofile="$ios_development_provisional_profile";
            filename="$ios_ipa";
            manifest="$ios_development_manifest";
            swfname="$ios_swf_name";
            platform="$ios_platform";
            bundleid="$ios_bundle_id";
            packageApp
            break
            ;;

        2 ) target="$ios_debug_interpreter_target";
            certificate="$ios_development_certificate";
            password="$ios_development_password";
            provisionalprofile="$ios_development_provisional_profile";
            filename="$ios_ipa";
            manifest="$ios_development_manifest";
            swfname="$ios_swf_name";
            platform="$ios_platform";
            bundleid="$ios_bundle_id";
            packageApp
            break
            ;;

        3 ) target="$ios_test_target";
            certificate="$ios_development_certificate";
            password="$ios_development_password";
            provisionalprofile="$ios_development_provisional_profile";
            filename="$ios_ipa";
            manifest="$ios_development_manifest";
            swfname="$ios_swf_name";
            platform="$ios_platform";
            bundleid="$ios_bundle_id";
            packageApp
            break
            ;;

        4 ) target="$ios_debug_target";
            certificate="$ios_development_certificate";
            password="$ios_development_password";
            provisionalprofile="$ios_development_provisional_profile";
            filename="$ios_ipa";
            manifest="$ios_development_manifest";
            swfname="$ios_swf_name";
            platform="$ios_platform";
            bundleid="$ios_bundle_id";
            packageApp
            break
            ;;

        5 ) if [ "$packaging_action" = "compile" ]; then
                target="$ios_ad_hoc_target";
                certificate="$ios_adhoc_certificate";
                password="$ios_adhoc_password";
                provisionalprofile="$ios_adhoc_provisional_profile";
                filename="$ios_ipa";
                manifest="$ios_distribution_manifest";
                swfname="$ios_swf_name";
                platform="$ios_platform";
                bundleid="$ios_bundle_id";
                packageApp
                break
            fi
            exit ;;

        6 ) if [ "$packaging_action" = "compile" ]; then
                target="$ios_app_store_target";
                certificate="$ios_distribution_certificate";
                password="$ios_distribution_password";
                provisionalprofile="$ios_distribution_provisional_profile";
                filename="$ios_ipa";
                manifest="$ios_distribution_manifest";
                swfname="$ios_swf_name";
                platform="$ios_platform";
                bundleid="$ios_bundle_id";
                packageApp
                break
            fi
            exit ;;
            
        0 ) exit ;;
    esac
    done
}

function showAndroidTargets() {
    ### Android Target Selection ###
    echo ""
    echo "----------"
    echo ""
    echo "Select Android Target:"
    echo ""
    echo "[1] normal (apk)"
    echo "[2] debug (apk-debug)"
    echo "[3] captive runtime (apk-captive-runtime)"
    echo ""
    echo "[0] Exit"
    echo ""
    echo -n "Target: "

    while :
    do

    read targetselection
    
    case $targetselection in
        1 ) target="$android_target";
            certificate="$android_certificate";
            password="$android_password";
            provisionalprofile=null;
            filename="$android_apk";
            manifest="$android_manifest";
            swfname="$android_swf_name";
            platform="$android_platform";
            bundleid="$android_bundle_id";
            packageApp
            break
            ;;

        2 ) target="$android_debug_target";
            certificate="$android_certificate";
            password="$android_password";
            provisionalprofile=null;
            filename="$android_apk";
            manifest="$android_manifest";
            swfname="$android_swf_name";
            platform="$android_platform";
            bundleid="$android_bundle_id";
            packageApp
            break
            ;;

        3 ) target="$android_captive_runtime_target";
            certificate="$android_certificate";
            password="$android_password";
            provisionalprofile=null;
            filename="$android_apk";
            manifest="$android_manifest";
            swfname="$android_swf_name";
            platform="$android_platform";
            packageApp
            break
            ;;

        0 ) exit ;;
    esac
    done
}

function showAmazonTargets() {
    ### Amazon Target Selection ###
    echo ""
    echo "----------"
    echo ""
    echo "Select Amazon Target:"
    echo ""
    echo "[1] normal (apk)"
    echo "[2] debug (apk-debug)"
    echo "[3] captive runtime (apk-captive-runtime)"
    echo ""
    echo "[0] Exit"
    echo ""
    echo -n "Target: "

    while :
    do

    read targetselection
    
    case $targetselection in
        1 ) target="$android_target";
            certificate="$amazon_certificate";
            password="$amazon_password";
            provisionalprofile=null;
            filename="$amazon_apk";
            manifest="$amazon_manifest";
            swfname="$amazon_swf_name";
            platform="$android_platform";
            bundleid="$amazon_bundle_id";
            packageApp
            break
            ;;

        2 ) target="$android_debug_target";
            certificate="$amazon_certificate";
            password="$amazon_password";
            provisionalprofile=null;
            filename="$amazon_apk";
            manifest="$amazon_manifest";
            swfname="$amazon_swf_name";
            platform="$android_platform";
            bundleid="$amazon_bundle_id";
            packageApp
            break
            ;;

        3 ) target="$android_captive_runtime_target";
            certificate="$amazon_certificate";
            password="$amazon_password";
            provisionalprofile=null;
            filename="$amazon_apk";
            manifest="$amazon_manifest";
            swfname="$amazon_swf_name";
            platform="$android_platform";
            packageApp
            break
            ;;

        0 ) exit ;;
    esac
    done
}

function showCompilerTargets() {
    if [ "$packaging_platform" = "$ios_platform" ]; then
        if [ "$packaging_action" = "removepush" ]; then
            filename="$ios_ipa";
            platform="$ios_platform";
            bundleid="$ios_bundle_id";
            packageApp
            break
        else 
            showIOSTargets
        fi
        
    elif [ "$packaging_platform" = "$android_platform" ]; then
        if [ "$packaging_action" = "removepush" ]; then
            filename="$android_apk";
            platform="$android_platform";
            bundleid="$android_bundle_id";
            packageApp
            break
        else 
            showAndroidTargets
        fi
        
     elif [ "$packaging_platform" = "$amazon_platform" ]; then
        if [ "$packaging_action" = "removepush" ]; then
            filename="$amazon_apk";
            platform="$android_platform";
            bundleid="$amazon_bundle_id";
            packageApp
            break
        else 
            showAmazonTargets
        fi
        
    else
        packaging_platform="$ios_platform"
        showIOSTargets
        packaging_platform="$android_platform"
        showAndroidTargets
        packaging_platform="$amazon_platform"
        showAmazonTargets
    fi
    
    echo "----------"
    echo ""
}

function showCompiler() {
    ### Action Selection ###
    echo ""
    echo "----------"
    echo ""
    echo "Select Action:"
    echo ""
    echo "[1] Compile"
    echo "[2] Compile/Remove/Push"
    echo "[3] Remove/Push"
    echo ""
    echo "[0] Exit"
    echo ""
    echo -n "Action: "

    while :
    do
    read actionselection
    
    case $actionselection in
        1 ) packaging_action=compile
            showCompilerTargets
            break
            ;;

        2 ) packaging_action=compileremovepush
            showCompilerTargets
            break
            ;;

        3 ) packaging_action=removepush
            showCompilerTargets
            break
            ;;

        0 ) exit ;;
    esac
    done
}

function showCompilerForAll() {
    ### Action Selection ###
    echo ""
    echo "----------"
    echo ""
    echo "Select Action:"
    echo ""
    echo "[1] Compile"
    echo ""
    echo "[0] Exit"
    echo ""
    echo -n "Action: "

    while :
    do
    read actionselection
    
    case $actionselection in
        1 ) packaging_action=compile
            showCompilerTargets
            break
            ;;

        0 ) exit ;;
    esac
    done
}

function showPlatform() {
    ### Platform Selection ###
    echo ""
	echo "---"
	echo "Created by Anthony Birch"
	echo "---"
	echo ""
    echo "Package App"
    echo ""
    echo "Select Platform:"
    echo ""
    echo "[1] iOS"
    echo "[2] Android"
    echo "[3] Amazon"
    echo "[4] All"
    echo ""
    echo "[0] Exit"
    echo ""
    echo -n "Platform: "

    while :
    do
    read platformselection
    
    case $platformselection in
        1 ) packaging_platform="$ios_platform"
            showCompiler
            break
            ;;

        2 ) packaging_platform="$android_platform"
            showCompiler
            break
            ;;
            
        3 ) packaging_platform="$amazon_platform"
            showCompiler
            break
            ;;
            
        4 ) packaging_platform="both"
            showCompilerForAll
            break
            ;;

        0 ) exit ;;
    esac
    done
}

# First function fired
showPlatform