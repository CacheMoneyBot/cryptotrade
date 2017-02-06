/*
 * Created by Matthew Sedam on 9/22/16.
 * Copyright 2017 Matthew Sedam.
 * Description: Trades cryptocurrencies
 */

import java.io.BufferedReader;
import java.io.InputStreamReader;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;

import org.json.JSONObject;

public class CryptoTrade {

    private static final MathContext DEFAULTMATHCONTEXT = new MathContext(8, RoundingMode.FLOOR);
    private static final String ELECTRUMBIN = "/usr/local/bin/electrum";
    private static final String GETHBIN = "/usr/bin/geth";

    public static void main(String[] args) throws Exception {
        //startGeth();
        System.out.println(getBTCBalance().toString());
    }

    // gets the BTC balance
    public static BigDecimal getBTCBalance() throws Exception {
        JSONObject jBalance = runProgramAndGetJSONOutput(ELECTRUMBIN + " getbalance");
        String balance = (String) jBalance.get("confirmed");
        return new BigDecimal(balance, DEFAULTMATHCONTEXT);
    }

    // sends BTC to another BTC address
    public static void sendBTCtoBTCAddress(String destinationAddress, BigDecimal amount) throws Exception {
        amount = new BigDecimal(amount.toString(), DEFAULTMATHCONTEXT);
        JSONObject jTxObject = runProgramAndGetJSONOutput(ELECTRUMBIN + " payto " + destinationAddress + " " + amount.toString());
        String txHex = (String) jTxObject.get("hex");
        String txOutput = runProgramAndGetOutput(ELECTRUMBIN + " broadcast " + txHex);
        txOutput = txOutput.replace('[', '{');
        txOutput = txOutput.replace(']', '}');
        txOutput = txOutput.replace(',', ':');
        try {
            JSONObject jTxOutput = new JSONObject(txOutput);
            String txID = (String) jTxObject.get("true");
        } catch (Exception e) {
            //AN ERROR HAS OCCURRED SOMEWHERE, SERVER PROBS
        }

    }

    // runs program in pathAndArguments and returns output as a string
    public static String runProgramAndGetOutput(String pathAndArguments) throws Exception {
        // The basis of the following code came from Martin Clayton
        // on Stack Overflow (4741878)

        String output = "";
        try {
            String line;
            Process p = Runtime.getRuntime().exec(pathAndArguments);
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while ((line = in.readLine()) != null) {
                output += (line + "\n");
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
        return output;
    }

    // runs program in pathAndArguments and returns output as a JSONObject
    public static JSONObject runProgramAndGetJSONOutput(String pathAndArguments) throws Exception {
        String jsonText = runProgramAndGetOutput(pathAndArguments);
        return new JSONObject(jsonText);
    }

    // starts geth in a detached screen session
    public static void startGeth() throws Exception {
        runProgramAndGetOutput("screen -dmS geth " + GETHBIN);
    }
}
