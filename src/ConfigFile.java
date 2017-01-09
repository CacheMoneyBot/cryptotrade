/*
 * Created by Matthew Sedam on 1/8/2017.
 * Copyright 2017 Matthew Sedam.
 * Description: Represents the configuration file for this program.
 */

import java.io.File;
import java.io.IOException;

public class ConfigFile {
    private File configFile;

    /**
     * Default constructor for ConfigFile.
     *
     * @throws IOException if the default configuration file cannot be created
     */
    public ConfigFile() throws IOException {
        String configFilePath = System.getProperty("user.home");
        configFilePath = configFilePath.replace('\"', File.separatorChar);
        configFilePath = configFilePath.replace('/', File.separatorChar);
        configFilePath = configFilePath + File.separatorChar + ".cryptotradeconfig";

        this.configFile = new File(configFilePath);
        boolean thowAway = this.configFile.createNewFile();
    }

    /**
     * Constructor for ConfigFile.
     * Precondition: configFile exists and is not null.
     *
     * @param configFile the new configuration file
     */
    public ConfigFile(File configFile) {
        this.setConfigFile(configFile);
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
}