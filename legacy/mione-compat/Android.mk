LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := libaudiohw_legacy_mione
LOCAL_VENDOR_MODULE := true
LOCAL_SRC_FILES := AudioHardwareInterface.cpp
LOCAL_STATIC_LIBRARIES := libmedia_helper
LOCAL_HEADER_LIBRARIES := libaudioclient_headers libbase_headers libhardware_legacy_headers
LOCAL_CFLAGS := -Wall -Werror -Wno-unused-parameter -Wno-unused-variable -Wno-gnu-designator
include $(BUILD_STATIC_LIBRARY)
