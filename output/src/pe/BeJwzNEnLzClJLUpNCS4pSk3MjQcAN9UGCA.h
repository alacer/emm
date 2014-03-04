// eJxjdCwtyWdkNGRMy8wpSS1KTQkuKUpNzAUATxUHCK



#ifndef BEJWZNENLZCLJLUPNCS4PSK3MJQCAN9UGCA_H_
#define BEJWZNENLZCLJLUPNCS4PSK3MJQCAN9UGCA_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJwzNEnLzClJLUpNCS4pSk3MjQcAN9UGCA

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

#endif // BEJWZNENLZCLJLUPNCS4PSK3MJQCAN9UGCA_H_

