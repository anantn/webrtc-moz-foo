PROGS := capture dump_voe dump_vie

CPPFLAGS ?= -g -Wall
CPPFLAGS += -I../trunk/src
CPPFLAGS += -I../trunk/src/voice_engine/main/interface
CPPFLAGS += -I../trunk/src/video_engine/include

capture_SRCS := capture.cpp AudioCapture.cpp VideoCapture.cpp
dump_voe_SRCS := dump_voe.cc
dump_vie_SRCS := dump_vie.cc

WEBRTC_BUILDPATH ?= ../trunk/out/Debug/obj.target
WEBRTC_LIBS := \
  src/video_engine/libvideo_engine_core.a \
  src/voice_engine/libvoice_engine_core.a \
  src/modules/libvideo_render_module.a \
  src/modules/libmedia_file.a \
  src/modules/libvideo_processing.a \
  src/modules/libvideo_processing_sse2.a \
  src/modules/libvideo_capture_module.a \
  src/modules/libwebrtc_utility.a \
  src/modules/libwebrtc_video_coding.a \
  src/modules/libwebrtc_vp8.a \
  src/common_video/libwebrtc_jpeg.a \
  src/common_video/libwebrtc_libyuv.a \
  third_party/libvpx/libvpx.a \
  third_party/libjpeg_turbo/libjpeg_turbo.a \
  src/modules/libaudio_coding_module.a \
  src/modules/libaudio_processing.a \
  src/modules/libaudioproc_debug_proto.a \
  src/modules/libaudio_device.a \
  src/modules/libNetEq.a \
  src/modules/libns.a \
  src/modules/libaecm.a \
  src/modules/libaec.a \
  src/modules/libaec_sse2.a \
  src/modules/libbitrate_controller.a \
  src/modules/libremote_bitrate_estimator.a \
  src/common_audio/libresampler.a \
  src/modules/libiLBC.a \
  src/modules/libagc.a \
  src/modules/libCNG.a \
  src/modules/libiSACFix.a \
  src/modules/libiSAC.a \
  src/common_audio/libvad.a \
  src/modules/libudp_transport.a \
  src/modules/libaudio_conference_mixer.a \
  src/modules/librtp_rtcp.a \
  src/modules/libwebrtc_i420.a \
  src/modules/libG711.a \
  src/modules/libapm_util.a \
  src/common_audio/libsignal_processing.a \
  src/modules/libG722.a \
  src/modules/libPCM16B.a \
  third_party/protobuf/libprotobuf_lite.a \
  third_party/libyuv/libyuv.a \
  src/system_wrappers/source/libsystem_wrappers.a
LIBS := $(WEBRTC_LIBS:%=$(WEBRTC_BUILDPATH)/%) -lrt -lXext -lX11 -lasound -lpulse -ldl -pthread


## boilerplate

all: $(PROGS)

check: all
	./dump_voe
	./dump_vie

clean:
	$(RM) $(ALL_OBJS)
	$(RM) $(PROGS)

dist:
	@echo "not implemented"

.PHONEY: all check clean dist

define PROG_TEMPLATE
$(1)_OBJS := $$($(1)_SRCS:.cc=.o)
$(1)_OBJS := $$($(1)_OBJS:.cpp=.o)
ALL_OBJS += $$($(1)_OBJS)
$(1).o: CPPFLAGS += $$($(1)_CFLAGS)
$(1): $$($(1)_OBJS) $$(filter %.a, $$(LIBS))
	g++ $$(CFLAGS) -o $$@ $$^ $$(LIBS)
endef

$(foreach prog,$(PROGS),$(eval $(call PROG_TEMPLATE,$(prog))))
