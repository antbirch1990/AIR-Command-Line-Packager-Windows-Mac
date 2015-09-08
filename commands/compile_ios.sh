#!/bin/sh

"$airsdk" -package -target "$target" -storetype pkcs12 -keystore "$certificate" -storepass "$password" -provisioning-profile "$provisionalprofile" "$filename" "$manifest" "$swfname" -C images/ios Default.png Default@2x.png Default-568h@2x.png Default-Portrait.png Default-Portrait@2x.png Default-Portrait-667h@2x.png Default-Portrait-736h@3x.png icons -extdir extensions