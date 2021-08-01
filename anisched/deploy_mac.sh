echo "Building..."
flutter clean && flutter build macos --release --pub --build-name=$(git describe --tags --abbrev=0) --build-number $(git rev-list --count $(git describe --tags --abbrev=0))

echo "Creating DMG..."
create-dmg --identity="Apple Development: qkdxorjs1002@naver.com (6CAP6ZVWNS)" --overwrite ./build/macos/Build/Products/Release/AniSched.app ./build/macos/Build/Products/Release

echo "Done."
open ./build/macos/Build/Products/Release