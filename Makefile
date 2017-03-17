TARGET_EXEC ?= cryptotrade

CHPL = chpl

BUILD_DIR ?= ./build
SRC_DIRS ?= ./src

SRCS := $(shell find $(SRC_DIRS) -name *.chpl)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CHPLFLAGS ?= $(INC_FLAGS)

$(BUILD_DIR)/$(TARGET_EXEC):
	$(MKDIR_P) $(BUILD_DIR)
	$(CHPL) $(SRCS) -o $(BUILD_DIR)/$(TARGET_EXEC) $(CHPLFLAGS) $(LDFLAGS)

.PHONY: clean

clean:
	$(RM) -rf $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
