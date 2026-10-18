#AUDIO_POLICY_TEST := true
#ENABLE_AUDIO_DUMP := true

LOCAL_PATH := $(call my-dir)

msm8660_audio_cflags :=

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
  msm8660_audio_cflags += -DWITH_A2DP
endif

ifeq ($(QCOM_FM_ENABLED),true)
  msm8660_audio_cflags += -DQCOM_FM_ENABLED
endif

ifneq ($(BOARD_QCOM_TUNNEL_LPA_ENABLED),false)
  msm8660_audio_cflags += -DQCOM_TUNNEL_LPA_ENABLED
endif

ifeq ($(BOARD_QCOM_VOIP_ENABLED),true)
  msm8660_audio_cflags += -DQCOM_VOIP_ENABLED
endif

ifeq ($(BOARD_QCOM_TUNNEL_PLAYBACK_ENABLED),true)
  msm8660_audio_cflags += -DTUNNEL_PLAYBACK
endif

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
  msm8660_audio_cflags += -DQCOM_ACDB_ENABLED
endif

ifeq ($(BOARD_HAVE_SAMSUNG_AUDIO),true)
  msm8660_audio_cflags += -DSAMSUNG_AUDIO
endif

ifeq ($(BOARD_HAVE_SONY_AUDIO),true)
  msm8660_audio_cflags += -DSONY_AUDIO
endif

ifeq ($(BOARD_HAVE_BACK_MIC_CAMCORDER),true)
  msm8660_audio_cflags += -DBACK_MIC_CAMCORDER
endif


include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm
LOCAL_CFLAGS := -D_POSIX_SOURCE

LOCAL_SRC_FILES := \
    AudioHardware.cpp \
    audio_hw_hal.cpp

LOCAL_SHARED_LIBRARIES := \
    liblog          \
    libcutils       \
    libutils        \
    libaudioalsa    \
    libacdbloader   \
    libacdbmapper

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper \
    libaudiohw_legacy_mione

LOCAL_HEADER_LIBRARIES := libhardware_headers libhardware_legacy_headers

LOCAL_MODULE := audio.primary.msm8660
LOCAL_VENDOR_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS += -fno-short-enums

LOCAL_C_INCLUDES := $(TARGET_OUT_HEADERS)/mm-audio/audio-alsa
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audcal
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-acdb-util
LOCAL_C_INCLUDES += hardware/libhardware/include
LOCAL_C_INCLUDES += hardware/libhardware_legacy/include
LOCAL_C_INCLUDES += frameworks/base/include
LOCAL_C_INCLUDES += system/core/include

LOCAL_C_INCLUDES += 
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS += $(msm8660_audio_cflags)
# Keep legacy public-header diagnostics scoped to this primary HAL.
LOCAL_CFLAGS += -Wno-error=missing-field-initializers -Wno-error=narrowing
LOCAL_CFLAGS += -Wno-error=unused-parameter -Wno-error=unused-variable

LOCAL_CFLAGS += -idirafter $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
include $(BUILD_SHARED_LIBRARY)
