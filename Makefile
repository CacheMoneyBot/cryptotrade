TARGET_EXEC      ?= cryptotrade
TARGET_TEST_EXEC ?= cryptotradetest

CHPL = chpl

BUILD_DIR ?= ./build
DOCS_DIR  ?= ./docs
SRC_DIRS  ?= ./src

SRCS 	  := $(shell find $(SRC_DIRS) -path $(SRC_DIRS)/test -prune -o -name *.chpl | grep -v $(SRC_DIRS)/test)
TEST_SRCS := $(shell find $(SRC_DIRS)/test -name *.chpl)
OBJS      := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS      := $(OBJS:.o=.d)

INC_DIRS  := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CHPLFLAGS ?= $(INC_FLAGS)

MKDIR_P ?= mkdir -p

cryptotrade: force
	$(MKDIR_P) $(BUILD_DIR)
	$(CHPL) $(SRCS) -o $(BUILD_DIR)/$(TARGET_EXEC) $(CHPLFLAGS) $(LDFLAGS)

clean: force
	$(RM) -rf $(BUILD_DIR)

docs: force
	$(MKDIR_P) $(DOCS_DIR)
	chpldoc $(SRCS)

test: force
	cd ./src/test && ./start_tests.sh

force:

.PHONY: clean, cryptotrade, docs, force, test

-include $(DEPS)
