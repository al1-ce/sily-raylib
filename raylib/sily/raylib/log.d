/// Imports traceLog as log and logLevels as enums
module sily.raylib.log;

public import sily.raylib.config: log = traceLog;
import sily.raylib.config: LogLevel;

enum TRACE = LogLevel.LOG_TRACE;
enum DEBUG = LogLevel.LOG_DEBUG;
enum INFO = LogLevel.LOG_INFO;
enum WARNING = LogLevel.LOG_WARNING;
enum ERROR =  LogLevel.LOG_ERROR;
enum FATAL =  LogLevel.LOG_FATAL;

