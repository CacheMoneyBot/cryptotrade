/*
 * Created by Matthew Sedam on 1/5/2017.
 * Copyright 2017 Matthew Sedam.
 * Description: The main program for CryptoTrade
 */

package com.matthewsedam.cryptotrade;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        ConfigFile configFile = new ConfigFile();
        System.out.println(configFile.getProperty("electrumBin"));
        configFile.writeToConfigFile();
    }
}
