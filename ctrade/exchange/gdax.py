# gdax.py
# Description: GDAX API wrapper
# Created by Matthew Sedam on 10/17/2017.
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

import hmac
import hashlib
import time
# import requests
import base64
from requests.auth import AuthBase


class GDAXExchange:
    def __init__(self, production, api_key, api_secret, api_pass):
        self._api_key = api_key
        self._api_secret = api_secret
        self._api_pass = api_pass
        self._production = production

        if production:
            self._api_url = "https://api.gdax.com/"
        else:
            self._api_url = "https://api-public.sandbox.gdax.com/"

        self._auth = GDAXExchangeAuth(api_key, api_secret, api_pass)
        self._accounts = list()
        # r = requests.get(self._api_url + 'accounts', auth=self._auth)
        # TODO: Get accounts and create appropriate objects and append to list

    @property
    def production(self):
        return self._production


# From GDAX documentation
class GDAXExchangeAuth(AuthBase):
    def __init__(self, api_key, secret_key, passphrase):
        self.api_key = api_key
        self.secret_key = secret_key
        self.passphrase = passphrase

    def __call__(self, request):
        timestamp = str(time.time())
        message = (timestamp + request.method + request.path_url
                   + (request.body or ''))
        hmac_key = base64.b64decode(self.secret_key)
        signature = hmac.new(hmac_key, message, hashlib.sha256)
        signature_b64 = signature.digest().encode('base64').rstrip('\n')

        request.headers.update({
            'CB-ACCESS-SIGN': signature_b64,
            'CB-ACCESS-TIMESTAMP': timestamp,
            'CB-ACCESS-KEY': self.api_key,
            'CB-ACCESS-PASSPHRASE': self.passphrase,
            'Content-Type': 'application/json'
        })
        return request
