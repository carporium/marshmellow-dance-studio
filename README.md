# Marshmellow Dance Studio

Godot 4 vertical slice for the child-friendly, offline dance-studio game.

## Current playable slice

- Studio name and theme selection with local autosave.
- Three named students, seven disciplines, practice, tuition and skill progression.
- Eight-count choreography editor with eight labelled demo moves, four formations, replay screen and a two-minute timeline target.
- Competition scoring, prize currency and visible Company unlock.
- Local Abi feedback form with emoji-style rating and clipboard sharing for a parent.
- Android debug APK workflow at `.github/workflows/android.yml`.

The demo moves are labelled placeholders for the future authentic animation library. The full 3D character rigs, animated clips, music, touch-drag formation editor and 448-move production library are not yet implemented.

## Run locally

Install Godot 4.4.1, open the repository, and run `main.tscn`. The game uses no network services and stores progress in `user://studio.json`.

## Android build

GitHub Actions installs Godot 4.4.1, Java 17 and the Android SDK, validates the project, exports a debug APK, and uploads it as the `marshmellow-dance-studio-debug-apk` artifact. Download the artifact from a successful workflow run, unzip it, enable installation from the trusted file source on the test Pixel, and install the APK. No account or internet connection is required after installation.