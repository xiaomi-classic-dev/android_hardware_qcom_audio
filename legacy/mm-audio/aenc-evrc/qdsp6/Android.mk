ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

# ---------------------------------------------------------------------------------
#                 Common definitons
# ---------------------------------------------------------------------------------

libOmxEvrcEnc-def := -g -O3
libOmxEvrcEnc-def += -DQC_MODIFIED
libOmxEvrcEnc-def += -D_ANDROID_
libOmxEvrcEnc-def += -D_ENABLE_QC_MSG_LOG_
libOmxEvrcEnc-def += -DVERBOSE
libOmxEvrcEnc-def += -D_DEBUG
ifeq ($(strip $(TARGET_USES_QCOM_MM_AUDIO)),true)
libOmxEvrcEnc-def += -DAUDIOV2
endif

# ---------------------------------------------------------------------------------
#             Make the Shared library (libOmxEvrcEnc)
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

libOmxEvrcEnc-inc       := $(LOCAL_PATH)/inc

LOCAL_MODULE            := libOmxEvrcEnc
LOCAL_VENDOR_MODULE := true
LOCAL_MODULE_TAGS       := optional
LOCAL_CFLAGS            := $(libOmxEvrcEnc-def)
# Keep existing CAF diagnostics visible under Pie's default -Werror.
LOCAL_CFLAGS += -Wno-error=format -Wno-error=format-extra-args \
                -Wno-error=reorder -Wno-error=null-conversion \
                -Wno-error=parentheses-equality
LOCAL_C_INCLUDES        := $(libOmxEvrcEnc-inc)
LOCAL_SHARED_LIBRARIES  := libutils liblog
LOCAL_HEADER_LIBRARIES  := media_headers

LOCAL_SRC_FILES         := src/aenc_svr.c
LOCAL_SRC_FILES         += src/omx_evrc_aenc.cpp

LOCAL_C_INCLUDES += 
LOCAL_ADDITIONAL_DEPENDENCIES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS += -idirafter $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
include $(BUILD_SHARED_LIBRARY)

# ---------------------------------------------------------------------------------
#             Make the apps-test (mm-aenc-omxevrc-test)
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)
LOCAL_VENDOR_MODULE := true


mm-evrc-enc-test-inc    := $(LOCAL_PATH)/inc
mm-evrc-enc-test-inc    += $(LOCAL_PATH)/test
mm-evrc-enc-test-inc    += $(TARGET_OUT_HEADERS)/mm-core/omxcore
ifeq ($(strip $(TARGET_USES_QCOM_MM_AUDIO)),true)
mm-evrc-enc-test-inc     += $(TARGET_OUT_HEADERS)/mm-audio/audio-alsa 
endif
LOCAL_MODULE            := mm-aenc-omxevrc-test
LOCAL_MODULE_TAGS       := optional
LOCAL_CFLAGS            := $(libOmxEvrcEnc-def)
LOCAL_C_INCLUDES        := $(mm-evrc-enc-test-inc)
LOCAL_SHARED_LIBRARIES  := libmm-omxcore
LOCAL_SHARED_LIBRARIES  += libOmxEvrcEnc
ifeq ($(strip $(TARGET_USES_QCOM_MM_AUDIO)),true)
LOCAL_SHARED_LIBRARIES  += libaudioalsa
endif
LOCAL_SRC_FILES         := test/omx_evrc_enc_test.c

include $(BUILD_EXECUTABLE)

endif

# ---------------------------------------------------------------------------------
#                     END
# ---------------------------------------------------------------------------------
