PROGS := capture dump_voe dump_vie

CPPFLAGS ?= -g -Wall
CPPFLAGS += -I../src -I../src/video_engine/main/interface

capture_SRCS := capture.cpp
dump_voe_SRCS := dump_voe.cc
dump_voe_CFLAGS := -I../src/voice_engine/main/interface
dump_vie_SRCS := dump_vie.cc

WEBRTC := ../out/Debug/obj.target/src/video_engine/main/source/libvideo_engine_core.a ../out/Debug/obj.target/src/voice_engine/main/source/libvoice_engine_core.a ../out/Debug/obj.target/src/modules/video_render/main/source/libvideo_render_module.a ../out/Debug/obj.target/src/modules/media_file/source/libmedia_file.a ../out/Debug/obj.target/src/modules/video_processing/main/source/libvideo_processing.a ../out/Debug/obj.target/src/modules/video_capture/main/source/libvideo_capture_module.a ../out/Debug/obj.target/src/modules/utility/source/libwebrtc_utility.a ../out/Debug/obj.target/src/modules/video_coding/main/source/libwebrtc_video_coding.a ../out/Debug/obj.target/src/modules/video_coding/codecs/vp8/main/source/libwebrtc_vp8.a ../out/Debug/obj.target/src/common_video/jpeg/main/source/libwebrtc_jpeg.a ../out/Debug/obj.target/third_party/libvpx/libvpx.a ../out/Debug/obj.target/third_party/libjpeg_turbo/libjpeg_turbo.a ../out/Debug/obj.target/src/modules/audio_coding/main/source/libaudio_coding_module.a ../out/Debug/obj.target/src/modules/audio_processing/main/source/libaudio_processing.a ../out/Debug/obj.target/src/modules/audio_device/main/source/libaudio_device.a ../out/Debug/obj.target/src/modules/audio_coding/NetEQ/main/source/libNetEq.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/opus/main/source/libopus.a ../out/Debug/obj.target/src/modules/audio_processing/ns/main/source/libns.a ../out/Debug/obj.target/src/modules/audio_processing/aecm/main/source/libaecm.a ../out/Debug/obj.target/src/modules/audio_processing/aec/main/source/libaec.a ../out/Debug/obj.target/src/common_audio/resampler/main/source/libresampler.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/iLBC/main/source/libiLBC.a ../out/Debug/obj.target/src/modules/audio_processing/agc/main/source/libagc.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/CNG/main/source/libCNG.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/iSAC/fix/source/libiSACFix.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/iSAC/main/source/libiSAC.a ../out/Debug/obj.target/src/common_audio/vad/main/source/libvad.a ../out/Debug/obj.target/src/modules/udp_transport/source/libudp_transport.a ../out/Debug/obj.target/src/modules/audio_conference_mixer/source/libaudio_conference_mixer.a ../out/Debug/obj.target/src/modules/rtp_rtcp/source/librtp_rtcp.a ../out/Debug/obj.target/src/modules/video_coding/codecs/i420/main/source/libwebrtc_i420.a ../out/Debug/obj.target/src/common_video/vplib/main/source/libwebrtc_vplib.a ../out/Debug/obj.target/third_party/opus/libopus.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/G711/main/source/libG711.a ../out/Debug/obj.target/src/modules/audio_processing/utility/libapm_util.a ../out/Debug/obj.target/src/common_audio/signal_processing_library/main/source/libspl.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/G722/main/source/libG722.a ../out/Debug/obj.target/src/modules/audio_coding/codecs/PCM16B/main/source/libPCM16B.a ../out/Debug/obj.target/src/system_wrappers/source/libsystem_wrappers.a -lrt -lXext -lX11 -lasound -lpulse -ldl -pthread



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
$(1): $$($(1)_OBJS)
	g++ $$(CFLAGS) -o $$@ $$^ $$(WEBRTC)
endef

$(foreach prog,$(PROGS),$(eval $(call PROG_TEMPLATE,$(prog))))
