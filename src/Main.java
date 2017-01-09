/*
 * Created by Matthew Sedam on 1/5/2017.
 * Copyright 2017 Matthew Sedam.
 * Description: The main program for CryptoTrade
 */

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;

public class Main {
    public static void main(String[] args) throws IOException {
        /*String configFilePath = System.getProperty("user.home").replace('\"', File.separatorChar);
        configFilePath = configFilePath.replace('/', File.separatorChar) + File.separatorChar + ".cryptotradeconfig";
        File configFile = new File(configFilePath);
        while (!configFile.exists()) {
            System.out.println("File: " + configFilePath + " does not exist. I will create it and make it hidden.");
            PrintStream configPrintStream = new PrintStream(configFile);
            configPrintStream.println();
            configPrintStream.close();
        }
        if (System.getProperty("os.name").toLowerCase().contains("windows")) {
            Runtime.getRuntime().exec("attrib +H " + configFilePath);
        }*/

        ConfigFile a = new ConfigFile();
    }
}
