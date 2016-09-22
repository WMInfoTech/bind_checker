#!/bin/bash
# crudely whip through the zone files and check them
#
PATH=/usr/sbin:/usr/bin:/usr/local/bin:/bin

# parameters to named-checkzone
PARAMS="-i full -m warn -n fail"

echo "starting $0, running named-checkzone $PARAMS"

if [ ! -x `which named-checkzone` ]; then
  echo "ERROR $0: named-checkzone not found, is it installed?"
  exit 1
fi 

echo "checking internal.db zone files"
for file in `ls *internal*`; do
  zone=`basename -s internal.db $file`
  #echo "checking: file=$file for zone=$zone"
  named-checkzone $PARAMS $zone $file
  if [ $? -ne 0 ]; then
    echo "ERROR for named-checkzone on file=$file with zone=$zone"
    named-checkzone $zone $file
  fi
done

echo "checking external.db zone files"
for file in `ls *external*`; do
  zone=`basename -s external.db $file`
  #echo "checking: file=$file for zone=$zone"
  named-checkzone $PARAMS $zone $file
  if [ $? -ne 0 ]; then
    echo "ERROR for named-checkzone on file=$file with zone=$zone"
    named-checkzone $zone $file
  fi
done

echo "checking db zone files"
for file in `ls *.db |grep -v "internal\|external"`; do
  zone=`basename -s db $file`
  #echo "checking: file=$file for zone=$zone"
  named-checkzone $PARAMS $zone $file
  if [ $? -ne 0 ]; then
    echo "ERROR for named-checkzone on file=$file with zone=$zone"
    named-checkzone $zone $file
  fi
done
