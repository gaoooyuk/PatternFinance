#!/bin/bash

pm2 delete --silent push_live

pm2 start push_live.js --name="push_live"