' See the "Author guidelines" tab at 
' http://www.ibm.com/developerworks/aboutdw/
' for more information on how to use this program.
' © Copyright IBM Corporation 2004. All rights reserved.
Option explicit

Dim rc, WshShell, toolpath, mypath, fso, dwnewproject

'Set global constants and variables.

Set fso = CreateObject("Scripting.FileSystemObject")
Set WshShell = WScript.CreateObject("WScript.Shell")

mypath = fso.GetFile(WScript.ScriptFullName).parentFolder
toolpath = ".\tools\dw-newproject.vbs"
dwnewproject = fso.BuildPath(mypath , toolpath)
dwnewproject = fso.GetAbsolutePathName(dwnewproject)
' the following little piece of code handles the bizarre case where the user
' has set the default script host to cscript. Microsoft doesn't seem to provide
' any easy way to figure this out, the the idea is to try writing a warning 
' message to stdout. This produces an error if we are running under wscript.
' Thus, if we are running under cscript, we can put up a readline and wait for 
' user input before the window goes POOF!
Dim VBSFileCommand, cmdLower, ScriptType, dummyLine
VBSFileCommand = WshShell.RegRead("HKLM\SOFTWARE\Classes\VBSFile\Shell\Open\Command\")
cmdLower = LCase(VBSFileCommand)
if InStr(cmdLower, "wscript.exe") Then
  ScriptType="wscript"
Else
  ScriptType="cscript"
  wscript.stdout.WriteLine vbNewline & "You appear to have non-standard defaults for Windows script host"
  wscript.stdout.writeLine "You can revert to standard behavior by running:"
  wscript.stdout.writeLine "  wscript //H:WScript"
  wscript.stdout.writeLine "from a DOS command line"
  wscript.stdout.writeLine ""
  wscript.stdout.writeLine "Press enter to close this window."
  dummyLine=wscript.stdin.readLine
End If

if fso.FileExists(dwnewproject) Then
    ' change directory to my directory as wshshell.run 
    ' doesn't like directories with spaces
    WshShell.CurrentDirectory = mypath
    ' Put quotes around filespec in case of special chars like blanks
    rc = WshShell.Run("wscript " & toolpath & " tutorial", 1, false)
else
    Wscript.Echo "Error: " & vbTab & "Cannot locate article creation tool" & vbNewLine & _
    vbTab & dwnewproject &vbNewLine    
End If
