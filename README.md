<b>Adobe AIR App Packager for Windows (.bat) and Mac (.sh) - iOS, Android and Amazon</b>
======================================

This is a demo Adobe AIR app for iOS, Android and Amazon devices which includes Command Line (.bat) files for Windows users and Terminal (.sh) files for Mac users. This project was created so that an AIR app can be set up without having to edit multiple command line files. 

iOS packages for .ipa and both Android and Amazon package to .apk

(Step 1) Create Certificates and Provisional Profiles
---------

You will need to supply your own iOS, Android and Amazon certificates and provisional profiles for publishing to the App Store, Google Play Store and Amazon Appstore. AdHoc certificate and provisional profile only needed if you wish to publish for AdHoc.

#### iOS ####

- certificates/Development_Certificate.p12
- certificates/Distribution_Certificate.p12
- certificates/AdHoc_Certificate.p12
- certificates/App_Development.mobileprovision
- certificates/App_Distribution.mobileprovision
- certificates/App_AdHoc.mobileprovision

#### Android ####

* certificates/Android-Certificate.p12

#### Amazon ####

* certificates/Amazon-Certificate.p12


(Step 2) Include native extensions
---------

Native extensions can be simply thought of as classes which allow AIR apps to access features which would traditionally only be available to natively programmed apps. If you are not including native extensions with your AIR app then simply skip this step. You can purchase very well documented native extensions for iOS and Android from:

* [Milkman Games](http://www.milkmangames.com/blog/tools/) (step by step documentation)
* [distriqt](http://www.airnativeextensions.com/extensions/)

You will need to follow these instructions for each native extension you wish to use

* Create a copy of the native extension's .ane and .swc files
* Place the .ane in the extensions folder
* Place the .swc in the lib folder
* In Flash Professional navigate to File > ActionScript Settings... > Library Path > Browse to a Native Extension (ANE) file
* Browse to the .ane file in the extensions folder and hit OK
* Follow the instructions included with the native extension to start using its features


(Step 3) Editing Manifest Files
---------

#### iOS ####

* Open manifests/iOS_Development-app.xml
* Open manifests/iOS_Distribution-app.xml

#### Android ####

* Open manifests/Android-app.xml

#### Amazon ####

* Open manifests/Amazon-app.xml

#### iOS, Android and Amazon ####

Edit the elements shown below:

```xml
<id>com.website.appName</id> <!-- This must match the application's ID -->
<filename>Test</filename>
<name.Test</name>
<content>Test.swf</content>
<extensionID>com.extensions.example</extensionID> <!-- If you are not using a native extension remove this line -->
```

If you are using a native extension(s) be sure to follow the instructions included in regards to modifying the manifest file(s). This may be referred to as the application descriptor. Do not skip this step, especially if building for Android/Amazon devices.


(Step 4) Setup App Packager
---------

#### Mac ####

* Open commands/setup_app.sh in a text editor
* Edit the path shown below to point to the location of your AIR SDK
* Make any changes to the file paths as necessary

```sh
export airsdk=../../AIR_SDK/AIR16.0/bin/adt
```

#### Windows ####

* Open commands/setup_app.bat in a text editor
* Edit the path shown below to point to the location of your AIR SDK
* Make any changes to the file paths as necessary

```bash
set airsdk=../../AIR_SDK/AIR16.0/bin/adt
```

(Step 5) Package and Push App
---------

#### Mac ####

```sh
chmod +x build_app.sh
```

* Copy and paste the code above into a terminal opened at the projects root (right click project folder and select 'New Terminal at Folder')
* Drag the build_app.sh file into the open terminal and press Enter to execute
* Follow the terminal instructions to successfully compile, remove and push ipa/apk files

#### Windows ####

* Double click the build_app.bat file to execute
* Follow the command line instructions to successfully compile, remove and push ipa/apk files
