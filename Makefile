THEOS_DEVICE_IP = 192.168.0.88
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Snoverlay
Snoverlay_FILES = Tweak.xm ./FallingSnow/UIView+XMASFallingSnow.m ./FallingSnow/XMASFallingSnowView.m
ARCHS = arm64


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += snoverlaypreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
