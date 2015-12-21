ifeq ($(call my-dir),$(call project-path-for,qcom-audio))

ifneq ($(filter msm8660,$(TARGET_BOARD_PLATFORM)),)

MY_LOCAL_PATH := $(call my-dir)

include $(call all-subdir-makefiles)

endif

endif
