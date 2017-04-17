#!/bin/bash

pm2 delete seekingalpha
pm2 delete marketwatch
pm2 delete thestreet

pm2 start live_seekingalpha.js --name="seekingalpha"
pm2 start live_marketwatch.js --name="marketwatch"
pm2 start live_thestreet.js --name="thestreet"