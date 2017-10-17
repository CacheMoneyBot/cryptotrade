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
        logging.info("Creating account with id: " + identity)
        self._identity = identity
        self._currency = currency
        self._balance = balance
        self._available = available
        self._hold = hold
        self._orders = list()

    @property
    def identity(self):
        return self._identity

    @property
    def currency(self):
        return self._currency

    @property
    def balance(self):
        return self._balance

    @balance.setter
    def balance(self, value):
        if value < 0:
            raise ValueError("balance must be >= 0")
        self._balance = float(value)

    @property
    def available(self):
        return self._available

    @available.setter
    def available(self, value):
        if value < 0:
            raise ValueError("available must be >= 0")
        self._available = float(value)

    @property
    def hold(self):
        return self._hold

    @hold.setter
    def hold(self, value):
        if value < 0:
            raise ValueError("hold must be >= 0")
        self._hold = float(value)

    @property
    def orders(self):
        return self._orders
