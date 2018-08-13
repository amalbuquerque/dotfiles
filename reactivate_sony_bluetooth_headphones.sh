#!/bin/bash
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` off; sleep 2 ; echo -e "disconnect 50:C9:71:97:A1:86\n quit"|bluetoothctl;sleep 5; echo -e "connect 70:26:05:10:48:B4\n quit"|bluetoothctl; sleep 5; pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` a2dp_sink
