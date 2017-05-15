/* ConfigFile.chpl
 * Description: Represents a configuration file.
 * Created by Matthew Sedam on 1/8/2017.
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

use FileSystem;
use IO;
use Path;
use SysError;

/**
 * Represents a configuration file
 */
class ConfigFile {
    var configFile : file;
    var configFilePath : string;
    var configMapDomain : domain(string);
    var configMap : [configMapDomain] string;

    /**
     * Default constructor
     * Throws an error if it cannot find the user's home directory or cannot
     *        open the default config file located at ~/.ctradeconf
     */
    proc ConfigFile() {
        configFilePath = getHomeDir();
        configFilePath += pathSep;
        configFilePath += ".ctradeconf";

        if (!exists(configFilePath)) {
            configFile = open(configFilePath, iomode.cwr);
            configFile.close();
        }

        configFile = open(configFilePath, iomode.r);
        var cFileReader = configFile.reader();

        var temp : string;
        while (cFileReader.read(temp)) {
            if (temp.count("=") != 1) {
                continue;
            }

            var key : string;
            var value : string;
            var flip = true;

            for str in temp.split("=") {
                if (flip) {
                    key = str;
                } else {
                    value = str;
                }

                flip = !flip;
            }

            configMap[key] = value;
        }

        sanitizeConfigFileMap();
    }

    /**
     * Destructor
     */
    proc deinit() {
        writeToConfigFile();
        configFile.close();
    }

    /**
     * addProperty
     * Adds property with associated value to the ConfigFile map if both
     *      property and value are not empty.
     *
     * property - the property to add
     * value - the value to add
     *
     * Note: property maps to value, i.e. property=>value
     */
    proc addProperty(property : string, value : string) {
        if (property != "" && value != "") {
            configMap[property] = value;
        }
    }

    /**
     * getPropertyValue
     * Returns the value associated with property in the ConfigFile map
     * If the property is not in configMapDomain, return "NULL"
     *
     * property - the property
     */
    proc getPropertyValue(property : string) : string {
        var testDomain : domain(string);
        testDomain += property;
        if (testDomain.isSubset(configMapDomain)) {
            return configMap[property];
        } else {
            return "NULL";
        }
    }

    /**
     * getHomeDir()
     * Returns a string containing the home directory of the user or throws
     *      an Error if this is not possible
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
     * writeToConfigFile
     * Writes the current configuration of ConfigFile to the default
     *        configuration file. This erases the file before writing.
     */
    proc writeToConfigFile() {
        configFile.close();

        sanitizeConfigFileMap();

        configFile = open(configFilePath, iomode.cw);
        var cFileWriter = configFile.writer();

        for str in configMapDomain {
            var temp = str + "=" + configMap[str] + "\n";
            cFileWriter.write(temp);
        }
    }

    /**
     * sanitizeConfigFileMap
     * Sanitizes the ConfigFile map by removing empty keys and values
     */
    proc sanitizeConfigFileMap() {
        for str in configMapDomain {
            if (str == "" || configMap[str] == "") {
                configMapDomain -= str;
            }
        }
    }
}
