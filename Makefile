JCC = javac
JVM = java

SRC_DIR = src
BIN_DIR = bin

ARGS ?=

JFLAGS = -d $(BIN_DIR) -sourcepath $(SRC_DIR)

PROJECTS := $(notdir $(wildcard $(SRC_DIR)/*))

define PROJECT_RULES
$(1)_SRCS := $(wildcard $(SRC_DIR)/$(1)/*.java)
$(1)_CLASSES := $$(patsubst $(SRC_DIR)/%.java,$(BIN_DIR)/%.class,$$($(1)_SRCS))

.PHONY: build-$(1)
build-$(1): $$($(1)_CLASSES)
	@if [ -z "$$?" ]; then \
		echo "[BUILD] Nothing to be done."; \
	fi

.PHONY: run-$(1)
run-$(1): build-$(1)
	@$(JVM) -cp $(BIN_DIR) $(1).Main $(ARGS)

endef

$(foreach proj,$(PROJECTS),$(eval $(call PROJECT_RULES,$(proj))))

$(BIN_DIR)/%.class: $(SRC_DIR)/%.java
	@mkdir -p $(dir $@)
	@echo "[BUILD] $<"
	@$(JCC) $(JFLAGS) $<

.PHONY: clean
clean:
	rm -rf $(BIN_DIR)/*

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [target] [ARGS=\"...\"]"
	@echo ""
	@echo "Available targets:"
	@echo "  make build-<name>    Compile project"
	@echo "  make run-<name>      Run project"
	@echo "  make clean           Clean the bin/"
	@echo ""
	@echo "Available projects: $(PROJECTS)"
	@echo ""

