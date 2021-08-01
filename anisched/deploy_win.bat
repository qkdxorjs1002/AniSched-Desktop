echo "Versioning..."
powershell "(Get-Content pubspec.yaml) -replace '(version: \d.\d.\d\+\d.*)', ('version: ' + $(git describe --tags --abbrev=0) + '+' + $(git rev-list --count $(git describe --tags --abbrev=0))) | Out-File -Encoding 'UTF8' pubspec.yaml"
powershell "(Get-Content pubspec.yaml) -replace '(msix_version: \d.\d.\d.\d)', ('msix_version: ' + $(git describe --tags --abbrev=0) + '.0') | Out-File -Encoding 'UTF8' pubspec.yaml"

echo "Building..."
flutter clean && flutter build windows --release --pub

echo "Creating MSIX..."
flutter pub run msix:create --store

echo "Done."