#!/bin/bash
# Date : (2015-04-23 20-07)
# Last revision : (2015-01-02 18-42)
# Wine version used : 1.7.42
# Distribution used to test : Debian 8 x64
# Author : Bayway

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="LibreOffice 4.4.2"
PREFIX="LibreOffice_4.4.2"


POL_SetupWindow_Init
POL_Debug_Init

POL_System_SetArch "auto"

POL_SetupWindow_presentation "$TITLE" "LibreOffice" "http://www.libreoffice.org" "Massimiliano Fiori (massimiliano.fiori@aol.it)" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_System_TmpCreate "LO"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
POL_SetupWindow_browse "Please select the setup file to run." "$TITLE"
POL_Wine_WaitBefore "$TITLE"
#POL_SetupWindow_wait "$(eval_gettext 'Installation in progress.')" "$TITLE"
POL_Wine msiexec /i "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
cd "$POL_System_TmpDir"
POL_Download "http://donate.libreoffice.org/home/dl/win-x86/4.4.2/en/LibreOffice_4.4.2_Win_x86.msi"
POL_Wine_WaitBefore "$TITLE"
POL_SetupWindow_wait "$(eval_gettext 'Installation in progress.')" "$TITLE"
POL_Wine msiexec /i "POL_System_TmpDelete/LibreOffice_4.4.2_Win_x86.msi"
fi

POL_System_TmpDelete

#POL_SetupWindow_VMS "128"
POL_Wine_reboot

POL_Shortcut "libreoffice.exe" "$TITLE"

POL_SetupWindow_Close
exit
