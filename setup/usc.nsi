XPStyle on

!define PRODUCTNAME "UltraStar Creator"
!define PRODUCTVERSION "1.2.0"
Name "${PRODUCTNAME} ${PRODUCTVERSION}"

!include "MUI.nsh"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "img\usc_installer_top.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "img\usc_installer_top.bmp"

!define MUI_WELCOMEFINISHPAGE_BITMAP "img\usc_installer_side.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "img\usc_installer_side.bmp"

!define BASE_REGKEY "Software\HPI\${PRODUCTNAME}"
!define UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}"

OutFile "_files\usc-${PRODUCTVERSION}-win32-setup.exe"
InstallDir "$PROGRAMFILES\${PRODUCTNAME}"
InstallDirRegKey HKCU "Software\HPI\${PRODUCTNAME}" ""

;; Vista UAC
RequestExecutionLevel admin

!define MUI_STARTMENUPAGE_DEFAULTFOLDER "${PRODUCTNAME}"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${BASE_REGKEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Startmenu_Folder"

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\changes.txt"
!define MUI_FINISHPAGE_RUN "$INSTDIR\usc.exe"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

Var MUI_TEMP
Var STARTMENU_FOLDER

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\doc\gpl.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

!cd "..\bin\${PRODUCTVERSION}"

LangString DESC_SecCopyUI ${LANG_ENGLISH} "${PRODUCTNAME}"

Section "Application" SecCopyUI
	WriteRegStr HKCU "${BASE_REGKEY}" "" "$INSTDIR"

	;; Files
	SetOutPath "$INSTDIR"
	File "bass.dll"
	File "bass_fx.dll"
	File "changes.txt"
	;;File "D3Dcompiler_47.dll"
	;;File "libEGL.dll"
	File "libgcc_s_dw2-1.dll"
	;;File "libGLESV2.dll"
	File "libstdc++-6.dll"
	File "libtag.dll"
	File "libwinpthread-1.dll"
	;;File "opengl32sw.dll"
	File "Qt5Core.dll"
	File "Qt5Gui.dll"
	File "Qt5Network.dll"
	;;File "Qt5Svg.dll"
	File "Qt5Widgets.dll"
	File "usc.exe"
	SetOutPath "$INSTDIR\platforms"
	File "platforms\qwindows.dll"
	;;SetOutPath "$INSTDIR\bearer"
	;;File "bearer\qgenericbearer.dll"
	;;File "bearer\qnativewifibearer.dll"
	;;SetOutPath "$INSTDIR\iconengines"
	;;File "iconengines\qsvgicon.dll"
	;;SetOutPath "$INSTDIR\imageformats"
	;;File "imageformats\qdds.dll"
	;;File "imageformats\qgif.dll"
	;;File "imageformats\qicns.dll"
	;;File "imageformats\qico.dll"
	;;File "imageformats\qjpeg.dll"
	;;File "imageformats\qsvg.dll"
	;;File "imageformats\qtga.dll"
	;;File "imageformats\qtiff.dll"
	;;File "imageformats\qwbmp.dll"
	;;File "imageformats\qwebp.dll"


	;; setup initial reg values
	;; WriteRegStr HKCU "Software\HPI\${PRODUCTNAME}" "customTags" "Comment Album"

	;; remove old values
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "allowedUpdateCheck"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "creator"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "firstRun"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "geometry"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "hideRibbonBar"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "inputlyricsfontsize"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "language"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "outputlyricsfontsize"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "windowSize"
	;;DeleteRegValue HKCU "Software\HPI\${PRODUCTNAME}" "windowState"

	;; Start Menu
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
	CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
	CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\${PRODUCTNAME}.lnk" "$INSTDIR\usc.exe"
	CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall ${PRODUCTNAME}.lnk" "$INSTDIR\Uninstall.exe"
	!insertmacro MUI_STARTMENU_WRITE_END

	;; Registry for Windows Uninstall
	WriteRegStr HKLM "${UNINST_KEY}" "DisplayName" "${PRODUCTNAME}"
	WriteRegStr HKLM "${UNINST_KEY}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
	WriteRegStr HKLM "${UNINST_KEY}" "InstallLocation" $INSTDIR
	WriteRegStr HKLM "${UNINST_KEY}" "DisplayIcon" "$INSTDIR\usc.exe,0"
	WriteRegStr HKLM "${UNINST_KEY}" "Publisher" "usc Community"
	WriteRegStr HKLM "${UNINST_KEY}" "DisplayVersion" "${PRODUCTVERSION}"
	WriteRegDWORD HKLM "${UNINST_KEY}" "NoModify" 1
	WriteRegDWORD HKLM "${UNINST_KEY}" "NoRepair" 1
	WriteRegStr HKLM "${UNINST_KEY}" "Comment" "${PRODUCTNAME} ${PRODUCTVERSION}"
	WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
	;; Files
	Delete "$INSTDIR\bass.dll"
	Delete "$INSTDIR\bass_fx.dll"
	Delete "$INSTDIR\changes.txt"
	Delete "$INSTDIR\libgcc_s_dw2-1.dll"
	Delete "$INSTDIR\libstdc++-6.dll"
	Delete "$INSTDIR\libtag.dll"
	Delete "$INSTDIR\libwinpthread-1.dll"
	Delete "$INSTDIR\libz-1.dll"
	Delete "$INSTDIR\Qt5Core.dll"
	Delete "$INSTDIR\Qt5Gui.dll"
	Delete "$INSTDIR\Qt5Network.dll"
	Delete "$INSTDIR\Qt5Widgets.dll"
	Delete "$INSTDIR\usc.exe"
	Delete "$INSTDIR\platforms\qwindows.dll"
	RMDir "$INSTDIR\platforms"
	
	Delete "$INSTDIR\Uninstall.exe"
	
	RMDir "$INSTDIR"
  
	;; Start Menu
	!insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP
	Delete "$SMPROGRAMS\$MUI_TEMP\Uninstall ${PRODUCTNAME}.lnk"
	Delete "$SMPROGRAMS\$MUI_TEMP\${PRODUCTNAME}.lnk"
	;Delete empty start menu parent diretories
	StrCpy $MUI_TEMP "$SMPROGRAMS\$MUI_TEMP"
	startMenuDeleteLoop:
		ClearErrors
		RMDir $MUI_TEMP
		GetFullPathName $MUI_TEMP "$MUI_TEMP\.."
		IfErrors startMenuDeleteLoopDone
		StrCmp $MUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
	startMenuDeleteLoopDone:
	
	MessageBox MB_YESNO|MB_ICONQUESTION "Do you want to keep your settings?" /SD IDYES IDYES skipKillReg
	DeleteRegKey HKCU "${BASE_REGKEY}"
	skipKillReg:

	;; Registry for Windows Uninstall
	DeleteRegKey HKLM "${UNINST_KEY}"
SectionEnd
