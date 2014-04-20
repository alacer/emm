# NOTE: This makefile is designed to be run from one level up in the directory
# hierarchy compared to where it resides. For instance, if this makefile is
# located at 'output/build/Makefile', then it can be launched as:
# 'make -f build/Makefile' from the 'output' directory.

ifeq ($(CXX),)
  CXX=g++
endif
PKGCONFIG := /opt/ibm/InfoSphereStreams/bin/dst-pe-pkg-config.sh
PE_INCLUDE := $(shell $(PKGCONFIG) --cflags dst-spl-pe-install)
PE_LIB := $(shell $(PKGCONFIG) --libs dst-spl-pe-install)
PE_STAND_LIB := $(shell $(PKGCONFIG) --libs dst-spl-pe-install-standalone)
SPL_CXXFLAGS = -Wall -Wno-unused -Wno-sign-compare
SPL_CXXFLAGS += -D_REENTRANT -fPIC -finline-functions -fmessage-length=0
SPL_CXXFLAGS += $(PE_INCLUDE) -O3 -DNDEBUG 
SPL_LDFLAGS = $(PE_LIB)

SPL_TYPES = build/type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.o \
            build/type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.o \
            build/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.o \
            build/type/BeJwrMSw2ycnMSwUADOECD1.o 
SPL_FUNCTIONS = 
SPL_OPERATORS = build/operator/inStream.o \
                build/operator/parsedStream.o \
                build/operator/filteredStream.o \
                build/operator/analyzedStream.o \
                build/operator/dbg.o 
SPL_PE_OBJS = build/pe/BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO.o 
SPL_PE_BINS = bin/Main-a.dpe 

.PHONY: distclean clean all types functions operators pes svar

all: bin types functions operators pes svar standalone

distclean clean:
	@rm -fr bin/* build/type build/function build/operator build/pe build/svar build/standalone

bin:
	@mkdir -m 755 bin

types: $(SPL_TYPES)

build/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.o: \
	    src/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.h \
	    src/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.cpp \
	    build/cppOptions \
	    | build/type
	@echo ' [CXX-type] enum{csv,txt,bin,block,line}'
	@$(CXX) -o $@ -c $(SPL_CXXFLAGS) src/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.cpp

build/type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.o: \
	    src/type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.h \
	    src/type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.cpp \
	    build/cppOptions \
	    | build/type
	@echo ' [CXX-type] tuple<rstring origin,rstring path,list<rstring> prediction>'
	@$(CXX) -o $@ -c $(SPL_CXXFLAGS) src/type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.cpp

build/type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.o: \
	    src/type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.h \
	    src/type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.cpp \
	    build/cppOptions \
	    | build/type
	@echo ' [CXX-type] tuple<rstring origin,rstring path>'
	@$(CXX) -o $@ -c $(SPL_CXXFLAGS) src/type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.cpp

build/type/BeJwrMSw2ycnMSwUADOECD1.o: \
	    src/type/BeJwrMSw2ycnMSwUADOECD1.h \
	    src/type/BeJwrMSw2ycnMSwUADOECD1.cpp \
	    build/cppOptions \
	    | build/type
	@echo ' [CXX-type] tuple<rstring line>'
	@$(CXX) -o $@ -c $(SPL_CXXFLAGS) src/type/BeJwrMSw2ycnMSwUADOECD1.cpp

build/type:
	-@mkdir -m 755 build/type

operators: $(SPL_OPERATORS)

-include build/operator/inStream.d
build/operator/inStream.o: \
	    src/operator/inStream.h \
	    src/operator/inStream.cpp\
	    build/dep/operator/inStream.dep \
	    src/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.h  \
	    build/cppOptions \
	    | build/operator
	@echo ' [CXX-operator] inStream'
	@$(CXX) -o $@ -MD -I /opt/ibm/InfoSphereStreams/toolkits/spl/impl/include -DSPLJAVAFUNCTION_ADL_FILENAME=\"Main.adl\" -c $(SPL_CXXFLAGS) src/operator/inStream.cpp

-include build/operator/parsedStream.d
build/operator/parsedStream.o: \
	    src/operator/parsedStream.h \
	    src/operator/parsedStream.cpp\
	    build/dep/operator/parsedStream.dep  \
	    build/cppOptions \
	    | build/operator
	@echo ' [CXX-operator] parsedStream'
	@$(CXX) -o $@ -MD -I /opt/ibm/InfoSphereStreams/toolkits/com.ibm.streams.rproject/impl/nl/include -DSPLJAVAFUNCTION_ADL_FILENAME=\"Main.adl\" -c $(SPL_CXXFLAGS) src/operator/parsedStream.cpp

-include build/operator/filteredStream.d
build/operator/filteredStream.o: \
	    src/operator/filteredStream.h \
	    src/operator/filteredStream.cpp\
	    build/dep/operator/filteredStream.dep  \
	    build/cppOptions \
	    | build/operator
	@echo ' [CXX-operator] filteredStream'
	@$(CXX) -o $@ -MD -DSPLJAVAFUNCTION_ADL_FILENAME=\"Main.adl\" -c $(SPL_CXXFLAGS) src/operator/filteredStream.cpp

-include build/operator/analyzedStream.d
build/operator/analyzedStream.o: \
	    src/operator/analyzedStream.h \
	    src/operator/analyzedStream.cpp\
	    build/dep/operator/analyzedStream.dep  \
	    build/cppOptions \
	    | build/operator
	@echo ' [CXX-operator] analyzedStream'
	@$(CXX) -o $@ -MD -I /opt/ibm/InfoSphereStreams/toolkits/com.ibm.streams.rproject/impl/nl/include -DSPLJAVAFUNCTION_ADL_FILENAME=\"Main.adl\" -c $(SPL_CXXFLAGS) src/operator/analyzedStream.cpp

-include build/operator/dbg.d
build/operator/dbg.o: \
	    src/operator/dbg.h \
	    src/operator/dbg.cpp\
	    build/dep/operator/dbg.dep \
	    src/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.h  \
	    build/cppOptions \
	    | build/operator
	@echo ' [CXX-operator] dbg'
	@$(CXX) -o $@ -MD -I /opt/ibm/InfoSphereStreams/toolkits/spl/impl/include -DSPLJAVAFUNCTION_ADL_FILENAME=\"Main.adl\" -c $(SPL_CXXFLAGS) src/operator/dbg.cpp

build/operator:
	-@mkdir -m 755 -p build/operator

functions: $(SPL_FUNCTIONS)

pes: $(SPL_PE_BINS)

build/pe/BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO.o: \
	    src/pe/BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO.h \
	    src/pe/BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO.cpp  \
	    build/cppOptions \
	    | build/pe
	@echo ' [CXX-pe] pe Main-a'
	@$(CXX) -o $@ -c $(SPL_CXXFLAGS) src/pe/BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO.cpp

PEMain-a = \
	    build/pe/BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO.o \
	    build/operator/inStream.o \
	    build/type/BeJwrMSw2ycnMSwUADOECD1.o \
	    build/type/BeJyrNI03Ti4uMy6pKDFOyswzTcrJT842ycnMSwUAf_1wJCo.o \
	    build/operator/parsedStream.o \
	    build/type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.o \
	    build/operator/filteredStream.o \
	    build/operator/analyzedStream.o \
	    build/type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.o \
	    build/operator/dbg.o 

bin/Main-a.dpe: \
	$(PEMain-a) \
	build/dep/Main-a.dep \
	build/ldOptions
	@echo ' [LD-pe] pe Main-a'
	@$(CXX) $(SPL_CXXFLAGS) -o bin/Main-a.dpe -fPIC -shared $(PEMain-a) -lstreams-stdtk-runtime -lstreams-stdtk-runtime $(SPL_LDFLAGS)

build/pe:
	-@mkdir -m 755 build/pe

standalone: bin/standalone 

build/standalone/standalone.o: \
	    src/standalone/standalone.h \
	    src/standalone/standalone.cpp  \
	    build/cppOptions \
	    | build/standalone
	@echo ' [CXX-standalone] standalone'
	@$(CXX) -o $@ -c $(SPL_CXXFLAGS) src/standalone/standalone.cpp

bin/standalone: build/standalone/standalone.o build/ldOptions
	@echo ' [LD-standalone] standalone'
	@$(CXX) $(SPL_CXXFLAGS) -o bin/standalone build/standalone/standalone.o $(PE_STAND_LIB)
	@echo ' [LN-standalone] standalone '
	@ln -sf standalone bin/Main
build/standalone:
	-@mkdir -m 755 build/standalone

