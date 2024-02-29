{ pkgs, ... }:
let
  buildToolsVersion = "34.0.0";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ buildToolsVersion "28.0.3" ];
    platformVersions = [ "34" "28" ];
    abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
  };
  androidSdk = androidComposition.androidsdk;
in {
  home.packages = with pkgs; [ flutter androidSdk ];
  home.sessionVariables = {
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
  };
}
