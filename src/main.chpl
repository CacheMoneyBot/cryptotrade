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
use FileSystem;
use Logger;
use Sys;

/**
 * main for CryptoTrade
 */
proc main() {
    var log = new Logger();
    var configFile = new ConfigFile();

    log.log("Test INFO", INFO);
    log.log("Test WARNING", WARNING);
    log.log("Test ERROR", ERROR);

    delete configFile;
    delete log;
}
