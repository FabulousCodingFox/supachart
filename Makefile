CHART_NAME := supachart
CHART_DIR := src/$(CHART_NAME)
BUILD_DIR := build
REPO_URL := https://fabulouscodingfox.github.com/supachart/build/

.PHONY: package index release

package:
	mkdir -p $(BUILD_DIR)
	helm package $(CHART_DIR) --destination $(BUILD_DIR)

index: package
	helm repo index $(BUILD_DIR) --url $(REPO_URL)
	mv $(BUILD_DIR)/index.yaml ./index.yaml

release: index
