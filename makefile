#
# Copyright (c) 2013 kaytat
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

#
# $File: //depot/stoker_git/stoker/tini/examples/stoker/makefile $
# $Date: 2013/07/30 $
# $Revision: #2 $
# $Author: kaytat $
#
.PHONY: all app clean

TINI_HOME := $(subst \,/,$(TINI_HOME))
include $(TINI_HOME)/tools/osvars.mak

APP := stoker
SRC_DIR := stoker
BIN_DIR := bin

FLASH_UTIL_DIR := ../Flash_Util
TWITTER_DIR := ../twitter
JSON_DIR := ../json

LOCAL_CP := $(FLASH_UTIL_DIR)/bin$(CP_SEP)$(JSON_DIR)/json.jar$(CP_SEP)$(TWITTER_DIR)/twitter.jar

BASE_SOURCE := \
    Controller.java \
    Stoker.java \
    Front_Panel.java \
    Post_Handler.java \
    WebWorker.java \
    Device_Record.java \
    Debug_Output.java \
    Lcd.java \
    Round.java \
    Fp_Menu.java  \
    Db.java \
    Temp.java \
    Thermo.java \
    Version.java \
    Index_Page.java \
    Quick_Sort.java \
    System_Record.java \
    Socket_Control.java \
    Sector_Cache.java \
    Json_Handler.java \
	GS.java \
	GS_Hack.java \
	GS_Debug.java

SOURCE := $(addprefix pp_src/,$(BASE_SOURCE))
OBJS   := $(addprefix $(BIN_DIR)/$(SRC_DIR)/,$(BASE_SOURCE))
OBJS   := $(OBJS:%.java=%.class)

SRC_ASM_DIR := $(SRC_DIR)
OBJS_ASM := $(BIN_DIR)/reg.tlib

EXTRA_CLEAN := stats.html index_stripped.html $(SRC_DIR)/Index_Page.java $(SRC_DIR)/Version.java $(APP).jar

BD_ADD := -add OneWireContainer30\;OneWireContainer05\;OneWireContainer3A\;HTTPCLIENT -f $(FLASH_UTIL_DIR)/bin/flash -f $(JSON_DIR)/json.jar -f $(TWITTER_DIR)/twitter.jar
TC_EXE := -l -t 490000

all: index_stripped.html $(APP).jar

app: index_stripped.html $(BIN_DIR)/$(APP).tini $(BIN_DIR)/$(APP).tbin

clean: generic_clean

index_stripped.html: index.html condense.pl $(TINI_HOME)/tools/constants.mak
	perl condense.pl index.html $(SRC_DIR)/Index_Page.java > $@

$(SRC_DIR)/Version.java: build_ver.pl
	perl build_ver.pl ver.txt > $@

include $(TINI_HOME)/tools/include.mak
