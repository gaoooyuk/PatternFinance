#!/bin/bash

pm2 delete patternfinance
pm2 start ./bin/www --name="patternfinance" -- 3020 --watch