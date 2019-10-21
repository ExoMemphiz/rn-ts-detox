# React Native TS Detox Boilerplate

## Info

This is a boiletplate project for quickly setting up a React Native v.0.60+ app that has good testing practices, and uses Typescript.

## Contains

-   Typescript
-   Detox Setup
-   React-Native-Testing-Library Setup

## Needed Changes

When renaming the project, follow these steps:

1. Rename the package.json "name" property to whatever project name you want
2. Delete android and ios folders.
3. run `react-native upgrade --legacy true`
4. Answer no to all the questions
5. run `sh createDetox.sh` from the root folder
