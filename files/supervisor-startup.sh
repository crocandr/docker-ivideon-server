#!/bin/bash

echo " ----- start SupervisorD ----- "

supervisord -c /etc/supervisor/supervisord.conf
