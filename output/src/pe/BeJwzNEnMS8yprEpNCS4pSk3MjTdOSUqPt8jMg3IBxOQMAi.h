// eJxjdCwtyWdkNGZMzEvMqaxKTQkuKUpNzGVMSUpnzMyDcADNnQwH



#ifndef BEJWZNENMS8YPREPNCS4PSK3MJTDOSUQPT8JMG3IBXOQMAI_H_
#define BEJWZNENMS8YPREPNCS4PSK3MJTDOSUQPT8JMG3IBXOQMAI_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPt8jMg3IBxOQMAi

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

#endif // BEJWZNENMS8YPREPNCS4PSK3MJTDOSUQPT8JMG3IBXOQMAI_H_

