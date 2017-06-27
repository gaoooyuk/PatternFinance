#!/bin/bash

pm2 delete --silent glossary_wallstreetcn

pm2 start glossary_wallstreetcn.js --name="glossary_wallstreetcn"