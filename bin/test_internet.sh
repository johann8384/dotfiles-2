#!/bin/bash
echo "Testing to Local Router"
ping -c3 192.168.1.1 >/dev/null
if [ $? -ne 0 ]
then
  echo "Failed to reach local router!"
  exit 1
else
  echo "Local Router Works!"
fi
echo "Testing to Cable Modem"
ping -c3 192.168.1.1 >/dev/null
if [ $? -ne 0 ]
then
  echo "Failed to reach Cable Modem!"
  exit 1
else
  echo "Cable Modem Works!"
fi
echo "Testing to Google DNS"
ping -c3 192.168.1.1 >/dev/null
if [ $? -ne 0 ]
then
  echo "Failed to reach Google!"
  exit 1
else
  echo "Google Works!"
fi
exit 0
