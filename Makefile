.PHONY: all run clean

SRC_DIR := src
BIN_DIR := bin

SRCS    := $(wildcard $(SRC_DIR)/**/*.java)
CLSS    := $(patsubst $(SRC_DIR)/%.java,$(BIN_DIR)/%.class,$(SRCS))

JC      := javac
JAVA    := java
JCFLAGS := -d $(BIN_DIR)

all: $(CLSS)

$(BIN_DIR)/%.class: $(SRC_DIR)/%.java
	@echo "[BUILD] $<"
	@mkdir -p $(dir $@)
	$(JC) $(JCFLAGS) $<

run-%: all
	@$(JAVA) -cp $(BIN_DIR) $*.Main

clean:
	@rm -rf $(BIN_DIR)/*

