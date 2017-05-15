/* main.chpl
 * Description: main for CryptoTrade.
 * Created by Matthew Sedam on 3/13/2017.
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
use DateTime;
use Electrum;
use Logger;
use Sys;

/**
 * main for CryptoTrade
 */
proc main() {
    writeln("CryptoTrade!");

    // LOGGING TESTING STARTS HERE

    var today = datetime.today();
    var todayStr = "";
    var monthDom : domain(int);
    var monthMap : [monthDom] string;

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

    todayStr += monthMap[today.month] + " ";
    todayStr += today.day + ", ";
    todayStr += today.year + " ";
    todayStr += today.hour + ":";
    todayStr += today.minute + ":";
    todayStr += today.second;
    todayStr = "[" + todayStr + "]";

    writeln(todayStr);

    // LOGGING TESTING STOPS HERE

    var a = new ConfigFile();
    a.writeToConfigFile();
    delete a;
    /* Create ConfigFile
       Get property electrumBin
       Write to file
     */
}
