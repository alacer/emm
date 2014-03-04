// eJx1j0ELgkAQhZm_1Ip3dtaM3yzxEUrBE502nstRZxhHx37cZBgUxh8eD4b3vda4ObWmdIMdxVtVoqOcCIQLtL4IgDJWMDtUKtwPnZliORevlmKT7zTqNwlsw_1dWVLDSYwy6OuROu2isAqBs1qLxF23TKvNVIX1b04wbiR_0dsgYod0x0LUSeTU4m1Kq1YaKl9MV08oJevmrk7Ee_1PvWDGiBOTBnLEH64_1C6ABnkJ8w5yp9RMUr1iz




#include "./inStream.h"
using namespace SPL::_Operator;

#include <SPL/Runtime/Function/SPLFunctions.h>
#include <SPL/Runtime/Operator/Port/Punctuation.h>


#define MY_OPERATOR_SCOPE SPL::_Operator
#define MY_BASE_OPERATOR inStream_Base
#define MY_OPERATOR inStream$OP


#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fstream>
#include <signal.h>

#include <streams_boost/iostreams/stream.hpp>
#include <streams_boost/iostreams/filtering_streambuf.hpp>
#include <streams_boost/iostreams/device/file_descriptor.hpp>


#include <SPL/Runtime/Common/ApplicationRuntimeMessage.h>
#include <SPL/Toolkit/IOHelper.h>
#include <SPL/Toolkit/RuntimeException.h>

#include <SPL/Runtime/Operator/OperatorMetrics.h>
#include <SPL/Runtime/Utility/LogTraceMessage.h>

using namespace std;
using namespace streams_boost::iostreams;

#define DEV_NULL "/dev/null"


// defines for error checking conditions
#define CHECK_FAIL      \
    if (failedRead)                                   \
        _numInvalidTuples.incrementValueNoLock()

    #define DO_ERROR(msg)                             \
        do { _numInvalidTuples.incrementValueNoLock();   \
          const FormattableMessage& $msg = msg;       \
          SPLTRACEMSG (L_ERROR, $msg, SPL_OPER_DBG);  \
          THROW (SPLRuntimeFileSourceOperator, $msg);} while (0)
    #define DO_ERROR_FILESOURCE(msg) DO_ERROR(msg)
    #define CHECK_ERROR(msg)                          \
        if (fs.fail() && !getPE().getShutdownRequested()) \
            DO_ERROR(msg)


MY_OPERATOR_SCOPE::MY_OPERATOR::MY_OPERATOR()
    : MY_BASE_OPERATOR(), _fd(-1),
         
         
        
        
        
        
        _numFilesOpenedMetric(getContext().getMetrics().getCustomMetricByName("nFilesOpened")),
        _numInvalidTuples(getContext().getMetrics().getCustomMetricByName("nInvalidTuples"))
{
    _numFilesOpenedMetric.setValueNoLock(0);
    _numInvalidTuples.setValueNoLock(0);
}

void MY_OPERATOR_SCOPE::MY_OPERATOR::prepareToShutdown()
{
    if (_fd >= 0) {
        ::close(_fd);
        _fd = -1;
    }
}

void MY_OPERATOR_SCOPE::MY_OPERATOR::initialize()
{
    
}



void MY_OPERATOR_SCOPE::MY_OPERATOR::punctAndStatus(const string& pathName)
{

    submit (Punctuation::WindowMarker, 0);


}

void MY_OPERATOR_SCOPE::MY_OPERATOR::processOneFile (const string& pathName)
{
    SPL::BeJwrMSw2ycnMSwUADOECD1 tuple$;
    
    namespace bf = streams_boost::filesystem;
    SPLAPPTRC(L_DEBUG, "Using '" << pathName << "' as the workload file...", SPL_OPER_DBG);

    int32_t fd = ::open (pathName.c_str(), O_RDONLY | O_LARGEFILE);
    if (fd < 0) {
        
        
        const FormattableMessage& m = 
                  SPL_APPLICATION_RUNTIME_FAILED_OPEN_INPUT_FILE(
                      pathName, RuntimeUtility::getErrorNoStr());
        SPLLOGMSG(L_ERROR, m, SPL_OPER_DBG);
        SPLTRACEMSG(L_ERROR, m, SPL_OPER_DBG);
        THROW (SPLRuntimeFileSourceOperator, m);
    }
    
        file_descriptor_source fd_src (fd, true);
    
    _numFilesOpenedMetric.incrementValueNoLock();
    filtering_streambuf<input> filt_str;
    
    
    filt_str.push (fd_src);
    
        istream fs (&filt_str);
    
    fs.imbue(locale::classic());

    _fd = fd;
    _tupleNumber = 0; 
    





bool failedRead = false;
while(!getPE().getShutdownRequested() && !fs.eof()) {
    _tupleNumber++;
    if (SPL::safePeek(fs) == EOF) break;
    bool doSubmit = true;
    try {
        
            // ignore comments and empty lines
            fs >> SPL::skipSpaceTabReturnNewLines;
            while (fs.peek() == '#') {
                std::string dummy;
                std::getline (fs, dummy);
                fs >> SPL::skipSpaceTabReturnNewLines;
            }
            if (SPL::safePeek(fs)==EOF) break;
            failedRead = false;
            

                
                    SPL::readCSV<SPL::rstring,','>(fs, tuple$.get_line());
                    
                CHECK_ERROR (SPL_APPLICATION_RUNTIME_FAILED_READ_TUPLE("tuple<rstring line>", _tupleNumber));
                CHECK_FAIL;
                
                 
                    // Check that we read a complete line
                    int eolSep = fs.get();
                    if (eolSep != '\n' && eolSep != '\r' && eolSep != EOF)
                        DO_ERROR (SPL_APPLICATION_RUNTIME_FAILED_READ_CHAR ("\\n", std::string(1, (char) eolSep), _tupleNumber));
                
            
        



    } catch (const SPLRuntimeException& e) {
        // Add the filename & tuple number
        DO_ERROR_FILESOURCE(
            SPL_APPLICATION_RUNTIME_FILE_SOURCE_SINK_FILENAME_TUPLE(_tupleNumber, pathName, e.getExplanation()));

    } catch (const std::exception& e) {
        DO_ERROR(SPL_APPLICATION_RUNTIME_EXCEPTION(e.what()));
        _numInvalidTuples.incrementValueNoLock();
        doSubmit = false;
    } catch (...) {
        DO_ERROR(SPL_APPLICATION_RUNTIME_UNKNOWN_EXCEPTION);
        _numInvalidTuples.incrementValueNoLock();
        doSubmit = false;
    }
    if (doSubmit)
        submit (tuple$, 0);
}

    if (_fd < 0) {
        // We closed it already.  Prevent an error message
        int newFd = ::open (DEV_NULL, O_RDONLY);
        ::dup2 (newFd, _fd);
        ::close(newFd);
    }
    _fd = -1; // no longer using this



    punctAndStatus(pathName);
}


void MY_OPERATOR_SCOPE::MY_OPERATOR::process(uint32_t) 
{
    SPLAPPTRC(L_DEBUG, "FileSource startup...", SPL_OPER_DBG);
    initialize();
    processOneFile (lit$0);
    SPLAPPTRC(L_DEBUG, "FileSource exiting...", SPL_OPER_DBG);
}

void MY_OPERATOR_SCOPE::MY_OPERATOR::allPortsReady()
{
    createThreads (1);
}



static SPL::Operator * initer() { return new MY_OPERATOR_SCOPE::MY_OPERATOR(); }
bool MY_BASE_OPERATOR::globalInit_ = MY_BASE_OPERATOR::globalIniter();
bool MY_BASE_OPERATOR::globalIniter() {
    instantiators_.insert(std::make_pair("inStream",&initer));
    return true;
}

template<class T> static void initRTC (SPL::Operator& o, T& v, const char * n) {
    SPL::ValueHandle vh = v;
    o.getContext().getRuntimeConstantValue(vh, n);
}

MY_BASE_OPERATOR::MY_BASE_OPERATOR()
 : Operator() {
    PE & pe = PE::instance();
    uint32_t index = getIndex();
    initRTC(*this, lit$0, "lit$0");
    addParameterValue ("file", SPL::ConstValueHandle(lit$0));
    (void) getParameters(); // ensure thread safety by initializing here
}
MY_BASE_OPERATOR::~MY_BASE_OPERATOR()
{
    for (ParameterMapType::const_iterator it = paramValues_.begin(); it != paramValues_.end(); it++) {
        const ParameterValueListType& pvl = it->second;
        for (ParameterValueListType::const_iterator it2 = pvl.begin(); it2 != pvl.end(); it2++) {
            delete *it2;
        }
    }
}




