// eJyNks1uwjAQhLWvgnqAQ22S9sQt5ecATakIVcUJmbAEt4ltrY1oePoaQouAFFU_0WF7Njr5Zb6oLJhcFs45QFJaRIf2Bqet0JklK0jgIoO1PCA3GuCsN8iccbilOdFiW82A0jedBPNrNTNLdDaMo2k2jmWXrxpV_0G5ap8tdb1Bv3u71gr2nDA_0TS3bUheX3udMhTSJXBoRbU1MKLGvC1LpAf4XlS3YnbLKW_0eG01fVojUuQ_1Efl7Eusl5nwpnAClFcIjSCWdFLncCSe1qkYwkDm_0iALhAumcurkPTJZSbgRZvF9tVLr3sGzSaEHkvGixcTggRKDbxsFxKOdNVcrfmr3GkUaT72MZunkuFTZb0P8yhNZ6DqDxYh_07pu88Rq4zhspR6bG7nt8JVW3B0b6S_1_1GrIIEOCwOHFH6mp1Bt0DUOt_1YICu8WgiaZSXVyWpEuJvVDC8AIt_16XNPRE3wS9PbN


/* Additional includes go here */
#include "RProjectToolkitResource.h"
#include <SPL/Runtime/Operator/OperatorMetrics.h>
#include <queue>


#ifndef SPL_OPER_INSTANCE_PARSEDSTREAM_H_
#define SPL_OPER_INSTANCE_PARSEDSTREAM_H_

#include <SPL/Runtime/Operator/Operator.h>
#include <SPL/Runtime/Operator/ParameterValue.h>
#include <SPL/Runtime/Operator/OperatorContext.h>
#include <SPL/Runtime/Operator/Port/AutoPortMutex.h>
#include <SPL/Runtime/ProcessingElement/PE.h>
#include <SPL/Runtime/Type/SPLType.h>
#include <SPL/Runtime/Utility/CV.h>
using namespace UTILS_NAMESPACE;

#include "../type/BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs.h"
#include "../type/BeJwrMSw2ycnMSwUADOECD1.h"

#include <bitset>

#define MY_OPERATOR parsedStream$OP
#define MY_BASE_OPERATOR parsedStream_Base
#define MY_OPERATOR_SCOPE SPL::_Operator

namespace SPL {
namespace _Operator {

class MY_BASE_OPERATOR : public Operator
{
public:
    
    typedef SPL::BeJwrMSw2ycnMSwUADOECD1 IPort0Type;
    typedef SPL::BeJwrMSo2yy_1KTM_1MKzYpSCzJAAAzTAYs OPort0Type;
    
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
    SPL::rstring lit$2;
    
    
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
#endif // SPL_OPER_INSTANCE_PARSEDSTREAM_H_





