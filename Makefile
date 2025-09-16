.PHONY: all build-% run-% clean

SRC_DIR   := src
BIN_DIR   := bin

SRCS      := $(wildcard $(SRC_DIR)/**/*.java)
CLSS      := $(patsubst $(SRC_DIR)/%.java,$(BIN_DIR)/%.class,$(SRCS))

JC        := javac
JAVA      := java
JCFLAGS   := -d $(BIN_DIR)

all: $(CLSS)

$(BIN_DIR)/%.class: $(SRC_DIR)/%.java
	@echo "[BUILD] $<"
	@mkdir -p $(dir $@)
	$(JC) $(JCFLAGS) $<

build-%:
	@files="$$(find $(SRC_DIR)/$* -name '*.java')"; \
	if [ -z "$$files" ]; then \
	  echo "[ERROR] No sources for $*."; \
	  exit 1; \
	fi; \
	classes="$$(echo "$$files" | sed "s|^$(SRC_DIR)|$(BIN_DIR)|;s|\.java$$|.class|")"; \
	if $(MAKE) -s $$classes; then \
	  if [ "$(MAKECMDGOALS)" = "build-$*" ]; then \
	    echo "[BUILD] Nothing to be done."; \
	  fi; \
	else \
	  $(MAKE) -s $$classes; \
	fi

run-%: build-%
	@$(JAVA) -cp $(BIN_DIR) $*.Main

clean:
	@rm -rf $(BIN_DIR)/*

