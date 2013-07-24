APP_PROJECT_PATH  	:= $(call my-dir)/..
#APP_CPPFLAGS 		+= -frtti 
#APP_CPPFLAGS 		+= -fexceptions
APP_ABI				:= armeabi

APP_CFLAGS 			+= -DMULTI

#ndk-gdb --force --verbose
#ndk-build NDK_DEBUG=1
#ndk-build RELEASE=1
RELEASE := $(strip $(RELEASE))
ifdef RELEASE
	APP_OPTIM       := release
	APP_ABI			+= armeabi-v7a
	
	APP_CPPFLAGS  	+= -O3 -funroll-loops -DFPM_ARM
else
	APP_OPTIM		:= debug
    APP_CFLAGS 		+= -DDEBUGON
    
    # Reduce compilation time and make debugging produce the expected results.
	# This is the default. So no need to turn on
	#APP_CPPFLAGS  	+= -O0
	
	# CCRelease: Makes macros debugable
	APP_CPPFLAGS  	+= -g3
endif

SAMSUNG := $(strip $(SAMSUNG))
ifdef SAMSUNG
    APP_CFLAGS 		+= -DSAMSUNG
    APP_CFLAGS 		+= -DNOGOOGLE
endif

AMAZON := $(strip $(AMAZON))
ifdef AMAZON
    APP_CFLAGS 		+= -DNOGOOGLE
endif

INTEL := $(strip $(INTEL))
ifdef INTEL
    APP_ABI			+= x86
endif

# Make all warnings into errors
APP_CPPFLAGS  		:= -Werror

# We don't need accurate floating point maths, do we?
APP_CPPFLAGS  		+= -ffast-math