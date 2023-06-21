create:
	fvm flutter create --project-name=$(name) --org=com.$(org) --platforms=android,ios -e .
run:
	fvm flutter run
get:
	fvm flutter pub get
dev:
	fvm flutter run --flavor dev lib/main_dev.dart
prod:
	fvm flutter run --flavor prod lib/main_prod.dart
listSimu:
	xcrun simctl list	 
onSimu:
	open -a Simulator --args -CurrentDeviceUDID $(UDID)
