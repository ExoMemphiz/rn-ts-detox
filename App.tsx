import React, { useState } from "react";
import { SafeAreaView, StyleSheet, View, Text, StatusBar, TouchableOpacity } from "react-native";

const App = () => {
    const [showText, setShowText] = useState(false);

    const hermes = typeof HermesInternal === "object" && HermesInternal !== null;

    function handleClick() {
        setShowText(!showText);
    }

    return (
        <>
            <StatusBar barStyle="dark-content" />
            <SafeAreaView style={{ flex: 1 }}>
                <View style={{ flex: 1 }}>
                    {!hermes ? (
                        <View style={styles.engine}>
                            <Text style={styles.text}>Engine: None</Text>
                        </View>
                    ) : (
                        <View style={styles.engine}>
                            <Text style={styles.text}>Engine: Hermes</Text>
                        </View>
                    )}
                </View>
                <View style={{ flex: 1 }}>{showText && <Text>Hello World</Text>}</View>
                <View style={{ flex: 1 }}>
                    <TouchableOpacity
                        testID={"toggleText"}
                        style={{ backgroundColor: "#333", alignItems: "center" }}
                        onPress={handleClick}
                    >
                        <Text style={{ color: "white" }}>Click Me</Text>
                    </TouchableOpacity>
                </View>
            </SafeAreaView>
        </>
    );
};

const styles = StyleSheet.create({
    engine: {
        flex: 1,
    },
    text: {
        color: "black",
    },
});

export default App;
