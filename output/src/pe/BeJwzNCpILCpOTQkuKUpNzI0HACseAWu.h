// eJxjdCwtyWdkNGQsSCwqTk0JLilKTcwFAEB4Aa6



#ifndef BEJWZNCPILCPOTQKUKUPNZI0HACSEAWU_H_
#define BEJWZNCPILCPOTQKUKUPNZI0HACSEAWU_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJwzNCpILCpOTQkuKUpNzI0HACseAWu

namespace SPL 
{
    class MYPE : public SPL::PE
    {
    public:
        MYPE(bool isStandalone=false);

        virtual void registerResources(const std::string & applicationDir, const std::string & streamsInstallDir);

    };
} // end namespace SPL

#undef MYPE

#endif // BEJWZNCPILCPOTQKUKUPNZI0HACSEAWU_H_

