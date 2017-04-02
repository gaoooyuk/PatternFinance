#!/bin/bash

pm2 delete bdpush
pm2 start bdpush.js --name="bdpush"