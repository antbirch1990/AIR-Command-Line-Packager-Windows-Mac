@echo OFF

::: iOS Variables :::
set ios_platform=ios
set ios_test_interpreter_target=ipa-test-interpreter
set ios_debug_interpreter_target=ipa-debug-interpreter
set ios_test_target=ipa-test
set ios_debug_target=ipa-debug
set ios_ad_hoc_target=ipa-ad-hoc
set ios_app_store_target=ipa-app-store

::: Android Variables :::
set android_platform=android
set android_target=apk
set android_debug_target=apk-debug
set android_captive_runtime_target=apk-captive-runtime

::: Generic Variables :::
set packaging_action=null
set packaging_platform=null

::: Set Variables :::
set airsdk=null
set target=null
set certificate=null
set password=null
set provisionalprofile=null
set filename=null
set manifest=null
set swfname=null
set platform=null
set bundleid=null

set true=true
set false=false

set both_platforms=both
set both_compiled=false

set compile=compile
set compileremovepush=compileremovepush
set removepush=removepush

::: Setup Variables :::
call commands\setup_app.bat

set airsdk=%air_sdk%

::: Platform Selection :::
echo.
echo Package App
echo.
echo Select Platform:
echo.
echo [1] iOS
echo [2] Android
echo [3] Both
echo.
echo [0] Exit
echo.
set platformselection=
set /P platformselection=Platform: 
echo.

if /I '%platformselection%'=='1' set packaging_platform=%ios_platform%
if /I '%platformselection%'=='2' set packaging_platform=%android_platform%
if /I '%platformselection%'=='3' set packaging_platform=%both_platforms%
if /I '%platformselection%'=='0' goto:quit
goto:showCompiler

:showCompiler
::: Package Selection :::
echo ----------
echo.
echo Select Action:
echo.
echo [1] Compile
echo [2] Compile/Remove/Push
echo [3] Remove/Push
echo.
echo [0] Exit
echo.
set actionselection=
set /P actionselection=Action: 
echo.

if /I '%actionselection%'=='1' set packaging_action=%compile%
if /I '%actionselection%'=='2' set packaging_action=%compileremovepush%
if /I '%actionselection%'=='3' set packaging_action=%removepush%
if /I '%actionselection%'=='0' goto:quit
goto:showCompilerTargets

:showCompilerTargets

if /I '%packaging_platform%'=='%ios_platform%' (
	goto:compileForiOS
)
	
if /I '%packaging_platform%'=='%android_platform%' (
	goto:compileForAndroid
)

if /I '%packaging_platform%'=='%both_platforms%' (
	goto:compileForiOS
)

:compileForiOS
if /I '%packaging_action%'=='%removepush%' (
	set filename=%ios_ipa%
	set platform=%ios_platform%
	set bundleid=%ios_bundle_id%
	goto:packageApp
	
) else (
	goto:showIOSTargets
)

:compileForAndroid
if /I '%packaging_action%'=='%removepush%' (
	set filename=%ios_ipa%
	set platform=%ios_platform%
	set bundleid=%ios_bundle_id%
	goto:packageApp
	
) else (
	goto:showAndroidTargets
)

:showIOSTargets
::: iOS Target Selection :::
echo ----------
echo.
echo Select iOS Target:
echo.
echo [1] fast test (ipa-test-interpreter)
echo [2] fast debug (ipa-debug-interpreter)
echo [3] slow test (ipa-test)
echo [4] slow debug (ipa-debug)

if /I '%packaging_action%'=='%compile%' echo [5] ad-hoc (ipa-ah-hoc)
if /I '%packaging_action%'=='%compile%' echo [6] app store (ipa-app-store)

echo.
echo [0] Exit
echo.
set iostargetselection=
set /P iostargetselection=Target: 

if /I '%iostargetselection%'=='1' (
	set target=%ios_test_interpreter_target%
	set certificate=%ios_development_certificate%
	set password=%ios_development_password%
	set provisionalprofile=%ios_development_provisional_profile%
	set filename=%ios_ipa%
	set manifest=%ios_development_manifest%
	set swfname=%ios_swf_name%
	set platform=%ios_platform%
	set bundleid=%ios_bundle_id%
)

if /I '%iostargetselection%'=='2' (
	set target=%ios_debug_interpreter_target%
	set certificate=%ios_development_certificate%
	set password=%ios_development_password%
	set provisionalprofile=%ios_development_provisional_profile%
	set filename=%ios_ipa%
	set manifest=%ios_development_manifest%
	set swfname=%ios_swf_name%
	set platform=%ios_platform%
	set bundleid=%ios_bundle_id%
)

if /I '%iostargetselection%'=='3' (
	set target=%ios_test_target%
	set certificate=%ios_development_certificate%
	set password=%ios_development_password%
	set provisionalprofile=%ios_development_provisional_profile%
	set filename=%ios_ipa%
	set manifest=%ios_development_manifest%
	set swfname=%ios_swf_name%
	set platform=%ios_platform%
	set bundleid=%ios_bundle_id%
)

if /I '%iostargetselection%'=='4' (
	set target=%ios_debug_target%
	set certificate=%ios_development_certificate%
	set password=%ios_development_password%
	set provisionalprofile=%ios_development_provisional_profile%
	set filename=%ios_ipa%
	set manifest=%ios_development_manifest%
	set swfname=%ios_swf_name%
	set platform=%ios_platform%
	set bundleid=%ios_bundle_id%
)

if /I '%packaging_action%'=='%compile%' (
	if /I '%iostargetselection%'=='5' (
		set target=%ios_ad_hoc_target%
		set certificate=%ios_adhoc_certificate%
		set password=%ios_adhoc_password%
		set provisionalprofile=%ios_adhoc_provisional_profile%
		set filename=%ios_ipa%
		set manifest=%ios_distribution_manifest%
		set swfname=%ios_swf_name%
		set platform=%ios_platform%
		set bundleid=%ios_bundle_id%
	)
	
	if /I '%iostargetselection%'=='6' (
		set target=%ios_app_store_target%
		set certificate=%ios_distribution_certificate%
		set password=%ios_distribution_password%
		set provisionalprofile=%ios_distribution_provisional_profile%
		set filename=%ios_ipa%
		set manifest=%ios_distribution_manifest%
		set swfname=%ios_swf_name%
		set platform=%ios_platform%
		set bundleid=%ios_bundle_id%
	)
)

if /I '%iostargetselection%'=='0' goto:quit
goto:packageApp

:showAndroidTargets
::: Android Target Selection :::
echo ----------
echo.
echo Select Android Target:
echo.
echo [1] normal (apk)
echo [2] debug (apk-debug)
echo [3] captive runtime (apk-captive-runtime)
echo.
echo [0] Exit
echo.
set androidtargetselection=
set /P androidtargetselection=Target: 
echo.

if /I '%androidtargetselection%'=='1' (
	set target=%android_target%
	set certificate=%android_certificate%
	set password=%android_password%
	set provisionalprofile=null
	set filename=%android_apk%
	set manifest=%android_manifest%
	set swfname=%android_swf_name%
	set platform=%android_platform%
	set bundleid=%android_bundle_id%
)

if /I '%androidtargetselection%'=='2' (
	set target=%android_debug_target%
	set certificate=%android_certificate%
	set password=%android_password%
	set provisionalprofile=null
	set filename=%android_apk%
	set manifest=%android_manifest%
	set swfname=%android_swf_name%
	set platform=%android_platform%
	set bundleid=%android_bundle_id%
)

if /I '%androidtargetselection%'=='3' (
	set target=%android_captive_runtime_target%
	set certificate=%android_certificate%
	set password=%android_password%
	set provisionalprofile=null
	set filename=%android_apk%
	set manifest=%android_manifest%
	set swfname=%android_swf_name%
	set platform=%android_platform%
	set bundleid=%android_bundle_id%
)

if /I '%androidtargetselection%'=='0' goto:quit
goto:packageApp

:packageApp
if /I '%packaging_action%'=='%compile%' goto:compileApp
if /I '%packaging_action%'=='%compileremovepush%' goto:compileRemovePushApp
if /I '%packaging_action%'=='%removepush%' goto:removePushApp

:compileApp
if /I '%platform%'=='%ios_platform%' (
	echo.
	call commands\compile_ipa.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%
	echo Compile for iOS complete
)

if /I '%platform%'=='%android_platform%' (
	call commands\compile_apk.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%
	echo.
	echo Compile for Android complete
)

if /I '%packaging_platform%'=='%both_platforms%' (
	if /I '%both_compiled%'=='%false%' (
		set both_compiled=%true%
		goto:compileForAndroid
	) else (
		echo.
		echo ----------
		echo.
		goto:quit
	)
) else (
	echo.
	echo ----------
	echo.
	goto:quit
)

:compileRemovePushApp
if /I '%platform%'=='%ios_platform%' (
	echo.
	call commands\compile_ipa.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%
	echo Compile for iOS complete
)

if /I '%platform%'=='%android_platform%' (
	call commands\compile_apk.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%
	echo.
	echo Compile for Android complete
)

call commands\remove_from_device.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%
call commands\push_to_device.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%

if /I '%packaging_platform%'=='%both_platforms%' (
	if /I '%both_compiled%'=='%false%' (
		set both_compiled=%true%
		goto:compileForAndroid
	) else (
		echo.
		echo ----------
		echo.
		goto:quit
	)
) else (
	echo.
	echo ----------
	echo.
	goto:quit
)

:removePushApp
call commands\remove_from_device.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%
call commands\push_to_device.bat %target% %certificate% %password% %provisionalprofile% %filename% %manifest% %swfname% %platform% %bundleid%

if /I '%packaging_platform%'=='%both_platforms%' (
	if /I '%both_compiled%'=='%false%' (
		set both_compiled=%true%
		goto:compileForAndroid
	) else (
		echo.
		echo ----------
		echo.
		goto:quit
	)
) else (
	echo.
	echo ----------
	echo.
	goto:quit
)

:quit
PAUSE
goto:eof