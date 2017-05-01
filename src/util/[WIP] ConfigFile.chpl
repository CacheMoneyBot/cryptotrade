/* ConfigFile.chpl
 * Description: Represents the configuration file for this program.
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

use Path;
use IO;
use SysError;

class ConfigFile {
    var configFile : file;
    var configFilePath : string;
    var configMapDomain : domain(string);
    var configMap : [configMapDomain] string;

    /* Default constructor
     * Throws an error if it cannot find the user's home directory or cannot
     *        open the default config file located at ~/.ctradeconf
     */
    proc ConfigFile() {
        configFilePath = getHomeDir();
        configFilePath += pathSep;
        configFilePath += ".ctradeconf";


        // WHAT IF FIlE DOES NOT EXIST? NEED TO CREATE IT





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
    }

    // Destructor
    proc deinit() {
        configFile.close();
    }

    proc writeToConfigFile() {
        configFile.close();

        configFile = open(configFilePath, iomode.cw);
        var cFileWriter = configFile.writer();

        for str in configMapDomain {
            var temp = str + "=" + configMap[str] + "\n";
            cFileWriter.write(temp);
        }
    }

    proc addProperty(property : string, value : string) {

    }

    proc getProperty(property : string) : string {

    }

    /* getHomeDir()
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
}
