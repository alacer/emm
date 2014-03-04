// eJxjdCwtyWdkNGRMy8wpSS1KTQkuKUpNzAUATxUHCK


#include "BeJwzNEnLzClJLUpNCS4pSk3MjQcAN9UGCA.h"
#include <dst-config.h>
#include <SPL/Runtime/Utility/BackoffSpinner.h>

#include <SPL/Runtime/Utility/MessageFormatter.h>

#include <streams_boost/filesystem/operations.hpp>
namespace bf = streams_boost::filesystem;


using namespace SPL;

extern int PE_Version;

#define MYPE BeJwzNEnLzClJLUpNCS4pSk3MjQcAN9UGCA



MYPE::MYPE(bool isStandalone/*=false*/) 
    : SPL::PE(isStandalone, NULL)
{
   PE_Version = 3100;
   BackoffSpinner::setYieldBehaviour(BackoffSpinner::Auto);
}


void MYPE::registerResources(const std::string & applicationDir, const std::string & streamsInstallDir)
{
    SPL::RuntimeMessageFormatter & formatter = SPL::RuntimeMessageFormatter::instance(); 
    { 
        bf::path p(streamsInstallDir);
        p /= "/toolkits/com.ibm.streams.rproject";
        formatter.registerToolkit("com.ibm.streams.rproject", p.string()); 
    } 
}


MAKE_PE(SPL::MYPE);

