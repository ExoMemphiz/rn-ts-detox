describe("Example", () => {
    beforeEach(done => {
        device.reloadReactNative().then(() => {
            setTimeout(done, 500);
        });
    });

    test("Hello World should not be visible initially", () => {
        const ele = element(by.text("Hello World"));
        expect(ele).toNotExist();
    });

    test("ToggleText button should be visible", () => {
        const ele = element(by.id("toggleText"));
        expect(ele).toBeVisible();
    });

    test("Hello World should be visible after click", async () => {
        const button = await element(by.id("toggleText"));
        await button.tap();
        const text = await element(by.text("Hello World"));
        await expect(text).toExist();
    });
});
