#!/bin/sh

export air_sdk=../../AIR_SDK/AIR16.0/bin/adt

### iOS ###
export ios_adhoc_certificate=certificates/AdHoc_Certificate.p12
export ios_development_certificate=certificates/Development_Certificate.p12
export ios_distribution_certificate=certificates/Distribution_Certificate.p12
export ios_adhoc_password=password
export ios_development_password=password
export ios_distribution_password=password

export ios_adhoc_provisional_profile=certificates/App_AdHoc.mobileprovision
export ios_development_provisional_profile=certificates/App_Development.mobileprovision
export ios_distribution_provisional_profile=certificates/App_Distribution.mobileprovision
export ios_ipa=Test_ios.ipa
export ios_development_manifest=manifests/iOS_Development-app.xml
export ios_distribution_manifest=manifests/iOS_Distribution-app.xml
export ios_swf_name=Test.swf
export ios_bundle_id=com.website.appName

### Android ###
export android_certificate=certificates/Android-Certificate.p12
export android_password=password

export android_apk=Test_android.apk
export android_manifest=manifests/Android-app.xml
export android_swf_name=Test.swf
export android_bundle_id=com.website.appName

### Amazon ###
export amazon_certificate=certificates/Amazon-Certificate.p12
export amazon_password=password

export amazon_apk=Test_amazon.apk
export amazon_manifest=manifests/Amazon-app.xml
export amazon_swf_name=Test.swf
export amazon_bundle_id=com.website.appName