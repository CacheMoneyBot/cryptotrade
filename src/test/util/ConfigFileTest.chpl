/* ConfigFileTest.chpl
 * Description: Tests the ConfigFile class.
 * Created by Matthew Sedam on 5/7/2017.
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

use ConfigFile;

/**
 * Tests the ConfigFile class
 */
proc main() {
    var passed = true;

    var configFile = new ConfigFile();

    // test addProperty
    configFile.addProperty("test1", "answer1");
    configFile.addProperty("test2", "answer2");
    if (configFile.getPropertyValue("test1") != "answer1" ||
        configFile.getPropertyValue("test2") != "answer2") {

        writeln("addProperty failed to give correct value.");
        passed = false;
    }

    // test sanitizeConfigFileMap
    configFile.addProperty("", "");
    if (configFile.getPropertyValue("") != "NULL") {
        writeln("sanitizeConfigFileMap failed.");
        passed = false;
    }

    configFile.sanitizeConfigFileMap();
    if (configFile.getPropertyValue("") != "NULL") {
        writeln("sanitizeConfigFileMap failed.");
        passed = false;
    }

    // test writeToConfigFile and default constructor
    configFile.writeToConfigFile();
    delete configFile;
    var configFile2 = new ConfigFile();

    if (configFile2.getPropertyValue("test1") != "answer1" ||
        configFile2.getPropertyValue("test2") != "answer2") {

        writeln("writeToConfigFile or default constructor failed.");
        passed = false;
    }

    delete configFile2;

    if (passed) {
        writeln("Test ConfigFile: PASSED");
    } else {
        writeln("Test ConfigFile: FAILED");
    }
}
