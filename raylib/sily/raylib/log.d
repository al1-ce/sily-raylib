/++
Imports traceLog as log and logLevels as enums
Example:
---
log!TRACE("Trace message");
log("Log level DEBUG by default");
log!FATAL("Halt execution");
---
+/
module sily.raylib.log;

/// log!LOGLEVEL("MESSAGE"); or log("Debug message");
public import sily.raylib.config: log = traceLog;
import sily.raylib.config: LogLevel;

/// Trace messages (lowest priority)
alias trace = log!TRACE;
/// Ditto
enum TRACE = LogLevel.LOG_TRACE;

/// Debug messages, should be disabled on release
enum DEBUG = LogLevel.LOG_DEBUG;

/// Info messages
alias info = log!INFO;
/// Ditto
enum INFO = LogLevel.LOG_INFO;

/// Warning, possible error messages
alias warning = log!WARNING;
/// Ditto
enum WARNING = LogLevel.LOG_WARNING;

/// Error messages
alias error = log!ERROR;
/// Ditto
enum ERROR =  LogLevel.LOG_ERROR;

/// Fatal messages, closes program
alias fatal = log!FATAL;
/// Ditto
enum FATAL =  LogLevel.LOG_FATAL;

