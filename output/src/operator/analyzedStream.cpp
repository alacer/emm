// eJyVUs1qwkAQZl5FetBL1qjQIqWQxgqNpi1GKJ5kTbY6NcmG2Q3WPH03Jm1Rg1hyWDLM9zczoUwsXCWW0iR4oizKSH6KUA_0HsyAkzDTY0DVfD1qWxfQ_0E_0xReDvyg0Fvv1_1ak7m_1tP1JscgCt_1D27rb34q5lsO17c_1fWK_1y7kTMd5U4urE3rjEI2UDiOU8ydhSr7S9kY9U0XgrfpcEjGJKZrONTskxqwjUwEq3OwoHoDnUcoT_152krYq46FgP2nZe_0DLSMQs4ppDKlMBA8AUNfIYC65RptU0xhiLF54IOJE_1dtgug5KikJUcy4xEhKG2Zq0OONp0rHItxiQE0GVWu05_1DKoi_1tbUuRfMJBmctRZGnOtNuwNPX8aFUiYI0OuqzNyAO85QIo1jV6ZK87Q6hJq56rxii4BAh_1sBs0pJuEajX_0uV_1PAXtQuygfyfVwaJ0eufKtkfJJPnNMv15VlVMDOtY2tXoutJ19suJx2j0vd180PFM2vesW3yfwMQwidg


/* Additional includes go here */
#include <wait.h>
#include <streams_boost/iostreams/device/file_descriptor.hpp>
#include <streams_boost/iostreams/filtering_streambuf.hpp>
#include <streams_boost/lexical_cast.hpp>


using namespace std;
using namespace streams_boost::iostreams;



#include "./analyzedStream.h"
using namespace SPL::_Operator;

#include <SPL/Runtime/Function/SPLFunctions.h>
#include <SPL/Runtime/Operator/Port/Punctuation.h>

#include <string>

#define MY_OPERATOR_SCOPE SPL::_Operator
#define MY_BASE_OPERATOR analyzedStream_Base
#define MY_OPERATOR analyzedStream$OP





const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_START_BLOCK = string("SB5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_START_LINE = string("SL5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_END_LINE = string("EL5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_END_BLOCK = string("EB5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_END_ERROR = string("EE5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_DELIMITER = string("DL5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_NEWLINE = string("NL5:$Hj:Pf4RLB9%kULZZ");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::TOKEN_READERROR = string("RE5:$Hj:Pf4RLB9%kULZZ");
const char   MY_OPERATOR_SCOPE::MY_OPERATOR::OUTPUT_NOERROR = '0';
const char   MY_OPERATOR_SCOPE::MY_OPERATOR::OUTPUT_ERROR   = '1';

const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_NONE              = 0x01;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_TEXTONLY          = 0x02;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_TEXTSPECIAL       = 0x03;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_TEXTSPECIALFLOAT  = 0x04;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_TEXTSPECIALSTRING = 0x05;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_TEXTSPECIALBLOB   = 0x06;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_FLAG_TEXTSPECIALTIMESTAMP = 0x07;

const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NOEXISTS = 0x0001;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NA       = 0x0002;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NULL     = 0x0004;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NAN      = 0x0008;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_INF      = 0x0010;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NEG      = 0x0020;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NOTRAW   = 0x0040;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NOTTIMESTAMP = 0x0080;
const short  MY_OPERATOR_SCOPE::MY_OPERATOR::RVALUE_NOTCHAR  = 0x0100;

const string MY_OPERATOR_SCOPE::MY_OPERATOR::RTEXT_TRUE  = string("TRUE");
const string MY_OPERATOR_SCOPE::MY_OPERATOR::RTEXT_FALSE = string("FALSE");


//***************************************
// Constructor
//***************************************
MY_OPERATOR_SCOPE::MY_OPERATOR::MY_OPERATOR() : toRStream(NULL),
                             fromRStream(NULL),
                             fromRStderrStream(NULL),
                             rDead(false),
                             rShutdown(false)
{

  // Metrics initialization
  OperatorMetrics &opm = getContext().getMetrics();
  _failedTuples = &opm.getCustomMetricByName("failedTuples");

  // R Initialization code goes here
   rSetup();
}

//***************************************
// Destructor
//***************************************
MY_OPERATOR_SCOPE::MY_OPERATOR::~MY_OPERATOR() 
{
    if (toRStream) {
      *toRStream << "q()" << std::endl;
      delete toRStream;
    }
    if (fromRStream) delete fromRStream;
    if (fromRStderrStream) delete fromRStderrStream;
}


//***************************************
// Notify port readiness
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::allPortsReady() 
{ }

 
//***************************************
// Notify pending shutdown
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::prepareToShutdown() 
{
  // This is an asynchronous call
   
  stopR();

  const FormattableMessage &msg = R_PROCESS_ENDED(rPid);
  SPLAPPLOG(L_INFO, formatMsg(msg), "RScript");

}


//***************************************
// Threads for reading output from R
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::process(uint32_t idx)
{
  SPLAPPTRC(L_TRACE, "Process Thread (" << idx << ")", SPL_OPER_DBG);

  std::istream *readStream = NULL;
  Mutex        *lock = NULL;
  std::queue<std::string>   *queue = NULL;

  // Index 0 is for reading from R process stdout
  // Index 1 is for reading from R process stderr
  if (0 == idx) {
    readStream = fromRStream;
    lock = &fromRLock;
    queue = &fromRData;
  }
  else if (1 == idx) {
    readStream = fromRStderrStream;
    lock = &fromRStderrLock;
    queue = &fromRStderrData;
  }
  else
    return;

  while((readStream->good()) && (!rDead)) {
    string nextString;
    getline(*readStream, nextString);
    SPLAPPTRC(L_TRACE, "Read in thread " << idx << " (good:" << readStream->good() << "):  |" << nextString << "|", "RScript");

    {
      AutoMutex am(*lock);
      if (readStream->good())
        queue->push(nextString); 
      else
        queue->push(TOKEN_READERROR);
    }
  }

  return;
}


//***************************************
// Tuple processing for non-mutating ports 
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::process(Tuple const & tuple, uint32_t port) {

  SPLAPPTRC(L_TRACE, "Process Tuple " << tuple, "RScript");

  AutoMutex am(_mutex);

	SPLAPPTRC(L_DEBUG, "Process Tuple " << tuple, "RScript");
  // Set the input attributes in R
  const IPort0Type & ituple = static_cast<const IPort0Type &>(tuple);
  if (setRObjects(ituple))
    return;


  // Run the R script
  if (runRScript(ituple))
    return;


  // Set Streams output attributes, retrieving
  // valuesf from R when requested
  OPort0Type otuple;
  otuple.assignFrom(ituple, false);
  if (setStreamAttrs(ituple, otuple)) {
    return;
  }


  // Submit the output tuple
  submit(otuple, 0);

  return;
     
}


//***************************************
// Punctuation processing
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::process(Punctuation const & punct, uint32_t port)
{

  SPLAPPTRC(L_TRACE, "Process Punctuation " << punct, "RScript");
  
  if (0 == port) {
    forwardWindowPunctuation(punct);

    if (Punctuation::FinalMarker == punct) {
      AutoMutex am(_mutex);
      stopR();
    }
  } 
}


//***************************************
// Start R in a forked process
//***************************************
int MY_OPERATOR_SCOPE::MY_OPERATOR::rSetup() {
  // Fork/exec an R process.  Redirect stdin/stdout to a pipe
  int toRPipe[2];
  int fromRPipe[2];
  int fromRStderrPipe[2];

  if (-1 == pipe(toRPipe)) {
    stringstream ss;
    ss  << errno;
    const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("Error creating pipe 1: ") + ss.str());
    SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    const FormattableMessage msg2 = R_SHUTDOWN_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
    throw ROperatorShutdownException();
  }

  if (-1 == pipe(fromRPipe)) {
    stringstream ss;
    ss  << errno;
    const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("Error creating pipe 2: ") + ss.str());
    SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    const FormattableMessage &msg2 = R_SHUTDOWN_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
    throw ROperatorShutdownException();
  }

  if (-1 == pipe(fromRStderrPipe)) {
    stringstream ss;
    ss  << errno;
    const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("Error creating pipe 3: ") + ss.str());
    SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    const FormattableMessage msg2 = R_SHUTDOWN_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
    throw ROperatorShutdownException();
  }

  // Going to parse the rCommand parms before the fork
  // so that it is easier to log an error if something
  // goes wrong.
  // Parse the rCommand command into an array
  // that can be passed to execv

  vector<string> parmList;
  istringstream ss(rstring("/usr/bin/R --vanilla"));
  while (!ss.eof()) {
    string nextParm;
    getline(ss, nextParm, ' ');
    if (nextParm.size() > 0) {
      parmList.push_back(nextParm);
    }
  }
  if (0 == parmList.size()) {
    const FormattableMessage &msg = R_PROCESS_RCOMMAND_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    const FormattableMessage &msg2 = R_SHUTDOWN_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
    throw ROperatorShutdownException();
  }

  const char **parmArray = new const char*[parmList.size() + 1];
  for (int i=0; i < parmList.size(); i++) {
    parmArray[i] = parmList[i].c_str();
  } 
  parmArray[parmList.size()] = NULL;
  SPLAPPTRC(L_TRACE, "R command being run:  " << rstring("/usr/bin/R --vanilla"), "RScript");

  int rc = fork();
  if (-1 == rc) {
    stringstream ss;
    ss  << errno;
    const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("Fork error: ") + ss.str());
    SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    const FormattableMessage &msg2 = R_SHUTDOWN_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
    throw ROperatorShutdownException();
  }

  //child
  if (0 == rc) {

    if (-1 == dup2(toRPipe[0], 0)) {
      stringstream ss;
      ss  << errno;
      const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("dup2(1) error: ") + ss.str());
      SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
      const FormattableMessage &msg2 = R_SHUTDOWN_ERROR;
      SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
      throw ROperatorShutdownException();
    }

    if (-1 == dup2(fromRPipe[1], 1)) {
      stringstream ss;
      ss  << errno;
      const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("dup2(2) error: ") + ss.str());
      SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
      const FormattableMessage msg2 = R_SHUTDOWN_ERROR;
      SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
      throw ROperatorShutdownException();
    }

    if (-1 == dup2(fromRStderrPipe[1], 2)) {
      stringstream ss;
      ss  << errno;
      const FormattableMessage &msg = R_PROCESS_SETUP_ERROR(string("dup2(3) error: ") + ss.str());
      SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
      const FormattableMessage &msg2 = R_SHUTDOWN_ERROR;
      SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
      throw ROperatorShutdownException();
    }

    close(toRPipe[1]);
    close(fromRPipe[0]);
    close(fromRStderrPipe[0]);

    rc = execvp(parmArray[0],
               (char * const*)parmArray);
    if (-1 == rc) {
      delete [] parmArray;
      stringstream ss;
      ss  << errno;
      const FormattableMessage &msg = R_PROCESS_RUN_ERROR(string("Error invoking '") + rstring("/usr/bin/R --vanilla") + "'- " + strerror(errno) + "(" + ss.str() + ")");
      SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
      const FormattableMessage msg2 = R_SHUTDOWN_ERROR;
      SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
      throw ROperatorShutdownException();
    }
  }  // end if child


  // parent
  delete [] parmArray;
  rPid = rc;

  // stdout from child
  file_descriptor_source fdSrc(fromRPipe[0], false);
  //file_descriptor_source fdSrc(fromRPipe[0], never_close_handle);
  fromRSb.push(fdSrc);
  fromRStream = new istream(&fromRSb);  
  close(fromRPipe[1]);

  // stderr from child
  file_descriptor_source fdStderrSrc(fromRStderrPipe[0], false);
  //file_descriptor_source fdStderrSrc(fromRStderrPipe[0], never_close_handle);
  fromRStderrSb.push(fdStderrSrc);
  fromRStderrStream = new istream(&fromRStderrSb);  
  close(fromRStderrPipe[1]);

  // stdin of child
  file_descriptor_sink  fdSink(toRPipe[1], false);
  //file_descriptor_sink  fdSink(toRPipe[1], never_close_handle);
  toRSb.push(fdSink);
  toRStream = new ostream(&toRSb);
  close(toRPipe[0]);

  // Start the threads that will read stdout/stderr 
  // from the R process
  createThreads(2);

  // Turn off prompt for easier parsing of output
  *toRStream << "options(prompt=\" \")"
              << endl;

  // Attempt a little handshake with the R
  // process to see if the process is 
  // running as expected
  // If not, an exception will get thrown
  // within the readFromR method
  *toRStream << buildRNoErrorOutputStmt("\"STARTUP!\"", RVALUE_FLAG_NONE)
             << endl << endl;
  ROutput output = readFromR(RVALUE_FLAG_TEXTONLY);

  //  R Process appears to be started. Log the PID
  const FormattableMessage &msg = R_PROCESS_STARTUP_SUCCESS(rPid);
  SPLAPPLOG(L_INFO, formatMsg(msg), "RScript");



  // Load init script if one was specified as a parameter
  runInitScript();

 
  return 0;
}


//***************************************
// Read remaining entries from STDERR
// and STDOUT pipes.
// Called when operator (and R
// process) is shutting down.
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::drainPipes() {

  // Drain the error pipe
  string s;
  int shutdown = 0;
  while (!shutdown) {
    shutdown = readRStreamDataStderr(s);
    if ((!shutdown) && (s.length() > 0)) {
      const FormattableMessage &msg = R_STDERR(s);
      SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    }
  }

  // Drain the stdout pipe
  shutdown = 0;
  while (!shutdown) {
    shutdown = readRStreamDataStdout(s);
    if ((!shutdown) && (s.length() > 0)) {
      SPLAPPTRC(L_TRACE, "Stdout from R process:  " << s, "RScript,stdout");
    }
  }

  return;
}


//***************************************
// Tell the R process to end
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::stopR() {
  static bool stopped = false;
  if (!rShutdown) {
    if (toRStream->good()) {
      *toRStream << "q()"
                 << endl << endl;
      drainPipes();
      waitpid(rPid, NULL, 0);
      rShutdown = true;
    }
  }
  return;
}



void MY_OPERATOR_SCOPE::MY_OPERATOR::runInitScript() {
  *toRStream << "tryCatch({ "
             << "source("
             << SPL::rstring("../rsrc/init_predict.R")
             << ");"
             << buildRNoErrorOutputStmt("\"Init script ran\"", RVALUE_FLAG_NONE)
             << "}, error = function(ex) {"
             << buildRErrorOutputStmt("gsub(\"\\n\", \" \", paste(\"Error running init script\", ex, sep = ''))")
             << "})"
             << endl << endl;
  ROutput output = readFromR(RVALUE_FLAG_NONE);
  if (OUTPUT_ERROR == output.rc) {
    readFromRStderr();
    for (int i=0; i < output.entries.size(); i++) {
      const FormattableMessage &msg = R_INIT_SCRIPT_ERROR(SPL::rstring("../rsrc/init_predict.R"),
                                       i+1, 
                                       output.entries.size(),
                                       output.entries[i].value);
      SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    }
    stopR();
    FormattableMessage msg = R_SHUTDOWN_ERROR;
    SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
    throw ROperatorShutdownException();
  }
  return;
}






//**************************************************
// Set the objects in the R process based
// on values from the input streams attributes
//**************************************************
int MY_OPERATOR_SCOPE::MY_OPERATOR::setRObjects(const IPort0Type &ituple) {

  {

    stringstream ss;
    ss << SPL::port_cast<IPort0Type>(ituple).get_path();
    *toRStream << SPL::rstring("path").c_str()
               << "="
               << ss.str()
               << endl;

  }

  return 0;
}  // setRObjects


//**************************************************
// Run the R script
//**************************************************
int MY_OPERATOR_SCOPE::MY_OPERATOR::runRScript(const IPort0Type &ituple) {

  std::string rscriptName = lit$0;
  *toRStream << "tryCatch({"
             << "source(\"" 
             << rscriptName 
             << "\");"
             << buildRNoErrorOutputStmt("\"Script ran\"", RVALUE_FLAG_NONE)
             << "}, error = function(ex) {"
             << buildRErrorOutputStmt("gsub(\"\\n\", \" \", paste(\"Error running script\", ex, sep = ''))")
             << "})"
             << endl << endl;
  ROutput output = readFromR(RVALUE_FLAG_NONE);
  if (OUTPUT_ERROR == output.rc) {
    list <rstring> messages = readFromRStderr(false);
    for (int i = 0; i < output.entries.size(); i++) {
      const FormattableMessage &msg = R_PROCESS_SCRIPT_ERROR(rscriptName,
                                                            i+1,
                                                            output.entries.size(),
                                                            output.entries[i].value);
      messages.push_back(formatMsg(msg));
    }
    handleProcessError(messages, ituple);
    return(-1);
  } 

  return 0;
} // runRScript


//**************************************************
// Set output attributes
//**************************************************
int MY_OPERATOR_SCOPE::MY_OPERATOR::setStreamAttrs(const IPort0Type &ituple,
                                OPort0Type &otuple) {

  // Set attribute origin
  otuple.set_origin(SPL::port_cast<IPort0Type>(ituple).get_origin());

  // Set attribute path
  otuple.set_path(SPL::port_cast<IPort0Type>(ituple).get_path());

  // Capture value for attribute prediction from R
  {


    short rFlags = RVALUE_FLAG_TEXTSPECIALSTRING;

    *toRStream << "tryCatch({ "
               << buildRNoErrorOutputStmt((string)lit$1, rFlags)
               << "}, error = function(ex) {"
               << buildRErrorOutputStmt("gsub(\"\\n\", \" \", paste(\"Error reading R variable\", ex, sep = ' '))")
               << "})"
               << endl << endl << flush;
    ROutput output = readFromR(rFlags);
    if (OUTPUT_ERROR == output.rc) {
      list <rstring> messages = readFromRStderr(false);
      for (int i=0; i < output.entries.size(); i++) {
        const FormattableMessage &msg = R_OUTPUT_ASSIGNMENT_ERROR("prediction",
                                                              i,
                                                              output.entries.size(),
                                                              output.entries[i].value);
        messages.push_back(formatMsg(msg));
      }
      handleProcessError(messages, ituple);
      return(-1);
    }

    // Value retrieve from R successfully, convert to output tuple
    else {

      SPL::list<rstring> newList;
      for (int i=0;i < output.entries.size(); i++) {
        rstring sVal;
        if (RVALUE_NOEXISTS & output.entries[i].flag) {
          const FormattableMessage &msg = R_ROBJECT_NOEXIST_ERROR(lit$1);
          handleProcessError(formatMsg(msg), ituple);
          return(-1);
        }
        else if (RVALUE_NOTCHAR & output.entries[i].flag) {
          const FormattableMessage &msg = R_CONVERT_ROBJECT_ERROR(output.entries[i].value,
                                                           "prediction",
                                                           "list<rstring>");
          handleProcessError(formatMsg(msg), ituple);
          return(-1);
        }
        else if (RVALUE_NA & output.entries[i].flag) {
          sVal = rstring("");
        }
        else if (0 == (RVALUE_NULL & output.entries[i].flag)) {

          sVal = output.entries[i].value;

        }
        if (0 == (RVALUE_NULL & output.entries[i].flag)) 
          newList.push_back(sVal);
      }
      otuple.set_prediction(newList);

    }
  }

  return 0;
}


//***************************************
// Handle errors that occur when
// processing a tuple (non-fatal)
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::handleProcessError(list<rstring> &messages,
                                    const IPort0Type &ituple) {

  for (int i=0; i < messages.size(); i++) {
    SPLAPPLOG(L_ERROR, messages[i], "RScript");
  }
  const FormattableMessage & msg = R_TUPLE_NOT_GENERATED;
  SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");



  // Increment failedTuples metric
  _failedTuples->incrementValue(1);

  return;
}


//***************************************
// Handle errors that occur when
// processing a tuple (non-fatal)
//***************************************
void MY_OPERATOR_SCOPE::MY_OPERATOR::handleProcessError(string msg,
                                    const IPort0Type &ituple) {
  list<rstring> messages;
  messages.push_back(msg);
  handleProcessError(messages, ituple);
  return;
}


//***************************************
// Read expected output from the R
// process' stdout pipe
//***************************************
int MY_OPERATOR_SCOPE::MY_OPERATOR::readRStreamData(std::queue<std::string> &q,
                                 Mutex &lock,
                                 std::string &s) {
  bool foundData = false;
  bool shutdown = false;
  while ((!foundData) && (!shutdown)) {
    {
      AutoMutex am(lock);
      if (q.size() > 0) {
        s = q.front();
        if (TOKEN_READERROR == s)
          shutdown = true;
        else
          q.pop();
        foundData = true;
      }
    }
    if (!foundData) {
      // .000050 seconds = 50 microseconds
      bool shutdown = getPE().blockUntilShutdownRequest((double) .000050);
    }
  }  // end while

  if (shutdown)
    return 1;
  else
    return 0;
}


//*********************************
// Read expected output from the R
// process' stdout pipe
//***************************************
MY_OPERATOR_SCOPE::MY_OPERATOR::ROutput MY_OPERATOR_SCOPE::MY_OPERATOR::readFromR(short rflag) {

  string  raw;
  string  nextOutput;
  boolean blockStarted = false;
  boolean blockEnded = false;
  boolean lineStarted = false;
  int emptyCount = 0;  // just a safety catch if something goes amiss
  int shutdown = 0;
  ROutput output; 
  do {
    shutdown = readRStreamDataStdout(raw);
    if (!shutdown) {
      if (raw.size() == 0) 
        emptyCount++;
      else {
        SPLAPPTRC(L_TRACE, "Stdout from R process:  " << raw, "RScript,stdout");
					
		
        // Need to find start of block if we haven't done so
        // Check for start of a new block.  Note we could
        // find a start block while we think we are in the middle of 
        // another block.  This would happen on the case of 
        // capturing an output assignment where an exception 
        // is thrown capturing the value.
        if (raw.substr(0, TOKEN_START_BLOCK.size()) == TOKEN_START_BLOCK) {
          if (blockStarted)
            nextOutput = "";
          else
            blockStarted = true;
          output.rc = raw[TOKEN_START_BLOCK.size()];
        }  // If we found TOKEN_START_BLOCK

        // Check for the end of the block
        else if (raw == TOKEN_END_BLOCK) {
          blockEnded = true;
        } // if end of block

        // Check for start of a new line
        else if (!lineStarted) {
          if (raw.substr(0, TOKEN_START_LINE.size()) == TOKEN_START_LINE) {
            raw = raw.substr(TOKEN_START_LINE.size());

            // Check for end line marker in same buffer as start line marker
            if ((raw.size() >= TOKEN_END_LINE.size()) &&
                (raw.substr(raw.size() - TOKEN_END_LINE.size()) == 
                                TOKEN_END_LINE)) {
              string s = raw.substr(0, raw.size() - 
                                    TOKEN_END_LINE.size()); 
                                   
              ROutputEntry nextEntry = checkForSpecialValues(s, rflag); 
               SPLAPPTRC(L_DEBUG, "output from R process:  " << s, "RScript,stdout");
              output.entries.push_back(nextEntry); 
            } //if we found end line marker on same line as start marker
            else {
              nextOutput = raw;
              lineStarted = true;
            }  // else we didn't find end line marker on same line as start 
 
          } // if found start line marker
          else {
            // Should never get here
          } // if !lineStarted and did not find start marker
        }  // if line not started

        // Else we have a previously started line that we need to continue
        else {
          // Check for end line marker
            if ((raw.size() >= TOKEN_END_LINE.size()) &&
                (raw.substr(raw.size() - TOKEN_END_LINE.size()) == 
                                TOKEN_END_LINE)) {
              string s = nextOutput + 
                          raw.substr(0, raw.size() - 
                          TOKEN_END_LINE.size()); 
              ROutputEntry nextEntry = checkForSpecialValues(s, rflag); 
               SPLAPPTRC(L_DEBUG, "output from R process:  " << s, "RScript,stdout");
              output.entries.push_back(nextEntry); 
              lineStarted = false;
              nextOutput = "";
            }  // if found end line marker
            // else we just need to keep buiding the string
            else {
              nextOutput = nextOutput + raw;
            }  // Keep building the string
        } // else we have previously started line
      }  // else not reading an empty string
    }  // if !shutdown
  } while ((!blockEnded) && 
           (emptyCount <= 10) &&
           (!shutdown));

  // Check to make sure that R process is not dead
  if ((emptyCount > 10) ||
      (shutdown)) {
    if (!checkChildProcess()) {
      rDead = true;
      if (!rShutdown) {
        drainPipes();
        const FormattableMessage &msg = R_PROCESS_RUN_ERROR("R process not running as expected. Perhaps it never started.");
        SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
        const FormattableMessage msg2 = R_SHUTDOWN_ERROR;
        SPLAPPLOG(L_ERROR, formatMsg(msg2), "RScript");
      }
      throw ROperatorShutdownException();
    }

  }
  return(output);
}


//***************************************
// Check for certain special values dependending on what
// flag is passed in.
//***************************************
MY_OPERATOR_SCOPE::MY_OPERATOR::ROutputEntry MY_OPERATOR_SCOPE::MY_OPERATOR::checkForSpecialValues(
                                 const string &s, 
                                 short rflag) {

  ROutputEntry newEntry;
  newEntry.flag = 0x00;

  list<rstring> values = parseSpecialValues(s);

  // Signed, Unsigned, Boolean, Complex, Decimal
  if (RVALUE_FLAG_TEXTSPECIAL == rflag) {
    string value = values[0];
    bool exists = checkBoolString(values[1]);
    bool isNA = checkBoolString(values[2]);
    bool isNULL = checkBoolString(values[3]);
    newEntry.value = value;
    if (!exists)
      newEntry.flag = RVALUE_NOEXISTS;
    else if (isNA)
      newEntry.flag = RVALUE_NA;
    else if (isNULL)
      newEntry.flag = RVALUE_NULL; 
  }

  // string, xml
  else if (RVALUE_FLAG_TEXTSPECIALSTRING == rflag) {
    string value = values[0];
    bool exists = checkBoolString(values[1]);
    bool isNA = checkBoolString(values[2]);
    bool isNULL = checkBoolString(values[3]);
    bool isChar = checkBoolString(values[4]);
    newEntry.value = value;
    if (!exists)
      newEntry.flag = RVALUE_NOEXISTS;
    else if (isNA)
      newEntry.flag = RVALUE_NA;
    else if (isNULL)
      newEntry.flag = RVALUE_NULL; 
    else if (!isChar)
      newEntry.flag = RVALUE_NOTCHAR;
    replaceString(newEntry.value, TOKEN_NEWLINE, "\n");
  }

  // float
  else if (RVALUE_FLAG_TEXTSPECIALFLOAT == rflag) {
    string value = values[0];
    bool exists = checkBoolString(values[1]);
    bool isNAN = checkBoolString(values[2]);
    bool isINF = checkBoolString(values[3]);
    bool isNegative = checkBoolString(values[4]);
    bool isNA = checkBoolString(values[5]);
    bool isNULL = checkBoolString(values[6]);
    newEntry.value = value;
    if (!exists)
      newEntry.flag = RVALUE_NOEXISTS;
    else if (isNAN)
      newEntry.flag = RVALUE_NAN;
    else if (isINF) {
      if (isNegative)
        newEntry.flag = RVALUE_INF | RVALUE_NEG;
      else
        newEntry.flag = RVALUE_INF;
    }
    else if (isNA)
      newEntry.flag = RVALUE_NA;
    else if (isNULL)
      newEntry.flag = RVALUE_NULL; 
  }

  // Check for  exists, NA, NULL, is-POSIXct
  // timestamp
  else if (RVALUE_FLAG_TEXTSPECIALTIMESTAMP == rflag) {
    string value = values[0];
    bool exists = checkBoolString(values[1]);
    bool isNA = checkBoolString(values[2]);
    bool isNULL = checkBoolString(values[3]);
    bool isTimestamp = checkBoolString(values[4]);
    newEntry.value = value;
    if (!exists)
      newEntry.flag = RVALUE_NOEXISTS;
    else if (isNA)
      newEntry.flag = RVALUE_NA;
    else if (isNULL)
      newEntry.flag = RVALUE_NULL; 
    else if (!isTimestamp)
      newEntry.flag = RVALUE_NOTTIMESTAMP;
  }

  // blob
  else if (RVALUE_FLAG_TEXTSPECIALBLOB == rflag) {
    string value = values[0];
    bool exists = checkBoolString(values[1]);
    bool isNA = checkBoolString(values[2]);
    bool isNULL = checkBoolString(values[3]);
    bool isRaw = checkBoolString(values[4]);
    newEntry.value = value;
    if (!exists)
      newEntry.flag = RVALUE_NOEXISTS;
    else if (isNA)
      newEntry.flag = RVALUE_NA;
    else if (isNULL)
      newEntry.flag = RVALUE_NULL; 
    else if (!isRaw) 
      newEntry.flag = RVALUE_NOTRAW;
  }

  // Don't check for any special values
  else {
    newEntry.value = s;
  }

  return(newEntry);
}


//***************************************
// Parse out delimited values
//***************************************
SPL::list<SPL::rstring> MY_OPERATOR_SCOPE::MY_OPERATOR::parseSpecialValues(const string &s) {

  list<rstring> values;

  string remaining = s;
  bool oneMore = false;
  while (remaining.size() > 0) {
    size_t pos = remaining.find(TOKEN_DELIMITER);
    string nextString;
    if (std::string::npos != pos) {
      nextString =  remaining.substr(0, pos);
      remaining = remaining.substr(pos + TOKEN_DELIMITER.size());
      if (0 == remaining.size()) 
        oneMore = true;
    }
    else {
      nextString = remaining;
      remaining = "";
    }
    values.push_back(nextString);
  }
  if (oneMore)
    values.push_back(""); // extra one when last value is blank

  return(values); 
}


//***************************************
// Read and log from the R process'
// stderr pipe
//***************************************
SPL::list<SPL::rstring> MY_OPERATOR_SCOPE::MY_OPERATOR::readFromRStderr(bool logMessages) {

  list<rstring> messages;

  // First write to stderr so we will know
  // later when to stop reading.
  *toRStream << "write(\""
             << TOKEN_END_ERROR
             << "\", stderr())" 
             << endl << endl << flush; 

  string(s);
  boolean foundEnd = false;
  int emptyCount = 0;
  int shutdown = 0;
  do {
    shutdown = readRStreamDataStderr(s);
    if (!shutdown) {
      if (s.size() == 0) 
        emptyCount++;
      else {
        if (s == TOKEN_END_ERROR) {
          foundEnd = true;
        }
        else {
          const FormattableMessage &msg = R_STDERR(s);
          if (logMessages)
            SPLAPPLOG(L_ERROR, formatMsg(msg), "RScript");
          messages.push_back(formatMsg(msg));
        }
        emptyCount = 0;
      } // end if size not 0
    }  // end !shutdown
  } while ((foundEnd == false) && (!shutdown) && (emptyCount <= 10));

  return(messages);
}


//***************************************
// Build an R statement that will output the 
// eye catchers string followed by some desired text
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildROutputStmt(const string &s,
                                     const char msgType) {
  stringstream ss;
  ss << "write(\"\n"
     << TOKEN_START_BLOCK
     << msgType
     << "\", stdout())"
     << endl;
  if (s.length() > 0)
    ss << "write(paste(\""
       << TOKEN_START_LINE
       << "\","
       << s
       << ",\""
       << TOKEN_END_LINE
       << "\", sep = ''), stdout())" 
       << endl;
  ss << "write(\""
     << TOKEN_END_BLOCK
     << "\", stdout())"
     << endl << endl << flush; 
  return(ss.str());
}


//***************************************
// Build R statement that will get output when no
// error occurs
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildRNoErrorOutputStmt(const string &s,
                                            short rflag) {
  switch (rflag) {

    // No Text to be spit out.  Just a startblock/endblock
    case RVALUE_FLAG_NONE:
      return(buildROutputStmt("", OUTPUT_NOERROR));
      break;

    // Text only.  No checking for special values
    case RVALUE_FLAG_TEXTONLY:
      return(buildROutputStmt(s, OUTPUT_NOERROR));
      break;

    // Check for NA and NULL
    case RVALUE_FLAG_TEXTSPECIAL:
      return(buildROutputStmt(buildRCaptureValueStmt(s), OUTPUT_NOERROR));
      break;

    // Check for NA, NULL, Nan, and Inf
    case RVALUE_FLAG_TEXTSPECIALFLOAT:
      return(buildROutputStmt(buildRCaptureFloatValueStmt(s), OUTPUT_NOERROR));
      break;

    // Check for NA and NULL and NEWLINE
    case RVALUE_FLAG_TEXTSPECIALSTRING:
      return(buildROutputStmt(buildRCaptureStringValueStmt(s), OUTPUT_NOERROR));
      break;

    // Check for NA and NULL and NEWLINE
    case RVALUE_FLAG_TEXTSPECIALTIMESTAMP:
      return(buildROutputStmt(buildRCaptureTimestampValueStmt(s), OUTPUT_NOERROR));
      break;

    // Blobs are going to call a special function
    case RVALUE_FLAG_TEXTSPECIALBLOB:
      return(buildROutputBlobStmt(s));
      break;


  }  // end switch
  return(buildROutputStmt(s, OUTPUT_NOERROR));
}


//***************************************
// Special code to capture the contents of a blob
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildROutputBlobStmt(const string &s) {
  stringstream ss;
  ss << "write(\"\n"
     << TOKEN_START_BLOCK
     << OUTPUT_NOERROR
     << "\", stdout())"
     << endl
     << "write(cat(\""
     << TOKEN_START_LINE
     << "\",if (exists(\""
     << s
     << "\")) "
     << s
     << ",\""
     << TOKEN_DELIMITER
     << "\",exists(\""
     << s
     << "\"),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) is.na("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) is.null("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) is.raw("
     << s
     << "),\""
     << TOKEN_END_LINE
     << "\", sep = ''), stdout())" 
     << endl
     << "write(\""
     << TOKEN_END_BLOCK
     << "\", stdout())"
     << endl << endl << flush; 
  return(ss.str());
}


//***************************************
// Build R statement that will retrieve a value and check
// for these special values:
//   NA
//   NULL
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildRCaptureValueStmt(const string &s) {
  stringstream ss;
  ss << "if (exists(\""
     << s
     << "\")) "
     << s
     << ",\""
     << TOKEN_DELIMITER
     << "\",exists(\""
     << s
     << "\"),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) is.na("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) is.null("
     << s
     << ")";
     
  return(ss.str());
}


//***************************************
// Build R statement that will retrieve a value and check
// for these special values:
//   NA
//   NULL
//   Inf
//   NaN
//   > 0 (to check for negativie infinity)
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildRCaptureFloatValueStmt(const string &s) {
  stringstream ss;
  ss << "if (exists(\""
     << s
     << "\")) "
     << s
     << ",\""
     << TOKEN_DELIMITER
     << "\",exists(\""
     << s
     << "\"),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) is.nan("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) is.infinite("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) "
     << s
     << " < 0,\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) is.na("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
      << "\")) is.null("
     << s
     << ")";
     
  return(ss.str());
}


//***************************************
// Build R statement that will retrieve a value and check
// for these special values:
//   NA
//   NULL
//  is.character
// Also replaces \n with our NEWLINE token
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildRCaptureStringValueStmt(const string &s) {
  stringstream ss;
  ss << "if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) gsub(pattern=\"\\n\", replacement=\""
     << TOKEN_NEWLINE
     << "\", x="
     << s
     << ", fixed=TRUE),\""
     << TOKEN_DELIMITER
     << "\",exists(\""
     <<  s
     << "\"),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     <<  s
     << "\")) if (!is.null("
     << s
     << ")) is.na("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) is.null("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     <<  s
     << "\")) if (!is.null("
     << s
     << ")) is.character("
     << s
     << ")";

  return(ss.str());
}


//***************************************
// Build R statement that will retrieve a value and check
// for these special values:
//   NA
//   NULL
// Will use the format function to format timestamp
// in a format we can use
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::buildRCaptureTimestampValueStmt(const string &s) {
  stringstream ss;
  ss << "if (exists(\""
     << s
     << "\")) if (inherits("
     << s
     << ", \"POSIXct\")) format("
     << s
     << ", \"%Y-%m-%d %H:%M:%OS6\") else \"\""
     << ",\""
     << TOKEN_DELIMITER
     << "\",exists(\""
     << s
     << "\"),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) if (!is.null("
     << s
     << ")) is.na("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) is.null("
     << s
     << "),\""
     << TOKEN_DELIMITER
     << "\",if (exists(\""
     << s
     << "\")) inherits("
     << s
     << ", \"POSIXct\")";
     
  return(ss.str());
}


//***************************************
// Utility function to replace
// contens of a string 
//***************************************
string & MY_OPERATOR_SCOPE::MY_OPERATOR::replaceString(std::string& s, 
                                const std::string& search,
                                const std::string& replace) {
  size_t p = 0;
  while((p = s.find(search, p)) != std::string::npos) {
     s.replace(p, search.length(), replace);
     p += replace.length();
  }
  return(s);
}


//***************************************
// Check if the R process is still active
//***************************************
bool MY_OPERATOR_SCOPE::MY_OPERATOR::checkChildProcess() {
  int status;
  if (0 == waitpid(rPid, &status, WNOHANG))
    return(true);
  else 
    return(false);
}



////////////////////////////////
////////////////////////////////
// Conversion routines
////////////////////////////////
////////////////////////////////


//***************************************
// float to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const float64 f) {

  string s = streams_boost::lexical_cast<std::string>(f);
  return(s);
}


//***************************************
// string to float
//***************************************
SPL::float64 MY_OPERATOR_SCOPE::MY_OPERATOR::toFloat64(const string &s, int *status) {

  *status = 0;
  float64 f = 0.0;

  try {
    f = streams_boost::lexical_cast<float64>(s);
  }
  catch (const streams_boost::bad_lexical_cast &) {
    *status = -1;
  }
  return(f);
}


//***************************************
// complex to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const complex64 c) {

  string realPart = streams_boost::lexical_cast<std::string>(c.real()); 
  string imagPart = streams_boost::lexical_cast<std::string>(c.imag()); 
  stringstream ss;
  ss << realPart
     << "+"
     << imagPart
     << "i";

  return(ss.str());
}


//***************************************
// string to complex
//***************************************
SPL::complex64 MY_OPERATOR_SCOPE::MY_OPERATOR::toComplex64(const string &s, int *status) {

  // Look for a plus/minus NOT in the first position
  size_t signPos = s.find('+', 1);
  char   signChar = 0x00;
  if (string::npos != signPos)
    signChar = '+';
  else {
    signPos = s.find('-', 1);
    if (string::npos != signPos) 
      signChar = '-';
  }

  // If no signChar, then assume number just 
  // contains a real part
  float64 realPart = 0.0;
  float64 imagPart = 0.0;
  if (!signChar) {
    realPart = toFloat64(s, status);
  }
  else {
    realPart = toFloat64(s.substr(0, signPos), status);
    if (!*status) {
      imagPart = toFloat64(string(1, signChar) + s.substr(signPos + 1, s.length() - signPos - 2), status);
    }
  }

  if (*status)
    return(0);
  else { 
    complex64 c(realPart, imagPart);
    return(c);
  }
}


//***************************************
// decimal to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const decimal128 d) {
  // lexical cast truncates digits for decimal128 (??)
  //string s = streams_boost::lexical_cast<std::string>(d);
  //return(s);
  stringstream ss;
  ss.precision(17);
  ss << d;
  return(ss.str());
}


//***************************************
// string to decimal
//***************************************
SPL::decimal128 MY_OPERATOR_SCOPE::MY_OPERATOR::toDecimal128(const string &s, int *status) {

  *status = 0;
  decimal128 d = (decimal128) 0;

  try {
    d = streams_boost::lexical_cast<decimal128>(s);
  }
  catch (const streams_boost::bad_lexical_cast &) {
    *status = -1;
  }
  return(d);
}


//***************************************
// int to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const int64 i) {
  string s = streams_boost::lexical_cast<std::string>(i);
  return(s);
}


//***************************************
// string to int
//***************************************
SPL::int64 MY_OPERATOR_SCOPE::MY_OPERATOR::toInt64(const string &s, int *status) {

  *status = 0;
  int64 i = 0;

  try {
    i = streams_boost::lexical_cast<int64>(s);
  }
  catch (const streams_boost::bad_lexical_cast &) {
    *status = -1;
  }
  return(i);
}


//***************************************
// uint to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const uint64 u) {
  string s = streams_boost::lexical_cast<std::string>(u);
  return(s);
}


//***************************************
// string to uint
//***************************************
SPL::uint64 MY_OPERATOR_SCOPE::MY_OPERATOR::toUint64(const string &s, int *status) {

  *status = 0;
  uint64 u = 0;

  try {
    u = streams_boost::lexical_cast<uint64>(s);
  }
  catch (const streams_boost::bad_lexical_cast &) {
    *status = -1;
  }
  return(u);
}


//***************************************
// boolean to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const boolean b) {
  if (b)
    return(RTEXT_TRUE);
  else
    return(RTEXT_FALSE);
}


//***************************************
// string to boolean
//***************************************
SPL::boolean MY_OPERATOR_SCOPE::MY_OPERATOR::toBoolean(const string &s, int *status) {
  *status = 0;
  if (RTEXT_TRUE == s)
    return(true);
  else if (RTEXT_FALSE == s)
    return(false);
  else {
    *status = -1;
    return(false);
  }
}


//***************************************
// timestamp to string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::toString(const timestamp &ts) {
  uint64 seconds = ts.getSeconds();
  uint32 nSeconds = ts.getNanoseconds();
  time_t timer = static_cast<time_t>(seconds);
  struct tm lTime = {0};
  localtime_r(&timer, &lTime);
  char buf[24];
  strftime(buf,
           sizeof(buf),
           "%Y-%m-%d %H:%M:%OS.",
           &lTime);
  stringstream nanoss;
  nanoss << fixed << ((float64)nSeconds / 1000000000);
  stringstream ss;
  ss << buf
     //<< (uint32)(nSeconds / 1000);
     << nanoss.str().substr(2);
  return(ss.str());
}


//***************************************
// string to timestamp
//***************************************
SPL::timestamp MY_OPERATOR_SCOPE::MY_OPERATOR::toTimestamp(const string &s, int *status) {

  *status = 0;

  // Find the last period
  size_t pos = s.find_last_of(".");
  string firstPart = s.substr(0, pos);
  string secondPart = string("0") + s.substr(pos);
  struct tm tm;
  memset(&tm, 0, sizeof(tm));
  strptime(firstPart.c_str(), "%Y-%m-%d %H:%M:%S", &tm);
  time_t timer = mktime(&tm);
  uint64 seconds = static_cast<uint64> (timer);
  float64 nSeconds;
  istringstream(secondPart) >> nSeconds;
  nSeconds = nSeconds * 1000000000;
  timestamp ts = SPL::Functions::Time::createTimestamp(seconds, (int32)nSeconds);

  return(ts);
}


//***************************************
// blob to raw vector string
//***************************************
string MY_OPERATOR_SCOPE::MY_OPERATOR::blobToRawVector(const blob &b) {
  stringstream ss;
  ss << "as.raw(c(";
  bool first = true;
  string comma("");
  for (uint64_t i=0; i < b.getSize(); i++) {
    ss << comma <<(int16) b[i];
    if (first) {
      first = false;
      comma = ",";
    }
  }
  ss << "))";
  return(ss.str());
}


//***************************************
// raw vector string to blob
//***************************************
SPL::blob MY_OPERATOR_SCOPE::MY_OPERATOR::rawVectorToBlob(const string &s) {

  blob b;
  for(int i=0; i < s.length(); i=i+2) {
    string nextChar = s.substr(i, 2);
    uint16 byt;
    istringstream(nextChar) >> hex >> byt;
    b += byt; 
  }

  return(b);
}

static SPL::Operator * initer() { return new MY_OPERATOR_SCOPE::MY_OPERATOR(); }
bool MY_BASE_OPERATOR::globalInit_ = MY_BASE_OPERATOR::globalIniter();
bool MY_BASE_OPERATOR::globalIniter() {
    instantiators_.insert(std::make_pair("analyzedStream",&initer));
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
    initRTC(*this, lit$1, "lit$1");
    param$initializationScriptFileName$0 = SPL::rstring("../rsrc/init_predict.R");
    addParameterValue ("initializationScriptFileName", SPL::ConstValueHandle(param$initializationScriptFileName$0));
    addParameterValue ("rScriptFileName", SPL::ConstValueHandle(lit$0));
    addParameterValue ("streamAttributes");
    param$rObjects$0 = SPL::rstring("path");
    addParameterValue ("rObjects", SPL::ConstValueHandle(param$rObjects$0));
    (void) getParameters(); // ensure thread safety by initializing here
    $oportBitset = OPortBitsetType(std::string("01"));
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
    
    if (punct == Punctuation::FinalMarker) {
        process(punct, port);
        bool forward = false;
        {
            AutoPortMutex $apm($fpMutex, *this);
            $oportBitset.reset(port);
            if ($oportBitset.none()) {
                $oportBitset.set(1);
                forward=true;
            }
        }
        if(forward)
            submit(punct, 0);
        return;
    }
    
    process(punct, port);
}








