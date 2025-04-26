#!/bin/bash

kwriteconfig5 --file "kwalletrc" --group "Wallet" --key "Enabled" false
kwriteconfig5 --file "kscreenlockerrc" --group "Daemon" --key "Autolock" false
kwriteconfig5 --file "kscreenlockerrc" --group "Daemon" --key "LockOnResume" false
kwriteconfig5 --file "kcminputrc" --group "Keyboard" --key "NumLock" 0
kwriteconfig6 --file "konsolerc" --group TabBar --key NewTabButton true
kwriteconfig6 --file "konsolerc" --group TabBar --key TabBarVisibility AlwaysShowTabBar
kwriteconfig6 --file "konsolerc" --group ThumbnailsSettings --key EnableThumbnails false
kwriteconfig6 --file "konsolerc" --group "Desktop Entry" --key DefaultProfile JC.profile
kwriteconfig6 --file "konsolerc" --group MainWindow --key RestorePositionForNextInstance false
kwriteconfig5 --file "dolphinrc" --group ContentDisplay --key UseShortRelativeDates false
kwriteconfig5 --file "dolphinrc" --group DetailsMode --key PreviewSize 16
kwriteconfig5 --file "dolphinrc" --group General --key ShowZoomSlider false
kwriteconfig5 --file "kwinrc" --group Windows --key Placement Smart
kwriteconfig5 --file "kwinrc" --group Plugins --key slideEnabled false
kwriteconfig5 --file "kwinrc" --group TabBox --key ActivitiesMode 0
kwriteconfig5 --file "kwinrc" --group TabBox --key DesktopMode 0
kwriteconfig5 --file "kwinrc" --group Desktops --key Id_2 7666be00-2cce-4ee6-9a29-9007a555e230
kwriteconfig5 --file "kwinrc" --group Desktops --key Id_3 17fa88f2-bc84-4fba-a760-c75fc108514b
kwriteconfig5 --file "kwinrc" --group Desktops --key Id_4 bf206727-f48f-4b32-a563-f126d92f3795
kwriteconfig5 --file "kwinrc" --group Desktops --key Number 4
kwriteconfig5 --file "kwinrc" --group Desktops --key Rows 2
kwriteconfig5 --file "/home/john/.local/share/dolphin/view_properties/global/.directory" --group "Dolphin" --key "PreviewsShown" false
kwriteconfig5 --file "/home/john/.local/share/dolphin/view_properties/global/.directory" --group "Dolphin" --key "ViewMode" 1
kwriteconfig6 --file "powerdevilrc" --group AC --group SuspendAndShutdown --key AutoSuspendAction 0
kwriteconfig6 --file "kscreenlockerrc" --group Daemon --key Autolock false
kwriteconfig6 --file "kscreenlockerrc" --group Daemon --key LockOnResume false
kwriteconfig6 --file "kscreenlockerrc" --group Daemon --key Timeout 0
touch /home/john/.config/kcmaudiocd_encoder_lame_rc
touch /home/john/.config/kcmaudiocd_encoder_vorbis_rc
kwriteconfig5 --file "/home/john/.config/kcmaudiocd_encoder_lame_rc" --group Lame --key bitrate_constant true
kwriteconfig5 --file "/home/john/.config/kcmaudiocd_encoder_lame_rc" --group Lame --key bitrate_variable false
kwriteconfig5 --file "/home/john/.config/kcmaudiocd_encoder_lame_rc" --group Lame --key cbr_bitrate 12
kwriteconfig5 --file "/home/john/.config/kcmaudiocd_encoder_vorbis_rc" --group Vorbis --key vorbis_quality 6

APPLETSRC="/home/john/.config/plasma-org.kde.plasma.desktop-appletsrc"

readarray -t arr_appletsrc <$APPLETSRC
for i in "${!arr_appletsrc[@]}"; do
    if [[ $(grep -c "digitalclock" <<< ${arr_appletsrc[i]}) -ge 1 ]]; then
        j=$((i-2))
        clock_containment=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\2/p" <<< "${arr_appletsrc[j]}")
        clock_applet=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\4/p" <<< "${arr_appletsrc[j]}")
    elif [[ $(grep -c '^launchers' <<< ${arr_appletsrc[i]}) -ge 1 ]]; then
        j=$((i-1))
        switcher_containment=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\2/p" <<< "${arr_appletsrc[j]}")
        switcher_applet=$(sed -n "s/\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]\[\(.*\)\]/\4/p" <<< "${arr_appletsrc[j]}")
    fi
done

kwriteconfig5 --file $APPLETSRC --group Containments --group $clock_containment --group Applets --group $clock_applet --group Configuration --group Appearance --key dateFormat isoDate
kwriteconfig5 --file $APPLETSRC --group Containments --group $clock_containment --group Applets --group $clock_applet --group Configuration --group Appearance --key use24hFormat 2
kwriteconfig5 --file $APPLETSRC --group Containments --group $switcher_containment --group Applets --group $switcher_applet --group Configuration --group General --key showOnlyCurrentActivity false
kwriteconfig5 --file $APPLETSRC --group Containments --group $switcher_containment --group Applets --group $switcher_applet --group Configuration --group General --key showOnlyCurrentDesktop false
kwriteconfig5 --file $APPLETSRC --group Containments --group $switcher_containment --group Applets --group $switcher_applet --group Configuration --group General --key indicateAudioStreams false
