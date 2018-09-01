; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F336D2F8-9746-4BA8-B947-0E22B06DAD41}
AppName=Mapeador Linha m�ximo
AppVersion=1.2
;AppVerName=Mapeador Linha m�ximo 1.2
AppPublisher=GaitaSoft
DefaultDirName={pf}\MapeadorLM
DisableDirPage=yes
DefaultGroupName=Mapeador Linha m�ximo
DisableProgramGroupPage=yes
OutputDir=E:\Arquivos\2_Dev\Projetos\MapNovo\Output
OutputBaseFilename=setupLM2
Compression=lzma
SolidCompression=yes

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "E:\Arquivos\2_Dev\Projetos\MapNovo\MapLM.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Arquivos\2_Dev\Projetos\MapNovo\MAPLM.FDB"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Arquivos\2_Dev\Projetos\MapNovo\MapLM.INI"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\Mapeador Linha m�ximo"; Filename: "{app}\MapLM.exe"
Name: "{commondesktop}\Mapeador Linha m�ximo"; Filename: "{app}\MapLM.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\MapLM.exe"; Description: "{cm:LaunchProgram,Mapeador Linha m�ximo}"; Flags: nowait postinstall skipifsilent

