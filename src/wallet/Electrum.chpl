/* Electrum.chpl
 * Description: Represents the Electrum Bitcoin wallet.
 * Created by Matthew Sedam on 3/18/2017.
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

use GMP;

class Electrum {
    var electrumBinPath : string;

    /* ToDo
     * THE BIG THREE AND VAR GETTERS AND SETTERS
     *
     * proc runProgramAndGetOutput(program : string)
     * proc runProgramAndGetJSONOutput(program : string)
     * MAYBE ADD THESE TWO TO THEIR OWN UTIL CLASS WHICH DOES NOT NEED TO BE
     *     CREATED
     *
     * proc getBTCBalance() : mpf_t
     * MPF_T TYPE IS FROM GMP (CHECK IF THAT IS APPROPRIATE TYPE)
     * THE MPF_T TYPE (OR WHATEVER IS RETURNED) NEEDS TO HAVE THE APPRIPRIATE
     *     FORMATTING; SEE PI PROJECT ON MATTHEWSEDAM'S GITHUB
     *
     * proc sendBTCtoBTCAddress(destinationAddress : string, amount : mpz_t)
     */
}
