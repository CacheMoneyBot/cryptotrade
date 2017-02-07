/*
 * Created by Matthew Sedam on 1/8/2017.
 * Copyright 2017 Matthew Sedam.
 * Description: Represents the configuration file for this program.
 */

package com.matthewsedam.cryptotrade;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class ConfigFile extends Properties {
    private File configFile;

    /**
     * Default constructor for ConfigFile.
     *
     * @throws IOException if the default configuration file cannot be created
     */
    public ConfigFile() throws IOException {
        super();

        String configFilePath = System.getProperty("user.home");
        configFilePath = configFilePath.replace('\"', File.separatorChar);
        configFilePath = configFilePath.replace('/', File.separatorChar);
        configFilePath += File.separatorChar + ".ctradeconf";
        this.configFile = new File(configFilePath);

        if (this.configFile.exists()) {
            FileInputStream in = new FileInputStream(this.configFile);
            this.load(in);
            in.close();
        } else {
            boolean throwAway = this.configFile.createNewFile();
            this.setProperty("electrumBin", "\"/bin/electrum\"");
            // set other properties here
            this.writeToConfigFile();
        }
    }

    /**
     * Constructor for ConfigFile.
     * Precondition: configFile exists and is not null.
     *
     * @param configFile the new configuration file
     * @throws IOException if the default configuration file cannot be created
     */
    public ConfigFile(File configFile) throws IOException {
        super();

        this.setConfigFile(configFile);

        FileInputStream in = new FileInputStream(this.configFile);
        this.load(in);
        in.close();
    }

    /**
     * Sets the configuration file.
     * Precondition: configFile exists and is not null.
     *
     * @param configFile the new configuration file
     */
    public void setConfigFile(File configFile) {
        if (!configFile.exists() || configFile == null) {
            throw new IllegalArgumentException("Bad configuration file.");
        } else {
            this.configFile = configFile;
        }
    }

    /**
     * Writes the configuration to the configuration file.
     * Precondition: configFile exists and is not null.
     *
     * @throws IOException if it cannot write to configFile.
     */
    public void writeToConfigFile() throws IOException {
        FileOutputStream out = new FileOutputStream(configFile);
        this.storeToXML(out, "");
        out.flush();
        out.close();
    }
}
