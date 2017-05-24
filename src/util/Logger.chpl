/* Logger.chpl
 * Description: Creates and maintains a log file.
 * Created by Matthew Sedam on 3/15/2017.
 *
 * Copyright 2017 Matthew Sedam.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

use DateTime;
use FileSystem;
use IO;
use Path;
use SysError;

// Enumeration of different levels for log events
extern {
    enum LogLevel {
        INFO, WARNING, ERROR
    };
}

/**
 * Creates and maintains a log file
 */
class Logger {
    var logFile : file;
    var logFilePath : string;
    var logFileWriter : channel(true, iokind.dynamic, true);
    var monthDom : domain(int);
    var monthMap : [monthDom] string;

    /**
     * Default constructor
     * Creates a log file if it does not exist in the user's home directory.
     *         If it exists, it will be written over. Outputs log file header
     *         to file.
     */
    proc Logger() {
        initializeMonthMap();

        logFilePath = getHomeDir() + pathSep + ".cryptotrade.log";
        logFile = open(logFilePath, iomode.cwr);
        logFileWriter = logFile.writer();

        outputLogHeader();
    }

    /**
     * Alternate constructor
     * Creates log file at path. If it exists, it will be written over.
     * Outputs log file header to file at path.
     */
    proc Logger(path : string) {
        initializeMonthMap();

        logFilePath = path;
        logFile = open(logFilePath, iomode.cwr);
        logFileWriter = logFile.writer();

        outputLogHeader();
    }

    /**
     * Destructor
     */
    proc deinit() {
        logFileWriter.flush();
        logFile.fsync();
        logFile.close();
    }

    /**
     * log
     * Logs an event to the log
     *
     * message - the message to log
     * level   - the level at which to log
     *
     * Note: The level is INFO, WARNING, or ERROR. These are enumerated values
     *       in an extern C block. These were not enumerated in Chapel becuase
     *       an internal error is thrown at the time of writing this. level is
     *       of type c_int as this is what the extern C block enum will create
     *       it as. This function defaults to ERROR.
     */
    proc log(message : string, level : c_int) {
        var line = getDateTimeStr() + " ";
        var levelStr : string;

        if (level == INFO) {
            levelStr = "INFO";
        } else if (level == WARNING) {
            levelStr = "WARNING";
        } else {
            levelStr = "ERROR";
        }

        line += levelStr + ": ";
        line += message;

        logFileWriter.writeln(line);
        logFileWriter.flush();
        logFile.fsync();
    }

    /**
     * clearLog
     * Clears the log file and outputs the log file header to newly cleared log
     *        file
     */
    proc clearLog() {
        logFile.close();
        logFile = open(logFilePath, iomode.cwr);
        outputLogHeader();
    }

    /**
     * getLogFilePath
     * Returns the log file path
     */
    proc getLogFilePath() : string {
        return logFilePath;
    }

    /**
     * getDateTimeStr
     * Returns the date and time formatted to the log file format. This is used
     *         at the beggining of each log entry.
     */
    proc getDateTimeStr() : string {
        var today = datetime.today();
        var todayStr = "";

        todayStr += monthMap[today.month] + " ";
        todayStr += today.day + ", ";
        todayStr += today.year + " ";
        todayStr += today.hour + ":";
        todayStr += today.minute + ":";
        todayStr += today.second;
        todayStr = "[" + todayStr + "]";

        return todayStr;
    }

    /**
     * initializeMonthMap
     * Initializes monthMap
     */
    proc initializeMonthMap() {
        monthMap[1] = "Jan";
        monthMap[2] = "Feb";
        monthMap[3] = "Mar";
        monthMap[4] = "Apr";
        monthMap[5] = "May";
        monthMap[6] = "Jun";
        monthMap[7] = "Jul";
        monthMap[8] = "Aug";
        monthMap[9] = "Sep";
        monthMap[10] = "Oct";
        monthMap[11] = "Nov";
        monthMap[12] = "Dec";
    }

    /**
     * getHomeDir()
     * Returns a string containing the home directory of the user or throws
     *         an Error if this is not possible
     */
    proc getHomeDir() : string throws {
        var CHome : c_string;
        sys_getenv("HOME", CHome);
        var home = CHome : string;

        if (home == "") { // Windows or Error
            var homeDrive : c_string;
            var homePath : c_string;
            sys_getenv("HOMEDRIVE", homeDrive);
            sys_getenv("HOMEPATH", homePath);

            var homeDriveStr = homeDrive : string;
            var homePathStr = homePath : string;

            home = homeDriveStr + homePathStr;

            if (home == "") {
                throw new Error("Cannot find home directory.");
            }
        }

        return home;
    }

    /**
     * outputLogHeader
     * Outputs the log file header to the log file.
     */
    proc outputLogHeader() {
        var startLine = getDateTimeStr();
        startLine += " Start Logging - CryptoTrade";

        logFileWriter.writeln(startLine);
        logFileWriter.flush();
        logFile.fsync();
    }
}
