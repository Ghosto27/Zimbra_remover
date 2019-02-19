#!/bin/bash
# rm_message.sh <FROM>
if [ -z "$1" ]; then
echo "usage:  rm_message.sh <FROM>"
exit 0
else
addr=( mailtemp1@gmail.com anothermail@yahoo.com thirdmailtemp02@gmail.com )
subject=$1
#echo "Searching mail $addr from Mail:  $subject"
for victim in "${addr[@]}";
  do
        echo "=======Looking for "$victim""
        #instead "From:$subject" you can use "subject:$subject" or something another
        for msg in `zmmailbox -z -m "$victim" s -l 500 -t message "From:$subject"|awk '{ if (NR!=1) {print}}' | grep -v -e Id -e "-" -e "^$" | awk '{ print $2 }'`
          do
        echo "Found "$msg""
        #you can comment next line (#) for ONLY check mails, without deleting
        zmmailbox -z -m $victim dm $msg
        done
done
fi
