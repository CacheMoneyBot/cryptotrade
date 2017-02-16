/*
 * Created by Matthew Sedam on 2/15/2017.
 * Copyright 2017 Matthew Sedam.
 * Description: Represents a cryptocurrency exchange
 */

package com.matthewsedam.cryptotrade;

import java.math.BigDecimal;

public interface Exchange {
    /**
     * Returns true if a trade is currently executing and false if it is not.
     *
     * @return true/false as described above.
     */
    public boolean isTrading();

    /**
     * Initiates a trade at market value between the cryptocurrency pairs in
     * pair. pair is in the format of OLD_NEW. amount is in the OLD
     * cryptocurrency and will be converted to the NEW cryptocurrency.
     * Precondition: isTrading() returns false
     *
     * @param pair   the pair to trade in the format of OLD_NEW
     * @param amount amount of old cryptocurrency to trade to the NEW
     *               cryptocurrency
     * @return true if the trade executed successively and false if the trade
     * did not execute successfully.
     */
    public boolean trade(String pair, BigDecimal amount);

    /**
     * Updates the local prices for the supported trade pairs from exchange
     * data.
     */
    public void updatePrices();
}
