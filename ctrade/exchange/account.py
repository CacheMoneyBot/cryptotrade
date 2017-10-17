# account.py
# Description: Represents an account on a cryptocurrency exchange.
# Created by Matthew Sedam on 7/27/2017.
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


class Account:
    """ Represents and account on a cryptocurrency exchange."""

    def __init__(self, identity, currency, balance, available, hold):
        """ identity - string, currency - string (three letter code),
            balance >=0, available >= 0, hold >= 0. """

        logging.info("Creating account with id: " + identity)

        if len(currency) != 3:
            raise ValueError("currency should be three letter currency code")
        if balance < 0 or available < 0 or hold < 0:
            raise ValueError("balance, available, or hold < 0")

        self.identity = identity
        self.currency = currency.upper()
        self.balance = float(balance)
        self.available = float(available)
        self.hold = float(hold)
        self.orders = list()
