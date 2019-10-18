import "react-native";
import React from "react";
import App from "../App";

import { render, fireEvent } from "react-native-testing-library";

let app;

beforeEach(() => {
    app = render(<App />);
});

describe("Testing App Rendering", () => {
    test("Initially no text is rendered", () => {
        expect(() => app.getByText("Hello World")).toThrow(`No instances found`);
    });

    test("Clicking button renders text", () => {
        expect(() => app.getByText("Hello World")).toThrow(`No instances found`);
        // Click button
        fireEvent.press(app.getByText("Click Me"));
        // Text is now rendered
        expect(() => app.getByText("Hello World")).not.toThrow();
    });
});
