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
	$(MAKE) -s $$classes || exit $$?; \
	if [ "$(MAKECMDGOALS)" = "build-$*" ]; then \
	  up_to_date=1; \
	  for f in $$classes; do \
	    if [ ! -f $$f ]; then up_to_date=0; fi; \
	  done; \
	  if [ $$up_to_date -eq 1 ]; then \
	    echo "[BUILD] Nothing to be done."; \
	  fi; \
	fi

run-%: build-%
	@$(JAVA) -cp $(BIN_DIR) $*.Main $(ARGS)

clean:
	@rm -rf $(BIN_DIR)/*

