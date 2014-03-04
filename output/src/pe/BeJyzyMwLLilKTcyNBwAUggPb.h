// eJxjdCwtyWdkNGTMzAsuKUpNzAUAJ7gFAS



#ifndef BEJYZYMWLLILKTCYNBWAUGGPB_H_
#define BEJYZYMWLLILKTCYNBWAUGGPB_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJyzyMwLLilKTcyNBwAUggPb

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

#endif // BEJYZYMWLLILKTCYNBWAUGGPB_H_

