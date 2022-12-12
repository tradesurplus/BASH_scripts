#!/bin/bash

kwriteconfig5 --file "kwalletrc" --group "Wallet" --key "Enabled" false
kwriteconfig5 --file "kscreenlockerrc" --group "Daemon" --key "Autolock" false
kwriteconfig5 --file "kscreenlockerrc" --group "Daemon" --key "LockOnResume" false
kwriteconfig5 --file "kcminputrc" --group "Keyboard" --key "NumLock" 0
kwriteconfig5 --file "konsolerc" --group "TabBar" --key "NewTabButton" true
kwriteconfig5 --file "konsolerc" --group "TabBar" --key "TabBarVisibility" AlwaysShowTabBar
kwriteconfig5 --file "dolphinrc" --group "DetailsMode" --key "UseShortRelativeDates" false
kwriteconfig5 --file "dolphinrc" --group "DetailsMode" --key "PreviewSize" 16
kwriteconfig5 --file "dolphinrc" --group "General" --key "ShowZoomSlider" false
kwriteconfig5 --file "kwinrc" --group "Windows" --key "Placement" Smart
kwriteconfig5 --file "kwinrc" --group "Plugins" --key "slideEnabled" false
kwriteconfig5 --file "/home/john/.local/share/dolphin/view_properties/global/.directory" --group "Dolphin" --key "PreviewsShown" false
kwriteconfig5 --file "/home/john/.local/share/dolphin/view_properties/global/.directory" --group "Dolphin" --key "ViewMode" 1

APPLETSRC="/home/john/.config/plasma-org.kde.plasma.desktop-appletsrc"
found_clock="false"
found_activity="false"
#time_start=$(date '+%H:%M:%S:%N')

readarray -t arr_appletsrc <$APPLETSRC
for i in "${!arr_appletsrc[@]}"; do
    if [[ $(grep -c "digitalclock" <<< ${arr_appletsrc[i]}) -ge 1 ]]; then
        found_clock="true"
        #printf '%s=%s\n' "$i" "${arr_appletsrc[i]}"
        j=$((i-2))
        #printf '%s=%s\n' "$j" "${arr_appletsrc[j]}"
        clock_containment=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\2/p" <<< "${arr_appletsrc[j]}")
        clock_applet=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\4/p" <<< "${arr_appletsrc[j]}")
    elif [[ $(grep -c "showOnlyCurrentActivity" <<< ${arr_appletsrc[i]}) -ge 1 ]]; then
        found_activity="true"
        #printf '%s=%s\n' "$i" "${arr_appletsrc[i]}"
        j=$((i-2))
        #printf '%s=%s\n' "$j" "${arr_appletsrc[j]}"
        switcher_containment=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\2/p" <<< "${arr_appletsrc[j]}")
        switcher_applet=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\4/p" <<< "${arr_appletsrc[j]}")
    elif [[ $found_clock == "true" && $found_activity == "true" ]]; then
        break
    fi
done
#time_stop=$(date '+%H:%M:%S:%N')
# echo $clock_containment
# echo $clock_applet
# echo $switcher_containment
# echo $switcher_applet
# echo $time_start
# echo $time_stop
# echo "--file $APPLETSRC --group Containments --group $clock_containment --group Applets --group $clock_applet --group Configuration --group Appearance --key dateFormat isoDate"
# echo "--file $APPLETSRC --group Containments --group $switcher_containment --group Applets --group $switcher_applet --group Configuration --group General --key showOnlyCurrentActivity false"

kwriteconfig5 --file $APPLETSRC --group Containments --group $clock_containment --group Applets --group $clock_applet --group Configuration --group Appearance --key dateFormat isoDate
kwriteconfig5 --file $APPLETSRC --group Containments --group $clock_containment --group Applets --group $clock_applet --group Configuration --group Appearance --key use24hFormat 2
kwriteconfig5 --file $APPLETSRC --group Containments --group $switcher_containment --group Applets --group $switcher_applet --group Configuration --group General --key showOnlyCurrentActivity false
kwriteconfig5 --file $APPLETSRC --group Containments --group $switcher_containment --group Applets --group $switcher_applet --group Configuration --group General --key showOnlyCurrentDesktop false

