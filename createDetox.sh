PACKAGE_NAME=$(cat ./android/app/src/main/AndroidManifest.xml | gawk 'match($0, /package="(.*)"/, a) {print a[1]}')
DETOX_DIR="./android/app/src/androidTest/java"
DETOX_FILE="DetoxTest1.java"
for i in $(echo $PACKAGE_NAME | tr "." "\n")
do
    DETOX_DIR="$DETOX_DIR/$i"
done

mkdir -p "$DETOX_DIR"

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