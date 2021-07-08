#1 Disable implicit rules
.SUFFIXES:

.PHONY: protos

# You can install the dart protoc support by running 'dart pub global activate protoc_plugin'
protos: lib/model/protos_shared/vpn.pb.dart

lib/model/protos_shared/vpn.pb.dart: protos_shared/*.proto
	@mkdir -p lib/model && protoc --dart_out=./lib/model --plugin=protoc-gen-dart=$$HOME/.pub-cache/bin/protoc-gen-dart protos_shared/*.proto

GO_VERSION := 1.16

TAG ?= $$VERSION
INSTALLER_NAME ?= lantern-installer
CHANGELOG_NAME ?= CHANGELOG.md
CHANGELOG_MIN_VERSION ?= 5.0.0

get-command = $(shell which="$$(which $(1) 2> /dev/null)" && if [[ ! -z "$$which" ]]; then printf %q "$$which"; fi)

GO        := $(call get-command,go)
NODE      := $(call get-command,node)
NPM       := $(call get-command,npm)
GULP      := $(call get-command,gulp)
AWSCLI    := $(call get-command,aws)
S3CMD     := $(call get-command,s3cmd)
CHANGE    := $(call get-command,git-chglog)
PIP       := $(call get-command,pip)
WGET      := $(call get-command,wget)
APPDMG    := $(call get-command,appdmg)
MAGICK    := $(call get-command,magick)
BUNDLER   := $(call get-command,bundle)
ADB       := $(call get-command,adb)
OPENSSL   := $(call get-command,openssl)
GMSAAS    := $(call get-command,gmsaas)
SENTRY    := $(call get-command,sentry-cli)

GIT_REVISION_SHORTCODE := $(shell git rev-parse --short HEAD)
GIT_REVISION := $(shell git describe --abbrev=0 --tags --exact-match 2> /dev/null || git rev-parse --short HEAD)
GIT_REVISION_DATE := $(shell git show -s --format=%ci $(GIT_REVISION_SHORTCODE))

REVISION_DATE := $(shell date -u -j -f "%F %T %z" "$(GIT_REVISION_DATE)" +"%Y%m%d.%H%M%S" 2>/dev/null || date -u -d "$(GIT_REVISION_DATE)" +"%Y%m%d.%H%M%S")
BUILD_DATE := $(shell date -u +%Y%m%d.%H%M%S)
# We explicitly set a build-id for use in the liblantern ELF binary so that Sentry and Crashlytics can successfully associate uploaded debug symbols with corresponding errors/crashes
BUILD_ID := 0x$(shell echo '$(REVISION_DATE)-$(BUILD_DATE)' | xxd -c 256 -ps)

UPDATE_SERVER_URL ?=
LDFLAGS_NOSTRIP := -extldflags '-Wl,--build-id=$(BUILD_ID)' -X github.com/getlantern/flashlight/common.RevisionDate=$(REVISION_DATE) -X github.com/getlantern/flashlight/common.BuildDate=$(BUILD_DATE) -X github.com/getlantern/flashlight/config.UpdateServerURL=$(UPDATE_SERVER_URL)
LDFLAGS := $(LDFLAGS_NOSTRIP) -s

BINARIES_PATH ?= ../lantern-binaries
BRANCH ?= master

BETA_BASE_NAME ?= $(INSTALLER_NAME)-preview
PROD_BASE_NAME ?= $(INSTALLER_NAME)

S3_BUCKET ?= lantern
FORCE_PLAY_VERSION ?= false
DEBUG_VERSION ?= $(GIT_REVISION)

# By default, build APKs containing support for ARM only 32 bit. Since we're using multi-architecture
# app bundles for play store, we no longer need to include 64 bit in our APKs that we distribute.
ANDROID_ARCH ?= arm32

ifeq ($(ANDROID_ARCH), x86)
  ANDROID_ARCH_JAVA := x86
  ANDROID_ARCH_GOMOBILE := android/386
  APK_QUALIFIER := -x86
else ifeq ($(ANDROID_ARCH), amd64)
  ANDROID_ARCH_JAVA := x86_64
  ANDROID_ARCH_GOMOBILE := android/amd64
  APK_QUALIFIER := -x86_64
else ifeq ($(ANDROID_ARCH), 386)
  ANDROID_ARCH_JAVA := x86 x86_64
  ANDROID_ARCH_GOMOBILE := android/386,android/amd64
  APK_QUALIFIER :=
else ifeq ($(ANDROID_ARCH), arm32)
  ANDROID_ARCH_JAVA := armeabi-v7a
  ANDROID_ARCH_GOMOBILE := android/arm
  APK_QUALIFIER := -armeabi-v7a
else ifeq ($(ANDROID_ARCH), arm64)
  ANDROID_ARCH_JAVA := arm64-v8a
  ANDROID_ARCH_GOMOBILE := android/arm64
  APK_QUALIFIER := -arm64-v8a
else ifeq ($(ANDROID_ARCH), arm)
  ANDROID_ARCH_JAVA := armeabi-v7a arm64-v8a
  ANDROID_ARCH_GOMOBILE := android/arm,android/arm64
  APK_QUALIFIER :=
else ifeq ($(ANDROID_ARCH), all)
  ANDROID_ARCH_JAVA := armeabi-v7a arm64-v8a x86 x86_64
  ANDROID_ARCH_GOMOBILE := android/arm,android/arm64,android/386,android/amd64
  APK_QUALIFIER :=
else
  $(error unsupported ANDROID_ARCH "$(ANDROID_ARCH)")
endif

ANDROID_LIB_PKG := github.com/getlantern/android-lantern/internalsdk
ANDROID_LIB_BASE := liblantern

MOBILE_APPID := org.getlantern.lantern

ANDROID_LIB := $(ANDROID_LIB_BASE)-$(ANDROID_ARCH).aar

BASE_MOBILE_DIR ?= .
MOBILE_DIR ?= $(BASE_MOBILE_DIR)/android
GRADLE    := $(MOBILE_DIR)/gradlew
MOBILE_LIBS := $(MOBILE_DIR)/app/libs
MOBILE_ARCHS := x86 x86_64 armeabi-v7a arm64-v8a
MOBILE_ANDROID_LIB := $(MOBILE_LIBS)/$(ANDROID_LIB)
MOBILE_ANDROID_DEBUG := $(BASE_MOBILE_DIR)/build/app/outputs/apk/prod/debug/app-prod$(APK_QUALIFIER)-debug.apk
MOBILE_ANDROID_RELEASE := $(BASE_MOBILE_DIR)/build/app/outputs/apk/prod/release/app-prod$(APK_QUALIFIER)-release.apk
MOBILE_ANDROID_BUNDLE := $(BASE_MOBILE_DIR)/build/app/outputs/bundle/prodRelease/app-prod$(APK_QUALIFIER)-release.aab
MOBILE_RELEASE_APK := $(INSTALLER_NAME)-$(ANDROID_ARCH).apk
MOBILE_DEBUG_APK := $(INSTALLER_NAME)-$(ANDROID_ARCH)-debug.apk
MOBILE_BUNDLE := lantern-$(ANDROID_ARCH).aab
MOBILE_TEST_APK := $(BASE_MOBILE_DIR)/build/app/outputs/apk/androidTest/autoTest/debug/app-autoTest-debug-androidTest.apk
MOBILE_TESTS_APK := $(BASE_MOBILE_DIR)/build/app/outputs/apk/autoTest/debug/app-autoTest-debug.apk
ANDROID_KEYSTORE := $(MOBILE_DIR)/app/keystore.release.jks

BUILD_TAGS ?=
BUILD_TAGS += ' lantern'

GO_SOURCES := go.mod go.sum $(shell find . -type f -name "*.go" | grep -v vendor)
GO_VENDOR_SOURCES := vendor $(shell test -d vendor && find vendor -type f)
MOBILE_SOURCES := $(shell find $(BASE_MOBILE_DIR) -type f -not -path "*/build/*" -not -path "*/.gradle/*" -not -path "*/.idea/*" -not -path "*/libs/$(ANDROID_LIB_BASE)*" -not -iname ".*" -not -iname "*.apk")

.PHONY: dumpvars packages vendor android-lib android-debug do-android-release android-release do-android-bundle android-bundle android-debug-install android-release-install android-test android-cloud-test package-android

# dumpvars prints out all variables defined in the Makefile, useful for debugging environment
dumpvars:
	$(foreach v,                                        \
		$(filter-out $(VARS_OLD) VARS_OLD,$(.VARIABLES)), \
		$(info $(v) = $($(v))))

define build-tags
	BUILD_TAGS="$(BUILD_TAGS)" && \
	EXTRA_LDFLAGS="" && \
	if [[ ! -z "$$VERSION" ]]; then \
		EXTRA_LDFLAGS="-X github.com/getlantern/flashlight/common.CompileTimePackageVersion=$$VERSION"; \
	else \
		echo "** VERSION was not set, using default version. This is OK while in development."; \
	fi && \
	if [[ ! -z "$$HEADLESS" ]]; then \
		BUILD_TAGS="$$BUILD_TAGS headless"; \
	fi && \
	if [[ ! -z "$$STAGING" ]]; then \
		BUILD_TAGS="$$BUILD_TAGS staging"; \
		EXTRA_LDFLAGS="$$EXTRA_LDFLAGS -X github.com/getlantern/flashlight/common.StagingMode=$$STAGING"; \
	fi && \
	if [[ ! -z "$$REPLICA" ]]; then \
		EXTRA_LDFLAGS="$$EXTRA_LDFLAGS -X github.com/getlantern/flashlight/config.EnableReplicaFeatures=true"; \
		EXTRA_LDFLAGS="$$EXTRA_LDFLAGS -X github.com/getlantern/flashlight/common.GlobalURL=https://globalconfig.flashlightproxy.com/global-replica.yaml.gz"; \
	else \
		echo "**  Not forcing replica build"; \
	fi && \
	if [[ ! -z "$$YINBI" ]]; then \
		EXTRA_LDFLAGS="$$EXTRA_LDFLAGS -X github.com/getlantern/flashlight/config.EnableYinbiFeatures=true"; \
	fi && \
	BUILD_TAGS=$$(echo $$BUILD_TAGS | xargs) && echo "Build tags: $$BUILD_TAGS" && \
	EXTRA_LDFLAGS=$$(echo $$EXTRA_LDFLAGS | xargs) && echo "Extra ldflags: $$EXTRA_LDFLAGS"
endef

$(GO_VENDOR_SOURCES): go.mod go.sum
	@echo "Updating vendored libs" && \
	git config --global url."https://71cee071ea22b7ffb10f68fa330d1130133bbfbd:x-oauth-basic@github.com/".insteadOf "https://github.com/" && \
	go mod vendor

vendor: $(GO_VENDOR_SOURCES)

.PHONY: tag
tag: require-version
	@(git diff-index --quiet HEAD -- || (echo "Attempted to tag dirty working tree" && exit 1)) && \
	git pull && \
	echo "Tagging..." && \
	git tag -a "$(TAG)" -f --annotate -m"Tagged $(TAG)" && \
	git push --force-with-lease origin $(TAG) && \
	echo "Updating $(CHANGELOG_NAME)" && \
	$(CHANGE) --output $(CHANGELOG_NAME) $(CHANGELOG_MIN_VERSION)..$(TAG) && \
	git add $(CHANGELOG_NAME) && \
	git commit -m "Updated changelog for $$VERSION" && \
	git push

define check-go-version
    if [ -z '${IGNORE_GO_VERSION}' ] && go version | grep -q -v $(GO_VERSION); then \
		echo "go $(GO_VERSION) is required." && exit 1; \
	fi
endef

guard-%:
	 @ if [ -z '${${*}}' ]; then echo 'Environment variable $* not set' && exit 1; fi

.PHONY: require-app
require-app: guard-APP

.PHONY: require-version
require-version: guard-VERSION

.PHONY: require-secrets-dir
require-secrets-dir: guard-SECRETS_DIR

.PHONY: require-release-track
require-release-track: guard-APK_RELEASE_TRACK

.PHONY: require-android-keystore
require-android-keystore:
	@ if [ ! -f '${ANDROID_KEYSTORE}' ]; then echo 'Android keystore not found' && exit 1; fi

.PHONY: require-lantern-binaries
require-lantern-binaries:
	@if [[ ! -d "$(BINARIES_PATH)" ]]; then \
		echo "Missing binaries repository directory at $(BINARIES_PATH) (such as /Users/home/go/getlantern/lantern-binaries). Set it with BINARIES_PATH=\"/path/to/repository\" make ..." && \
		exit 1; \
	fi

$(GO):
	@echo 'Missing "$(GO)" command.'; exit 1;

.PHONY: require-awscli
require-awscli:
	@if [[ -z "$(AWSCLI)" ]]; then echo 'Missing "aws" command. Use "brew install awscli" or see https://aws.amazon.com/cli/'; exit 1; fi && \
	if [[ -z "$$($(AWSCLI) configure list | grep _key)" ]]; then echo 'Run "aws configure" first'; exit 1; fi

.PHONY: require-s3cmd
require-s3cmd:
	@if [[ -z "$(S3CMD)" ]]; then echo 'Missing "s3cmd" command. Use "brew install s3cmd" or see https://github.com/s3tools/s3cmd/blob/master/INSTALL'; exit 1; fi

.PHONY: require-changelog
require-changelog:
	@if [[ -z "$(CHANGE)" ]]; then echo 'Missing "git-chglog" command. See https://github.com/git-chglog/git-chglog'; exit 1; fi

.PHONY: require-pip
require-pip:
	@if [[ -z "$(PIP)" ]]; then echo 'Missing "pip" command. Use "brew install pip"'; exit 1; fi

.PHONY: require-wget
require-wget:
	@if [[ -z "$(WGET)" ]]; then echo 'Missing "wget" command.'; exit 1; fi

.PHONY: require-magick
require-magick:
	@if [[ -z "$(MAGICK)" ]]; then echo 'Missing "magick" command. Try brew install imagemagick.'; exit 1; fi

.PHONY: require-sentry
require-sentry:
	@if [[ -z "$(SENTRY)" ]]; then echo 'Missing "sentry-cli" command. See sentry.io for installation instructions.'; exit 1; fi

release-qa: require-version require-s3cmd require-changelog
	@BASE_NAME="$(INSTALLER_NAME)-internal" && \
	VERSION_FILE_NAME="version-qa.txt" && \
	rm -f $$BASE_NAME* && \
	cp $(INSTALLER_NAME)-arm32.apk $$BASE_NAME.apk && \
	cp lantern-all.aab $$BASE_NAME.aab && \
	echo "Uploading installer packages and shasums" && \
	for NAME in $$(ls -1 $$BASE_NAME*.*); do \
		shasum -a 256 $$NAME | cut -d " " -f 1 > $$NAME.sha256 && \
		echo "Uploading SHA-256 `cat $$NAME.sha256`" && \
		$(S3CMD) put -P $$NAME.sha256 s3://$(S3_BUCKET) && \
		echo "Uploading $$NAME to S3" && \
		$(S3CMD) put -P $$NAME s3://$(S3_BUCKET) && \
		SUFFIX=$$(echo "$$NAME" | sed s/$$BASE_NAME//g) && \
		VERSIONED=$(INSTALLER_NAME)-$$VERSION$$SUFFIX && \
		echo "Copying $$VERSIONED" && \
		$(S3CMD) cp s3://$(S3_BUCKET)/$$NAME s3://$(S3_BUCKET)/$$VERSIONED && \
		echo "Copied $$VERSIONED ... setting acl to public" && \
		$(S3CMD) setacl s3://$(S3_BUCKET)/$$VERSIONED --acl-public; \
	done && \
	echo "Setting content types for installer packages" && \
	for NAME in $$BASE_NAME.apk $(INSTALLER_NAME)-$$VERSION.apk $$BASE_NAME.aab ; do \
		$(S3CMD) modify --add-header='content-type':'application/vnd.android.package-archive' s3://$(S3_BUCKET)/$$NAME; \
	done && \
	echo $$VERSION > $$VERSION_FILE_NAME && \
	$(S3CMD) put -P $$VERSION_FILE_NAME s3://$(S3_BUCKET) && \
	echo "Wrote $$VERSION_FILE_NAME as $$(wget -qO - http://$(S3_BUCKET).s3.amazonaws.com/$$VERSION_FILE_NAME)" 

release-beta: require-s3cmd
	@BASE_NAME="$(INSTALLER_NAME)-internal" && \
	VERSION_FILE_NAME="version-beta.txt" && \
	cd $(BINARIES_PATH) && \
	git pull && \
	cd - && \
	for URL in $$($(S3CMD) ls s3://$(S3_BUCKET)/ | grep $$BASE_NAME | awk '{print $$4}'); do \
		NAME=$$(basename $$URL) && \
		BETA=$$(echo $$NAME | sed s/"$$BASE_NAME"/$(BETA_BASE_NAME)/) && \
		$(S3CMD) cp s3://$(S3_BUCKET)/$$NAME s3://$(S3_BUCKET)/$$BETA && \
		$(S3CMD) setacl s3://$(S3_BUCKET)/$$BETA --acl-public && \
		$(S3CMD) get --force s3://$(S3_BUCKET)/$$NAME $(BINARIES_PATH)/$$BETA; \
	done && \
	$(S3CMD) cp s3://$(S3_BUCKET)/version-qa.txt s3://$(S3_BUCKET)/$$VERSION_FILE_NAME && \
	$(S3CMD) setacl s3://$(S3_BUCKET)/$$VERSION_FILE_NAME --acl-public && \
	echo "$$VERSION_FILE_NAME is now set to $$(wget -qO - http://$(S3_BUCKET).s3.amazonaws.com/$$VERSION_FILE_NAME)" && \
	cd $(BINARIES_PATH) && \
	git add $(BETA_BASE_NAME)* && \
	(git commit -am "Latest beta binaries for $(CAPITALIZED_APP) released from QA." && git push origin $(BRANCH)) || true

release: require-version require-s3cmd require-wget require-lantern-binaries require-release-track release-s3-git-repos copy-beta-installers-to-mirrors invalidate-getlantern-dot-org upload-aab-to-play

release-s3-git-repos: require-version require-s3cmd require-wget require-lantern-binaries require-magick
	@TAG_COMMIT=$$(git rev-list --abbrev-commit -1 $(TAG)) && \
	if [[ -z "$$TAG_COMMIT" ]]; then \
		echo "Could not find given tag $(TAG)."; \
	fi && \
	PROD_BASE_NAME2="$(INSTALLER_NAME)-beta" && \
	VERSION_FILE_NAME="version.txt" && \
	for URL in $$($(S3CMD) ls s3://$(S3_BUCKET)/ | grep $(BETA_BASE_NAME) | awk '{print $$4}'); do \
		NAME=$$(basename $$URL) && \
		PROD=$$(echo $$NAME | sed s/"$(BETA_BASE_NAME)"/$(PROD_BASE_NAME)/) && \
		PROD2=$$(echo $$NAME | sed s/"$(BETA_BASE_NAME)"/$$PROD_BASE_NAME2/) && \
		$(S3CMD) cp s3://$(S3_BUCKET)/$$NAME s3://$(S3_BUCKET)/$$PROD && \
		$(S3CMD) setacl s3://$(S3_BUCKET)/$$PROD --acl-public && \
		$(S3CMD) cp s3://$(S3_BUCKET)/$$NAME s3://$(S3_BUCKET)/$$PROD2 && \
		$(S3CMD) setacl s3://$(S3_BUCKET)/$$PROD2 --acl-public && \
		echo "Downloading released binary to $(BINARIES_PATH)/$$PROD" && \
		$(S3CMD) get --force s3://$(S3_BUCKET)/$$PROD $(BINARIES_PATH)/$$PROD && \
		cp $(BINARIES_PATH)/$$PROD $(BINARIES_PATH)/$$PROD2; \
	done && \
	$(S3CMD) cp s3://$(S3_BUCKET)/version-beta.txt s3://$(S3_BUCKET)/$$VERSION_FILE_NAME && \
	$(S3CMD) setacl s3://$(S3_BUCKET)/$$VERSION_FILE_NAME --acl-public && \
	echo "$$VERSION_FILE_NAME is now set to $$(wget -qO - http://$(S3_BUCKET).s3.amazonaws.com/$$VERSION_FILE_NAME)" && \
	echo "Uploading released binaries to $(BINARIES_PATH)"
	@cd $(BINARIES_PATH) && \
	git checkout $(BRANCH) && \
	git pull && \
	git add $(PROD_BASE_NAME)* && \
	echo -n $$VERSION | $(MAGICK) -font Helvetica -pointsize 30 -size 68x24  label:@- -transparent white version.png && \
	(COMMIT_MESSAGE="Latest binaries for Lantern $$VERSION ($$TAG_COMMIT)." && \
	git add . && \
	git commit -m "$$COMMIT_MESSAGE" && \
	git push origin $(BRANCH) \
	) || true

copy-beta-installers-to-mirrors: require-secrets-dir
	@URLS="$$(make get-beta-installer-urls)" && \
	VERSION_FILE_NAME="version.txt" && \
	for BUCKET in $(shell cat "$(SECRETS_DIR)/website-mirrors.txt"); do \
		echo "Copying installers to mirror bucket $$BUCKET"; \
		for URL in $$URLS; do \
			PROD_NAME=$$(echo $$URL | sed s/$(BETA_BASE_NAME)/$(PROD_BASE_NAME)/) && \
			$(S3CMD) cp s3://$(S3_BUCKET)/$$URL s3://$$BUCKET/$$PROD_NAME && \
			$(S3CMD) setacl s3://$$BUCKET/$$PROD_NAME --acl-public; \
		done; \
		echo "Copying $$VERSION_FILE_NAME to $$BUCKET" && \
		$(S3CMD) cp s3://$(S3_BUCKET)/$$VERSION_FILE_NAME s3://$$BUCKET && \
		$(S3CMD) setacl s3://$$BUCKET/$$VERSION_FILE_NAME --acl-public; \
	done; \
	echo "Finished copying installers to mirrors"

get-beta-installer-urls: require-wget
	@URLS="" && \
	for URL in $$($(S3CMD) ls s3://$(S3_BUCKET)/ | grep $(BETA_BASE_NAME) | awk '{print $$4}'); do \
		NAME=$$(basename $$URL) && \
		URLS+=$$(echo " $$NAME"); \
	done && \
	echo "$$URLS" | xargs

invalidate-getlantern-dot-org: require-awscli
	@echo "Invalidating getlantern.org" && \
	$(AWSCLI) configure set preview.cloudfront true && \
	$(AWSCLI) cloudfront --output text create-invalidation --paths /$(INSTALLER_NAME)* /version*.txt --distribution-id E1UX00QZB0FGKH && \
	./set_latest_version.py "$$VERSION"

$(ANDROID_LIB): $(GO_SOURCES)
	$(call check-go-version) && \
	$(call build-tags) && \
	echo "Running gomobile with `which gomobile` version `gomobile version` ..." && \
	gomobile bind -target=$(ANDROID_ARCH_GOMOBILE) -tags='headless lantern' -o=$(ANDROID_LIB) -ldflags="$(LDFLAGS_NOSTRIP) $$EXTRA_LDFLAGS" $(ANDROID_LIB_PKG)

$(MOBILE_ANDROID_LIB): $(ANDROID_LIB)
	mkdir -p $(MOBILE_LIBS) && \
	cp $(ANDROID_LIB) $(MOBILE_ANDROID_LIB)

android-lib: $(MOBILE_ANDROID_LIB)

$(MOBILE_TEST_APK) $(MOBILE_TESTS_APK): $(MOBILE_SOURCES) $(MOBILE_ANDROID_LIB)
	@$(GRADLE) -PandroidArch=$(ANDROID_ARCH) -PandroidArchJava="$(ANDROID_ARCH_JAVA)" -b $(MOBILE_DIR)/app/build.gradle :app:assembleAutoTestDebug :app:assembleAutoTestDebugAndroidTest

do-android-debug: $(MOBILE_SOURCES) $(MOBILE_ANDROID_LIB) lib/model/protos_shared/vpn.pb.dart
	@ln -fs $(MOBILE_DIR)/gradle.properties . && \
	COUNTRY="$$COUNTRY" && \
	YINBI_ENABLED="$$YINBI_ENABLED" && \
	PAYMENT_PROVIDER="$$PAYMENT_PROVIDER" && \
	STAGING="$$STAGING" && \
	STICKY_CONFIG="$$STICKY_CONFIG" && \
	$(GRADLE) -PlanternVersion=$(DEBUG_VERSION) -PenableYinbi=$(YINBI_ENABLED) -PproServerUrl=$(PRO_SERVER_URL) -PpaymentProvider=$(PAYMENT_PROVIDER) -Pcountry=$(COUNTRY) -PplayVersion=$(FORCE_PLAY_VERSION) -PuseStaging=$(STAGING) -PstickyConfig=$(STICKY_CONFIG) -PlanternRevisionDate=$(REVISION_DATE) -PandroidArch=$(ANDROID_ARCH) -PandroidArchJava="$(ANDROID_ARCH_JAVA)" -b $(MOBILE_DIR)/app/build.gradle \
		assembleProdDebug

pubget:
	@cd $(BASE_MOBILE_DIR) && flutter pub get

$(MOBILE_DEBUG_APK): $(MOBILE_SOURCES) $(GO_SOURCES)
	@$(call check-go-version) && \
	make do-android-debug && \
	cp $(MOBILE_ANDROID_DEBUG) $(MOBILE_DEBUG_APK)

$(MOBILE_RELEASE_APK): $(MOBILE_SOURCES) $(GO_SOURCES) $(MOBILE_ANDROID_LIB) require-sentry
	@mkdir -p ~/.gradle && \
	cp gradle.properties.user ~/.gradle/gradle.properties && \
	ln -fs $(MOBILE_DIR)/gradle.properties . && \
	COUNTRY="$$COUNTRY" && \
	STAGING="$$STAGING" && \
	YINBI_ENABLED="$$YINBI_ENABLED" && \
	STICKY_CONFIG="$$STICKY_CONFIG" && \
	PAYMENT_PROVIDER="$$PAYMENT_PROVIDER" && \
	VERSION_CODE="$$VERSION_CODE" && \
	$(GRADLE) -PlanternVersion=$$VERSION -PlanternRevisionDate=$(REVISION_DATE) -PandroidArch=$(ANDROID_ARCH) -PandroidArchJava="$(ANDROID_ARCH_JAVA)" -PenableYinbi=$(YINBI_ENABLED) -PproServerUrl=$(PRO_SERVER_URL) -PpaymentProvider=$(PAYMENT_PROVIDER) -Pcountry=$(COUNTRY) -PplayVersion=$(FORCE_PLAY_VERSION) -PuseStaging=$(STAGING) -PstickyConfig=$(STICKY_CONFIG) -PversionCode=$(VERSION_CODE) -b $(MOBILE_DIR)/app/build.gradle \
		assembleProdRelease && \
	$(SENTRY) upload-dif --wait -o getlantern -p android build/app/intermediates/merged_native_libs/prodRelease/out/lib && \
	cp $(MOBILE_ANDROID_RELEASE) $(MOBILE_RELEASE_APK) && \
	cat $(MOBILE_RELEASE_APK) | bzip2 > lantern_update_android_arm.bz2

$(MOBILE_BUNDLE): $(MOBILE_SOURCES) $(GO_SOURCES) $(MOBILE_ANDROID_LIB) require-sentry
	@mkdir -p ~/.gradle && \
	cp gradle.properties.user ~/.gradle/gradle.properties && \
	ln -fs $(MOBILE_DIR)/gradle.properties . && \
	COUNTRY="$$COUNTRY" && \
	STAGING="$$STAGING" && \
	YINBI_ENABLED="$$YINBI_ENABLED" && \
	STICKY_CONFIG="$$STICKY_CONFIG" && \
	PAYMENT_PROVIDER="$$PAYMENT_PROVIDER" && \
	$(GRADLE) -PlanternVersion=$$VERSION -PlanternRevisionDate=$(REVISION_DATE) -PandroidArch=$(ANDROID_ARCH) -PandroidArchJava="$(ANDROID_ARCH_JAVA)" -PenableYinbi=$(YINBI_ENABLED) -PproServerUrl=$(PRO_SERVER_URL) -PpaymentProvider=$(PAYMENT_PROVIDER) -Pcountry=$(COUNTRY) -PplayVersion=true -PuseStaging=$(STAGING) -PstickyConfig=$(STICKY_CONFIG) -b $(MOBILE_DIR)/app/build.gradle \
		bundleRelease && \
	$(SENTRY) upload-dif --wait -o getlantern -p android build/app/intermediates/merged_native_libs/prodRelease/out/lib && \
	cp $(MOBILE_ANDROID_BUNDLE) $(MOBILE_BUNDLE)

android-pull-translations:
	@(cd $(MOBILE_DIR) && tx pull -af --minimum 100)

android-push-translations:
	@(cd $(MOBILE_DIR) && tx push --skip -l en_US -s)

android-debug: $(MOBILE_DEBUG_APK)

android-release: $(MOBILE_RELEASE_APK)

android-bundle: $(MOBILE_BUNDLE)

android-debug-install: $(MOBILE_DEBUG_APK)
	$(ADB) uninstall $(MOBILE_APPID) ; $(ADB) install -r $(MOBILE_DEBUG_APK)

android-release-install: $(MOBILE_RELEASE_APK)
	$(ADB) install -r $(MOBILE_RELEASE_APK)

package-android: require-version require-android-keystore
	@cp ~/.gradle/gradle.properties gradle.properties.user && \
	make pubget android-release && \
	ANDROID_ARCH=all make android-bundle && \
	echo "-> $(MOBILE_RELEASE_APK)"

upload-aab-to-play: require-release-track require-pip
	@echo "Uploading APK to Play store on $$APK_RELEASE_TRACK release track.." && \
	$(S3CMD) get --force s3://$(S3_BUCKET)/$(PROD_BASE_NAME).aab $(PROD_BASE_NAME).aab && \
	pip install --upgrade google-api-python-client && \
	python upload_apk.py "$$APK_RELEASE_TRACK" $(PROD_BASE_NAME).aab

changelog: require-version require-changelog require-app
	@TAG_COMMIT=$$(git rev-list --abbrev-commit -1 $(TAG)) && \
	if [[ -z "$$TAG_COMMIT" ]]; then \
		echo "Could not find given tag $(TAG)."; \
	fi && \
	cd  && \
	$(call changelog,flashlight)

clean:
	rm -f liblantern*.aar && \
	rm -f $(MOBILE_LIBS)/$(ANDROID_LIB_BASE)* && \
	rm -f $(MOBILE_ANDROID_LIB) && \
	rm -Rf app/build && \
	rm -Rf app/unstripped_libs && \
	rm -Rf *.aab && \
	rm -Rf *.apk
