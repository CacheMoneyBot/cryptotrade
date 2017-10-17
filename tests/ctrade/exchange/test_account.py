# test_account.py
# Description: Tests the account class.
# Created by Matthew Sedam on 9/29/2017.
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

import pytest

from ctrade.exchange.account import Account


class TestAccount(object):
    def test_constructor(self):
        acct = Account("testID", "USD", 0, 0, 0)

        assert acct.identity == "testID"
        assert acct.currency == "USD"
        assert acct.balance == 0.0
        assert acct.available == 0.0
        assert acct.hold == 0.0

        acct = Account("testID", "usd", 0, 0, 0)

        assert acct.currency == "USD"

        with pytest.raises(ValueError):
            acct = Account("testID", "U", 0, 0, 0)

        with pytest.raises(ValueError):
            acct = Account("testID", "USD", -1, 0, 0)

        with pytest.raises(ValueError):
            acct = Account("testID", "USD", 0, -1, 0)

        with pytest.raises(ValueError):
            acct = Account("testID", "USD", 0, 0, -1)
