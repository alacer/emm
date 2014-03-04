// eJxjdCwtyWdkNGVMzEvMqaxKTQkuKUpNzGVMSUpnTMvMKUktggtl5kEZBYlFxTBRALeMBax



#ifndef BEJWZNENMS8YPREPNCS4PSK3MJTDOSUQPNZRJY8WPSS2CI1PK5KFZHKYFIUXFCAKADREYBO_H_
#define BEJWZNENMS8YPREPNCS4PSK3MJTDOSUQPNZRJY8WPSS2CI1PK5KFZHKYFIUXFCAKADREYBO_H_

#include <SPL/Runtime/ProcessingElement/PE.h>

#define MYPE BeJwzNEnMS8yprEpNCS4pSk3MjTdOSUqPNzRJy8wpSS2Ci1pk5kFZhkYFiUXFcAkADREYBO

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

#endif // BEJWZNENMS8YPREPNCS4PSK3MJTDOSUQPNZRJY8WPSS2CI1PK5KFZHKYFIUXFCAKADREYBO_H_

