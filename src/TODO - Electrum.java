/* Electrum.java
 * Description: Represents the Electrum Bitcoin wallet.
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

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import org.json.JSONObject;

public class Electrum {
    private static final MathContext DEFAULT_MATH_CONTEXT =
            new MathContext(8, RoundingMode.FLOOR);
    private static final String ELECTRUM_BIN = "";

    /**
     *
     * @param pathAndArguments
     * @return
     * @throws Exception
     */
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

    /**
     *
     * @param pathAndArguments
     * @return
     * @throws Exception
     */
    public static JSONObject runProgramAndGetJSONOutput(String pathAndArguments) throws Exception {
        String jsonText = runProgramAndGetOutput(pathAndArguments);
        return new JSONObject(jsonText);
    }

    /**
     *
     * @return
     * @throws Exception
     */
    public static BigDecimal getBTCBalance() throws Exception {
        JSONObject jBalance = runProgramAndGetJSONOutput(ELECTRUM_BIN + " getbalance");
        String balance = (String) jBalance.get("confirmed");
        return new BigDecimal(balance, DEFAULT_MATH_CONTEXT);
    }

    /**
     *
     * @param destinationAddress
     * @param amount
     * @throws Exception
     */
    public static void sendBTCtoBTCAddress(String destinationAddress, BigDecimal amount) throws Exception {
        amount = new BigDecimal(amount.toString(), DEFAULT_MATH_CONTEXT);
        JSONObject jTxObject = runProgramAndGetJSONOutput(ELECTRUM_BIN + " payto " + destinationAddress + " " + amount.toString());
        String txHex = (String) jTxObject.get("hex");
        String txOutput = runProgramAndGetOutput(ELECTRUM_BIN + " broadcast " + txHex);
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
}
