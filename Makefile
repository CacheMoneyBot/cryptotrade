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

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CHPLFLAGS ?= $(INC_FLAGS)

clean:
	$(RM) -rf $(BUILD_DIR)

cryptotrade:
	$(MKDIR_P) $(BUILD_DIR)
	$(CHPL) $(SRCS) -o $(BUILD_DIR)/$(TARGET_EXEC) $(CHPLFLAGS) $(LDFLAGS)

docs:
	$(MKDIR_P) $(DOCS_DIR)
	chpldoc $(SRCS)

test:
	$(MKDIR_P) $(BUILD_DIR)/test
	$(CHPL) $(TEST_SRCS) -o $(BUILD_DIR)/test/$(TARGET_TEST_EXEC) $(CHPLFLAGS) $(LDFLAGS)

.PHONY: clean, cryptotrade, docs, test

-include $(DEPS)

MKDIR_P ?= mkdir -p
