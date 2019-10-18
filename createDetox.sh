# Remove unnecessary files

rm -f ./.buckconfig
rm -f ./.eslintrc.js
rm -f ./.flowconfig
rm -f ./.prettierrc.js
rm -f ./.watchmanconfig
rm -f ./__tests__/App-test.js

# Constants / Variables

PACKAGE_NAME=$(cat ./android/app/src/main/AndroidManifest.xml | gawk 'match($0, /package="(.*)"/, a) {print a[1]}')

DETOX_DIR="./android/app/src/androidTest/java"
DETOX_FILE="DetoxTest.java"

ANDROID_GRADLE="./android/build.gradle"

BUILD_GRADLE="./android/app/build.gradle"
BUILD_GRADLE_DETOX_1="\\\t\\ttestBuildType System.getProperty('testBuildType', 'debug')\n\\t\\ttestInstrumentationRunner 'androidx.test.runner.AndroidJUnitRunner'"
BUILD_GRADLE_DETOX_2="\\\tandroidTestImplementation('com.wix:detox:+') { transitive = true }\n\\tandroidTestImplementation 'junit:junit:4.12'"
BUILD_GRADLE_CONFIG="\\\t\\tconfigurations.all{resolutionStrategy{force'androidx.annotation:annotation:1.0.0'}}"

# Load package name from regexed Manifest

for i in $(echo $PACKAGE_NAME | tr "." "\n")
do
    DETOX_DIR="$DETOX_DIR/$i"
done

mkdir -p "$DETOX_DIR"

# android/build.gradle

sed -i "s/minSdkVersion = 16/minSdkVersion = 18/g" "$ANDROID_GRADLE" 
sed -i "/ext {/a \\\t\\tkotlinVersion = \"1.3.10\"" "$ANDROID_GRADLE" 
sed -i "/dependencies {/a \\\t\\tclasspath \"org.jetbrains.kotlin:kotlin-gradle-plugin:\$kotlinVersion\"" "$ANDROID_GRADLE" 
sed -i "/mavenLocal()/a \\\t\\tmaven{url\"\$rootDir/../node_modules/detox/Detox-android\"}" "$ANDROID_GRADLE" 

# android/app/build.gradle

sed -i "/versionName\s\".\{3,5\}\"/a $BUILD_GRADLE_DETOX_1" "$BUILD_GRADLE"
sed -i "/dependencies {/i $BUILD_GRADLE_CONFIG\n" "$BUILD_GRADLE"
sed -i "s/enableHermes: false/enableHermes: true/g" "$BUILD_GRADLE"
sed -i "/dependencies {/a $BUILD_GRADLE_DETOX_2" "$BUILD_GRADLE"

LINE_1="package $PACKAGE_NAME;import com.wix.detox.Detox;import org.junit.Rule;import org.junit.Test;import org.junit.runner.RunWith;import androidx.test.ext.junit.runners.AndroidJUnit4;import androidx.test.filters.LargeTest;import androidx.test.rule.ActivityTestRule;@RunWith(AndroidJUnit4.class)@LargeTest"
LINE_2="public class DetoxTest{@Rule"
LINE_3="public ActivityTestRule<MainActivity>mActivityRule=new ActivityTestRule<>(MainActivity.class,false,false);@Test"
LINE_4="public void runDetoxTests(){Detox.runTests(mActivityRule);}}"

rm -f "$DETOX_DIR/$DETOX_FILE"
touch "$DETOX_DIR/$DETOX_FILE"

echo "$LINE_1" >> "$DETOX_DIR/$DETOX_FILE"
echo "$LINE_2" >> "$DETOX_DIR/$DETOX_FILE"
echo "$LINE_3" >> "$DETOX_DIR/$DETOX_FILE"
echo "$LINE_4" >> "$DETOX_DIR/$DETOX_FILE"

mkdir -p "./android/app/src/main/assets"
react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res