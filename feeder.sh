#!/bin/sh
(cd /var/www/rails/freezer && rake mqttfeeder:feeder)
