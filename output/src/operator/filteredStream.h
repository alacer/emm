// eJydkMFLwzAUxnn_1yRwe2kuy7FjwUEUPmwWhu_0xUonu2wTQvJJHZ_1vVmqR2oIDJyCF947_1d9X7zVzKGWQZGRuigelA7oQMAqHgFLxngYLPJb3BxdVdN6GBqx3VWNqLbj3tZ346Ysy3FX7j3rlmlHq3C9gvrpsSicD06ZFgB4Rz3yKFH2ntfTXYf3gyJ_0JPfmrXxBjn3PDzJIMGQwol7nNIn2TKRRmigzZclFF9ZiaMipVpksX1zdLJJ3Dvcf1qH3sVNq8jU9Uf7RBBS49AEAa5jwMFexMnRncYLTJfBfWDGXnB_1Oqb91_1Gn_159JpNstjxk9PGpcf




#ifndef SPL_OPER_INSTANCE_FILTEREDSTREAM_H_
#define SPL_OPER_INSTANCE_FILTEREDSTREAM_H_

#include <SPL/Runtime/Operator/Operator.h>
#include <SPL/Runtime/Operator/ParameterValue.h>
#include <SPL/Runtime/Operator/OperatorContext.h>
#include <SPL/Runtime/Operator/Port/AutoPortMutex.h>
#include <SPL/Runtime/ProcessingElement/PE.h>
#include <SPL/Runtime/Type/SPLType.h>
#include <SPL/Runtime/Utility/CV.h>
using namespace UTILS_NAMESPACE;

#include "../type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.h"

#include <bitset>

#define MY_OPERATOR filteredStream$OP
#define MY_BASE_OPERATOR filteredStream_Base
#define MY_OPERATOR_SCOPE SPL::_Operator

namespace SPL {
namespace _Operator {

class MY_BASE_OPERATOR : public Operator
{
public:
    
    typedef SPL::BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs IPort0Type;
    typedef SPL::BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs OPort0Type;
    
    MY_BASE_OPERATOR();
    
    ~MY_BASE_OPERATOR();
    
    inline void tupleLogic(Tuple const & tuple, uint32_t port);
    void processRaw(Tuple const & tuple, uint32_t port);
    
    inline void punctLogic(Punctuation const & punct, uint32_t port);
    void processRaw(Punctuation const & punct, uint32_t port);
    
    
    
    SPL::rstring lit$0;
    
    
protected:
    Mutex $svMutex;
    typedef std::bitset<2> OPortBitsetType;
    OPortBitsetType $oportBitset;
    Mutex $fpMutex;
    void checkpointStateVariables(NetworkByteBuffer & opstate) const {
    }
    void restoreStateVariables(NetworkByteBuffer & opstate) {
    }
private:
    static bool globalInit_;
    static bool globalIniter();
    ParameterMapType paramValues_;
    ParameterMapType& getParameters() { return paramValues_;}
    void addParameterValue(std::string const & param, ConstValueHandle const& value)
    {
        ParameterMapType::iterator it = paramValues_.find(param);
        if (it == paramValues_.end())
            it = paramValues_.insert (std::make_pair (param, ParameterValueListType())).first;
        it->second.push_back(&ParameterValue::create(value));
    }
    void addParameterValue(std::string const & param)
    {
        ParameterMapType::iterator it = paramValues_.find(param);
        if (it == paramValues_.end())
            it = paramValues_.insert (std::make_pair (param, ParameterValueListType())).first;
        it->second.push_back(&ParameterValue::create());
    }
};


class MY_OPERATOR : public MY_BASE_OPERATOR 
{
public:
   MY_OPERATOR() {}
  
   void process(Tuple const & tuple, uint32_t port);
   void process(Punctuation const & punct, uint32_t port);
   
}; 

} // namespace _Operator
} // namespace SPL

#undef MY_OPERATOR_SCOPE
#undef MY_BASE_OPERATOR
#undef MY_OPERATOR
#endif // SPL_OPER_INSTANCE_FILTEREDSTREAM_H_

