# See https://github.com/bxparks/EpoxyDuino for documentation about this
# Makefile to compile and run Arduino programs natively on Linux or MacOS.

# Remove flto flag from EpoxyDuino (too many <optimized out>)
# CXXFLAGS = -Wextra -Wall -std=gnu++11 -fno-exceptions -fno-threadsafe-statics

APP_NAME := tiny_bash
ARDUINO_LIBS := AUnit AceCommon AceTime AceUtils TinyMqtt EspMock ESP8266WiFi  ESPAsyncTCP TinyConsole TinyBash TinyTerm TinyVim EpoxyFS
ARDUINO_LIB_DIRS := ../../../EspMock/libraries
EPOXY_CORE := EPOXY_CORE_ESP8266

# GCC
# CXXFLAGS = -Wextra -Wall -std=gnu++11 -fno-exceptions -fno-threadsafe-statics
EXTRA_CXXFLAGS=-g3 -O0 -std=c++17

CXXFLAGS ?= -D_GNU_SOURCE -Werror=return-type -std=gnu++17 -Wall -g3 -O0

# CLANG SANITIZE
# CXX=clang
# EXTRA_CXXFLAGS=-g3 -O0 -fsanitize=memory
# LDFLAGS = -lpthread -lstdc++

include ../../../EpoxyDuino/EpoxyDuino.mk
