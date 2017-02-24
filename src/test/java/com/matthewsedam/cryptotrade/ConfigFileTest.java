/* ConfigFileTest.java
 * Description: Tests the ConfigFile class.
 * Created by Matthew Sedam on 2/6/2017.
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

package com.matthewsedam.cryptotrade;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class ConfigFileTest extends TestCase {

    /**
     *
     * @param testName
     */
    public ConfigFileTest(String testName) {
        super(testName);
    }

    /**
     *
     * @return
     */
    public static Test suite() {
        return new TestSuite(ConfigFileTest.class);
    }

    /**
     *
     */
    public void testConfigFile() {
        assertTrue(true);
    }
}
