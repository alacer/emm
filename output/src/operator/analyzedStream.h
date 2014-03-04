// eJyVUs1qwkAQZl5FetBL1qjQIqWQxgqNpi1GKJ5kTbY6NcmG2Q3WPH03Jm1Rg1hyWDLM9zczoUwsXCWW0iR4oizKSH6KUA_0HsyAkzDTY0DVfD1qWxfQ_0E_0xReDvyg0Fvv1_1ak7m_1tP1JscgCt_1D27rb34q5lsO17c_1fWK_1y7kTMd5U4urE3rjEI2UDiOU8ydhSr7S9kY9U0XgrfpcEjGJKZrONTskxqwjUwEq3OwoHoDnUcoT_152krYq46FgP2nZe_0DLSMQs4ppDKlMBA8AUNfIYC65RptU0xhiLF54IOJE_1dtgug5KikJUcy4xEhKG2Zq0OONp0rHItxiQE0GVWu05_1DKoi_1tbUuRfMJBmctRZGnOtNuwNPX8aFUiYI0OuqzNyAO85QIo1jV6ZK87Q6hJq56rxii4BAh_1sBs0pJuEajX_0uV_1PAXtQuygfyfVwaJ0eufKtkfJJPnNMv15VlVMDOtY2tXoutJ19suJx2j0vd180PFM2vesW3yfwMQwidg


/* Additional includes go here */
#include "RProjectToolkitResource.h"
#include <SPL/Runtime/Operator/OperatorMetrics.h>
#include <queue>


#ifndef SPL_OPER_INSTANCE_ANALYZEDSTREAM_H_
#define SPL_OPER_INSTANCE_ANALYZEDSTREAM_H_

#include <SPL/Runtime/Operator/Operator.h>
#include <SPL/Runtime/Operator/ParameterValue.h>
#include <SPL/Runtime/Operator/OperatorContext.h>
#include <SPL/Runtime/Operator/Port/AutoPortMutex.h>
#include <SPL/Runtime/ProcessingElement/PE.h>
#include <SPL/Runtime/Type/SPLType.h>
#include <SPL/Runtime/Utility/CV.h>
using namespace UTILS_NAMESPACE;

#include "../type/BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.h"
#include "../type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.h"

#include <bitset>

#define MY_OPERATOR analyzedStream$OP
#define MY_BASE_OPERATOR analyzedStream_Base
#define MY_OPERATOR_SCOPE SPL::_Operator

namespace SPL {
namespace _Operator {

class MY_BASE_OPERATOR : public Operator
{
public:
    
    typedef SPL::BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs IPort0Type;
    typedef SPL::BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue OPort0Type;
    
    MY_BASE_OPERATOR();
    
    ~MY_BASE_OPERATOR();
    
    inline void tupleLogic(Tuple const & tuple, uint32_t port);
    void processRaw(Tuple const & tuple, uint32_t port);
    
    inline void punctLogic(Punctuation const & punct, uint32_t port);
    void processRaw(Punctuation const & punct, uint32_t port);
    
    inline void submit(Tuple & tuple, uint32_t port)
    {
        Operator::submit(tuple, port);
    }
    inline void submit(Punctuation const & punct, uint32_t port)
    {
        Operator::submit(punct, port);
    }
    
    
    
    SPL::rstring lit$0;
    SPL::rstring lit$1;
    
    
protected:
    Mutex $svMutex;
    typedef std::bitset<2> OPortBitsetType;
    OPortBitsetType $oportBitset;
    Mutex $fpMutex;
    SPL::rstring param$initializationScriptFileName$0;
    SPL::rstring param$rObjects$0;
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
  // Constructor
  MY_OPERATOR();

  // Destructor
  virtual ~MY_OPERATOR(); 

  // Notify port readiness
  void allPortsReady(); 

  // Notify pending shutdown
  void prepareToShutdown(); 

  // processing for source and threaded operators
  void process(uint32_t idx);

  // Tuple processing for non-mutating ports 
  void process(Tuple const & tuple, uint32_t port);
    
  // Punctuation processing
  void process(Punctuation const & punct, uint32_t port);
private:

  // Internal class
  class ROutputEntry {
    public:
      string  value;
      short   flag;
  };

  // Internal class
  class ROutput {
    public:
      vector<ROutputEntry>  entries; 
      char            rc;
  };

  // Exception for errors that can't be handled
  class ROperatorShutdownException  : public std::exception {
    const char * what() const throw() {
      return "Severe error in R operator.";
    }
  };

  // methods
  int rSetup();
  void drainPipes();
  void stopR();


  void runInitScript();

  int setRObjects(const IPort0Type &);
  int runRScript(const IPort0Type&);
  int setStreamAttrs(const IPort0Type&, OPort0Type &);
  void handleProcessError(list<rstring>&, const IPort0Type&);
  void handleProcessError(string, const IPort0Type&);

  int readRStreamData(std::queue<std::string>&, Mutex&, std::string&);
  int readRStreamDataStdout(std::string &s) {
    return(readRStreamData(fromRData, fromRLock, s));
  }
  ROutput readFromR(short);
  ROutputEntry checkForSpecialValues(const string &, short);
  list<rstring> parseSpecialValues(const string &);
  bool checkBoolString(const string &s) {
    if ("TRUE" == s) return(true);
    else  return(false);
  }
  int readRStreamDataStderr(std::string &s) {
    return(readRStreamData(fromRStderrData, fromRStderrLock, s));
  }
  list<rstring> readFromRStderr(bool logMessages = true);
  string  buildROutputStmt(const string& s, const char msgType);
  string  buildRNoErrorOutputStmt(const string&, short); 
  string  buildRErrorOutputStmt(const string& s) {
    return(buildROutputStmt(s, OUTPUT_ERROR));
  }  
  string buildROutputBlobStmt(const string& s);
  string buildRCaptureValueStmt(const string&);
  string buildRCaptureFloatValueStmt(const string&);
  string buildRCaptureStringValueStmt(const string&);
  string buildRCaptureTimestampValueStmt(const string&);

  string & replaceString(string&, const string&, const string&);
  bool checkChildProcess();

  string toString(const float64);
  float64 toFloat64(const string&, int*);
  string toString(const complex64);
  complex64 toComplex64(const string&, int*);
  string toString(const decimal128);
  decimal128 toDecimal128(const string&, int*);
  string toString(const int64);
  int64 toInt64(const string&, int*);
  string toString(const uint64);
  uint64 toUint64(const string&, int*);
  string toString(const boolean);
  boolean toBoolean(const string&, int*);
  string toString(const timestamp&);
  timestamp toTimestamp(const string&, int*);
  string blobToRawVector(const blob&);
  blob   rawVectorToBlob(const string&);

  string formatMsg(const FormattableMessage &msg) {
    return(msg.key() + ":  " + msg.format());
  }


  // Members
  pid_t              rPid;

  filtering_streambuf<output> toRSb;
  std::ostream     *toRStream;

  filtering_streambuf<input> fromRSb;
  std::istream               *fromRStream;
  std::queue<std::string>    fromRData;
  Mutex                      fromRLock;

  filtering_streambuf<input> fromRStderrSb;
  std::istream               *fromRStderrStream;
  std::queue<std::string>    fromRStderrData;
  Mutex                      fromRStderrLock;

  Mutex            _mutex;
  Metric           *_failedTuples;
  bool             rDead;
  bool             rShutdown;


  static const std::string TOKEN_START_BLOCK;
  static const std::string TOKEN_START_LINE;
  static const std::string TOKEN_END_LINE;
  static const std::string TOKEN_END_BLOCK;
  static const std::string TOKEN_END_ERROR;
  static const std::string TOKEN_DELIMITER;
  static const std::string TOKEN_NEWLINE;
  static const std::string TOKEN_READERROR;
  static const char        OUTPUT_NOERROR;
  static const char        OUTPUT_ERROR;

  static const short       RVALUE_FLAG_NONE;
  static const short       RVALUE_FLAG_TEXTONLY;
  static const short       RVALUE_FLAG_TEXTSPECIAL;
  static const short       RVALUE_FLAG_TEXTSPECIALFLOAT;
  static const short       RVALUE_FLAG_TEXTSPECIALSTRING;
  static const short       RVALUE_FLAG_TEXTSPECIALBLOB;
  static const short       RVALUE_FLAG_TEXTSPECIALTIMESTAMP;

  static const short       RVALUE_NOEXISTS;
  static const short       RVALUE_NA;
  static const short       RVALUE_NULL;
  static const short       RVALUE_NAN;
  static const short       RVALUE_INF;
  static const short       RVALUE_NEG;
  static const short       RVALUE_NOTRAW;
  static const short       RVALUE_NOTTIMESTAMP;
  static const short       RVALUE_NOTCHAR;

  static const std::string RTEXT_FALSE;
  static const std::string RTEXT_TRUE;
}; 

} // namespace _Operator
} // namespace SPL

#undef MY_OPERATOR_SCOPE
#undef MY_BASE_OPERATOR
#undef MY_OPERATOR
#endif // SPL_OPER_INSTANCE_ANALYZEDSTREAM_H_





