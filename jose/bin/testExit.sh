#!/bin/bash
EXIT=`/sbin/on_ac_power`
echo EXIT=$?
exit 0

# Esto no vale para nada
if [[ `/sbin/on_ac_power` -eq 0 ]]; then
	echo 0;
elif [[ `/sbin/on_ac_power` -eq 1 ]]; then
	echo 1;
elif [[ `/sbin/on_ac_power` -eq 255 ]]; then
	echo 255;
else
	echo otro;
fi

