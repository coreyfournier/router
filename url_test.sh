#!/bin/sh
#
# USG and EdgeRouter route-test script for failover
#
# This script was created to deal with ATT as a main connection, that uppon failure it responds to all dns request
# with it's self. This renders any ping checks as always successful unless you disconnect the modem completely.
#
# by https://github.com/coreyfournier/router
# inspired by https://github.com/popmonkey
#
# this is meant to be used as the test script in the load-balance groups
# e.g.
#  group wan_failover {
#      interface eth0 {
#          route-test {
#              count {
#                  failure 1
#                  success 1
#              }
#              type {
#                  script /config/scripts/url_test.sh
#              }
#          }
#      }
# .......................................
#  }

#Download the google search page (redirect)
page=$(curl https://google.com)
#Look for instances of google
output=$(echo "$page" | grep "google")
#Now test the output of the page to see if it has google in it. 0=yes 1=no
if [[ $output == *"google.com/\">here<"* ]]; then $(exit 0); echo "$?"; else $(exit 1); echo "$?"; fi
