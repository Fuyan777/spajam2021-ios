PRODUCT_NAME := spajam-ios

.PHONY: install
install:
		$(make) bundle_install
		$(make) mint-bootstrap
		$(make) setup
		$(make) open

.PHONY: setup
setup:
		mint run xcodegen
		bundle exec pod install
		make open

.PHONY: bundle_install
bundle_install:
		bundle install

.PHONY: mint-bootstrap
mint-bootstrap: # Install Mint dependencies
		mint bootstrap

.PHONY: open
open:
		open ./${PRODUCT_NAME}.xcworkspace

.PHONY: clean
clean: # Delete cache
		rm -rf ~/Library/Caches/com.apple.dt.Xcode/
		rm -rf ~/Library/Developer/Xcode/DerivedData
		xcodebuild -alltargets clean