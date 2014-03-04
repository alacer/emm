// eJydUVFLwzAQ5v7K8Llpt6GjiDBbB3brFFIRn0Zosy22TcIltaa_13mxzynyUezi_04_06_0774zuglYxbTlGMcL0XAqZA0RhD7GMAoCYp3m5J5nPeZ0OnZuEy2LfBPly_0FN02TIXFKP18lO0XqSFclNNuSzdL5Ku3nHg_13oYoXD9WM4KcS0y921XqaLJ2f6oSgxK2Z_0dSlz2r_1Mt5uozxJ1GA69kkbYqxDo8yqO0VgUcgcAZK9aTjzkrDWEnjK1XSXUH9QrrI1mJSeoUb3z0pJXmquKN6RiloFUkvtLtwpbZj1d6ouLEwihNB_0QdMaqdiW8Q6yBrbfId13IOWt8_0NTIjRFKHg0UWuGP9P8ZCALw_0AqACSgUOyHhzKqZ3f8C5JUo7YG6EcbeftfvIPwCYiibBE




#include "./dbg.h"
using namespace SPL::_Operator;

#include <SPL/Runtime/Function/SPLFunctions.h>
#include <SPL/Runtime/Operator/Port/Punctuation.h>


#define MY_OPERATOR_SCOPE SPL::_Operator
#define MY_BASE_OPERATOR dbg_Base
#define MY_OPERATOR dbg$OP


#include <SPL/Runtime/Common/ApplicationRuntimeMessage.h>
#include <SPL/Runtime/Utility/LogTraceMessage.h>
#include <SPL/Runtime/Operator/OperatorMetrics.h>
#include <SPL/Toolkit/RuntimeException.h>
#include <streams_boost/filesystem/path.hpp>
#include <signal.h>


#define WARNANDTHROW(except,msg)                \
    do {                                        \
        const FormattableMessage& m = msg;      \
        SPLTRACEMSG (L_ERROR, m, SPL_FUNC_DBG); \
        THROW_STRING (except, m);               \
    } while (0)

using namespace std;
using namespace streams_boost::iostreams;

// substitute sequence numbers and date/time patterns in filename
std::string MY_OPERATOR_SCOPE::MY_OPERATOR::genFilename()
{
    // copy the pattern in preparation for creating the filename
    std::string pathName = _pattern;
    
    // convert the file sequence number into a string for the {id} substitution
    ostringstream s;
    s.imbue(locale::classic());
    s << _fileGeneration++;
    const string& id = s.str();
    
    // substitute the file sequence number for {id}
    string::size_type p;
    while ((p = pathName.find ("{id}")) != string::npos) {
        pathName.replace (p, 4, id);
    }
    
    // get the current time for the {localtime:format} and {gmtime:format} substitutions
    time_t now;
    time(&now);
    
    // substitute the time in the local timezone for the {localtime:format} pattern
    struct tm local_tm;
    localtime_r(&now, &local_tm);
    char buffer[1024*10];
    while ((p = pathName.find("{localtime:")) != string::npos) {
    	string::size_type q = pathName.find ("}", p);
        if (q == string::npos)
            WARNANDTHROW(SPLRuntimeFileSinkOperator, (SPL_APPLICATION_RUNTIME_FILESINK_BAD_PATTERN(_pattern)));
    	string format = pathName.substr(p+11, q-p-11);
    	strftime(buffer, sizeof(buffer), format.c_str(), &local_tm);
    	pathName.replace(p, q-p+1, buffer);
    }

    // substitute the time in the local timezone for the {gmtime:format} pattern
    struct tm gmt_tm;
    gmtime_r(&now, &gmt_tm);
    while ((p = pathName.find("{gmtime:")) != string::npos) {
    	string::size_type q = pathName.find ("}", p);
        if (q == string::npos)
            WARNANDTHROW(SPLRuntimeFileSinkOperator, (SPL_APPLICATION_RUNTIME_FILESINK_BAD_PATTERN(_pattern)));
    	string format = pathName.substr(p+8, q-p-8);
    	strftime(buffer, sizeof(buffer), format.c_str(), &gmt_tm);
    	pathName.replace(p, q-p+1, buffer);
    }

    // Anything left?
    if (!pathName.size())
        WARNANDTHROW(SPLRuntimeFileSinkOperator, SPL_APPLICATION_RUNTIME_FILESINK_EMPTY_FILENAME);

    return pathName;
}



void MY_OPERATOR_SCOPE::MY_OPERATOR::closeFile()
{
    if (!_f.get()) 
        return; // we don't want to do this twice

    delete _f.release();
    
    
    // close this file, and start a new one (if needed)
    
}

void MY_OPERATOR_SCOPE::MY_OPERATOR::closeAndReopen() {
    closeFile();
    // We need to reopen a new file if we are still running
    _pathName = genFilename();
    openFile();
}

MY_OPERATOR_SCOPE::MY_OPERATOR::Helper::Helper(const string& fName
                            )
: _fs(&_filt_str)


{
    SPLAPPTRC(L_DEBUG, "closeAndReopen '" << fName << "' as the output file...", SPL_OPER_DBG);

    
        _fd = ::open (fName.c_str(), O_WRONLY|O_CREAT|O_LARGEFILE|O_TRUNC, 0666);
    
    if (_fd < 0) 
        WARNANDTHROW (SPLRuntimeFileSinkOperator,
                SPL_APPLICATION_RUNTIME_FAILED_OPEN_OUTPUT_FILE(
                                                fName, RuntimeUtility::getErrorNoStr()));

    _fd_sink.reset (new file_descriptor_sink (_fd, true));
    
    _filt_str.push (*_fd_sink);
    _fs.imbue(locale::classic());
}

void MY_OPERATOR_SCOPE::MY_OPERATOR::openFile()
{
    if (!_shutdown) {
        _f.reset (new Helper(_pathName
                             ));
        _numFilesOpenedMetric.incrementValueNoLock();
        
    }
}

MY_OPERATOR_SCOPE::MY_OPERATOR::MY_OPERATOR()
: MY_BASE_OPERATOR(),
  _shutdown(false),
  _pattern (lit$0),
  _numFilesOpenedMetric(getContext().getMetrics().getCustomMetricByName("nFilesOpened")), 
  _numTupleWriteErrorsMetric(getContext().getMetrics().getCustomMetricByName("nTupleWriteErrors")),
  _fileGeneration(0)
  
  
  
  
{
    SPLAPPTRC(L_DEBUG, "FileSink startup...", SPL_OPER_DBG);
    _numFilesOpenedMetric.setValueNoLock(0);
    _numTupleWriteErrorsMetric.setValueNoLock(0);

    // Figure out output file and open it
    namespace bf = streams_boost::filesystem;
    
        _pathName = genFilename();
        openFile();
    
    
    
    
    
    
    signal(SIGPIPE,SIG_IGN);
}


void MY_OPERATOR_SCOPE::MY_OPERATOR::process(Punctuation const & punct, uint32_t port) {
    AutoMutex am(_mutex);
    if (_shutdown)
        return;
    try {
        
        
            
                    _f->flush();
        
    } catch (const std::exception& e) {
        SPLAPPTRC(L_ERROR, SPL_APPLICATION_RUNTIME_EXCEPTION(e.what()), SPL_OPER_DBG);
    } catch (...) {
        SPLAPPTRC(L_ERROR, SPL_APPLICATION_RUNTIME_UNKNOWN_EXCEPTION, SPL_OPER_DBG);
    }
    
    
}


void MY_OPERATOR_SCOPE::MY_OPERATOR::prepareToShutdown()
{
    AutoMutex am(_mutex);
    _shutdown = true;
    
        delete _f.release();
    
}

void MY_OPERATOR_SCOPE::MY_OPERATOR::process(Tuple const & tuple$, uint32_t port)
{
    AutoMutex am(_mutex);
    if (_shutdown)
        return;
    const IPort0Type iport$0 = static_cast<const IPort0Type&>(tuple$);

    

    // Write to output
    try {
        
        SPL::serializeWithPrecision(_f->writeTo(), iport$0.get_origin()) << ',';
	SPL::serializeWithPrecision(_f->writeTo(), iport$0.get_path()) << ',';
	SPL::serializeWithPrecision(_f->writeTo(), iport$0.get_prediction()) << '\n';

        
        if (!_f->fs()) {
            // The write failed for some reason.  Mark this as a failed write
            _numTupleWriteErrorsMetric.incrementValueNoLock();
            
        }
    } catch (const std::exception& e) {
        SPLAPPTRC(L_ERROR, SPL_APPLICATION_RUNTIME_EXCEPTION(e.what()), SPL_OPER_DBG);
    } catch (...) {
        SPLAPPTRC(L_ERROR, SPL_APPLICATION_RUNTIME_UNKNOWN_EXCEPTION, SPL_OPER_DBG);
    }
    
}

static SPL::Operator * initer() { return new MY_OPERATOR_SCOPE::MY_OPERATOR(); }
bool MY_BASE_OPERATOR::globalInit_ = MY_BASE_OPERATOR::globalIniter();
bool MY_BASE_OPERATOR::globalIniter() {
    instantiators_.insert(std::make_pair("dbg",&initer));
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
    param$format$0 = "csv";
    addParameterValue ("format", SPL::ConstValueHandle(param$format$0));
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

void MY_BASE_OPERATOR::tupleLogic(Tuple const & tuple, uint32_t port) {
}


void MY_BASE_OPERATOR::processRaw(Tuple const & tuple, uint32_t port) {
    tupleLogic (tuple, port);
    static_cast<MY_OPERATOR_SCOPE::MY_OPERATOR*>(this)->MY_OPERATOR::process(tuple, port);
}


void MY_BASE_OPERATOR::punctLogic(Punctuation const & punct, uint32_t port) {
}

void MY_BASE_OPERATOR::processRaw(Punctuation const & punct, uint32_t port) {
    punctLogic (punct, port);
    
    process(punct, port);
}




