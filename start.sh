#!/bin/bash
export > /env

supervisord &

sleep 5

tail -f /var/log/supervisor/supervisord.log -f /var/log/mysql/error.log -f /var/log/cronjob.log