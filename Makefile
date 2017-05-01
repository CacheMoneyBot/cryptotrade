TARGET_EXEC ?= cryptotrade

CHPL = chpl

BUILD_DIR ?= ./build
DOCS_DIR ?= ./docs
SRC_DIRS ?= ./src

SRCS := $(shell find $(SRC_DIRS) -name *.chpl)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CHPLFLAGS ?= $(INC_FLAGS)

cryptotrade:
	$(MKDIR_P) $(BUILD_DIR)
	$(CHPL) $(SRCS) -o $(BUILD_DIR)/$(TARGET_EXEC) $(CHPLFLAGS) $(LDFLAGS)

clean:
	$(RM) -rf $(BUILD_DIR)

docs:
	$(MKDIR_P) $(DOCS_DIR)
	chpldoc $(SRCS)

.PHONY: cryptotrade, clean, docs

-include $(DEPS)

MKDIR_P ?= mkdir -p
