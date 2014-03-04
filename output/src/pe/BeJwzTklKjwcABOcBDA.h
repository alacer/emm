// eJxjdCwtyWdkNGRMSUoHABJeAL8



#ifndef BEJWZTKLKJWCABOCBDA_H_
#define BEJWZTKLKJWCABOCBDA_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJwzTklKjwcABOcBDA

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

#endif // BEJWZTKLKJWCABOCBDA_H_

