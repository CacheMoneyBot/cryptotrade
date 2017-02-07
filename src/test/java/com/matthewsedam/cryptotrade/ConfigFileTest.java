/*
 * Created by Matthew Sedam on 2/6/2017.
 * Copyright 2017 Matthew Sedam.
 * Description: Tests the ConfigFile class.
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
