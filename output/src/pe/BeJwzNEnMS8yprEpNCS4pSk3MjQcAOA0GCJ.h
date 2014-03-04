// eJxjdCwtyWdkNGRMzEvMqaxKTQkuKUpNzAUAT0QHCT



#ifndef BEJWZNENMS8YPREPNCS4PSK3MJQCAOA0GCJ_H_
#define BEJWZNENMS8YPREPNCS4PSK3MJQCAOA0GCJ_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJwzNEnMS8yprEpNCS4pSk3MjQcAOA0GCJ

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

#endif // BEJWZNENMS8YPREPNCS4PSK3MJQCAOA0GCJ_H_

