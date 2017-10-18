# ctrade.py
# Description: CryptoTrade is a cryptocurrency trading program.
# Created by Matthew Sedam on 7/25/2017.
#
# Copyright 2017 Matthew Sedam.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import logging
import time

import gdax


def main():
    logging.basicConfig(format="%(asctime)s - %(message)s",
                        datefmt="%m/%d/%Y %I:%M:%S %p",
                        filename="../ctrade.log", level=logging.DEBUG)
    logging.info("CryptoTrade has started successfully.")

    auth_client = gdax.AuthenticatedClient("",
                                           "",
                                           "",
                                           api_url="")
    accounts = auth_client.get_accounts()
    for i in accounts:
        if i["currency"] == "BTC":
            wallet = i

    base = 3600.0

    for _ in range(100):
        ticker = auth_client.get_product_ticker(product_id="BTC-USD")
        price = float(ticker["price"])
        print(price)
        if price >= base:
            newPrice = str(round(price * 1.1, 2))
            newSize = str(round(float(wallet["available"]) / 2, 10))
            auth_client.sell(price=newPrice,
                             size=newSize,
                             product_id="BTC-USD")
            print("SELL: {0} BTC at ${1} per".format(newSize, newPrice))
        time.sleep(5)
        accounts = auth_client.get_accounts()
        for i in accounts:
            if i["currency"] == "BTC":
                wallet = i

    exit(0)


if __name__ == "__main__":
    main()
