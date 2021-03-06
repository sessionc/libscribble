# 
# Makefile
#

ROOT := .
include $(ROOT)/Common.mk

all: libscribble libscribble.a tool

libscribble:
	$(MAKE) --dir=src

tool:
	$(MAKE) --dir=src tool

updateversion:
	utils/update-ver.sh

libscribble.a: libscribble
	$(RM) $(LIB_DIR)/$@
	$(AR) $(ARFLAGS) $(BUILD_DIR)/$@ $(BUILD_DIR)/*.o
	$(CP) -v $(BUILD_DIR)/$@ $(LIB_DIR)/$@

install: libscribble libscribble.a tool
	$(MKDIR) $(DESTDIR)/usr/include/scribble
	$(MKDIR) $(DESTDIR)/usr/lib
	$(MKDIR) $(DESTDIR)/usr/bin
	$(INSTALL) $(INCLUDE_DIR)/scribble/*.h $(DESTDIR)/usr/include/scribble
	$(INSTALL) $(BUILD_DIR)/*.so $(DESTDIR)/usr/lib
	$(INSTALL) $(LIB_DIR)/*.a $(DESTDIR)/usr/lib
	$(INSTALL) $(BIN_DIR)/* $(DESTDIR)/usr/bin

pkg-deb: all
	dpkg-buildpackage -us -uc -rfakeroot

include $(ROOT)/Rules.mk
