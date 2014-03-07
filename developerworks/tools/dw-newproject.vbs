' See the "Author guidelines" tab at
' http://www.ibm.com/developerworks/aboutdw/
' for more information on how to use this program.
' © Copyright IBM Corporation 2004, 20005 All rights reserved.
Option explicit

Dim toolpath, fso, dWVersionPrev, dWVersion, isKP

' Original function for when only one schema/stylesheet level.
Function GetdWVersion()
'  Read current dWVersion from dwversion.txt file
   Const ForReading = 1
   Dim f: set f = fso.OpenTextFile(fso.BuildPath(toolpath,"dwversion.txt"),ForReading)
   Dim s: s = Trim(f.ReadLine())
   if s = "" then
       s = "6.0"
   End If
   f.close()
   GetdWVersion = s
End Function

' Use this subroutine when you have author packages with two
' different schema/stylesheet levels.
Sub SetdWVersion
'  Read current dWVersion from dwversion.txt file
   Dim fspec, s
   fspec = fso.BuildPath(toolpath,"dwversion.txt")
   Const ForReading = 1
   If fso.fileExists(fspec) Then
     Dim f: set f = fso.OpenTextFile(fspec,ForReading)
     s = Trim(f.ReadLine())
   End If
   if s = "" then
     s = "6.0"
   Else
     Dim slashPos
       slashPos = InStr(s,"/")
     if slashPos > 0 then
       dWVersionPrev = mid(s, 1, slashPos -1)
       dWVersion =  mid(s, slashPos+1)
     else
       dWVersionPrev = ""
       dWVersion =  Trim(s)
     End If
   End If
   f.close()
End Sub

Function GetProjectName(projtype)
    Dim resp1, projname, projparent, projprompt, foldername, retryMsg, defaultname
    resp1 = vbRetry
    projprompt = "Please provide a name for your new project folder" & vbNewLine & _
                 "Do not include path elements (\) in the name."

	If projtype = "tutorial" Then
        defaultname = "my-tutorial"
    Else
		If projtype = "article" Then
			defaultname = "my-article"
		Else 
			defaultname = "my-knowledge-path"
		End If
	End If 

    while (resp1 = vbRetry)
        projname = InputBox(projprompt , "IBM developerWorks", defaultname )


        if projname = "" Then
            resp1 = vbCancel
        ElseIf resp1 = vbCancel Then
            projname = ""
        Else
            projparent = fso.GetParentFolderName(projname)
            If (projparent = "") Then
                foldername = fso.BuildPath(toolpath, "../" & projname )
                foldername = fso.GetAbsolutePathName(foldername)
                If (fso.FileExists(foldername) Or fso.FolderExists(foldername))  Then
                    retryMsg = "Error:" & vbTab & projname & " exists"    
                Else
                    resp1 = vbOK
                End if
            Else
                retryMsg = "Error:" & vbTab & "You must specify a simple name without path elements (\)"    
            End If

            if resp1 = vbRetry Then
                resp1 = MsgBox(retryMSg, _
                    vbRetryCancel + vbQuestion + vbDefaultButton1, _
                        "IBM developerWorks")
            End If
        End If
        if resp1 = vbCancel Then 
            projname = ""
        End If
    Wend
    GetProjectName = projname
End Function

Function CopyProjectFiles(projname, projtype)
    Dim basefolder, infile, outfile, inpath, outpath, f, errMsg
    errMsg = ""
    basefolder = fso.GetParentFolderName(toolpath)
    inpath = fso.BuildPath(basefolder, "tools")


'   Copy the appropriate template
    If projtype = "tutorial" Then
        infile = fso.BuildPath(inpath, "template-dw-tutorial-" & dWVersion & ".xml")
    Else
		If projtype = "article" Then
			infile = fso.BuildPath(inpath, "template-dw-article-" & dWVersion & ".xml")
		Else 
			infile = fso.BuildPath(inpath, "template-dw-knowledge-path-" & dWVersion & ".xml")
			isKP = True 
		End if
    End if
' if template exists, try to create project folder
    if fso.FileExists(infile) Then
        outpath = fso.BuildPath(basefolder,projname)
        outfile = fso.BuildPath(outpath, "index.xml")
        fso.CreateFolder outpath
        fso.CopyFile infile, outfile
        '   Copy the sample figure
'        infile = fso.BuildPath(inpath, "figure1.gif")
'        outfile = fso.BuildPath(outpath, "figure1.gif")
'        fso.CopyFile infile, outfile
        '   Copy the sample author photo
		If Not isKP Then
			infile = fso.BuildPath(inpath, "myphoto.jpg")
			outfile = fso.BuildPath(outpath, "myphoto.jpg")
			fso.CopyFile infile, outfile
			'   Copy the pixel ruler graphic
			infile = fso.BuildPath(inpath, "pixelruler580.gif")
			outfile = fso.BuildPath(outpath, "pixelruler580.gif")
			fso.CopyFile infile, outfile
		End if
        '   Copy the stub script to do the validation and transform.
        infile = fso.BuildPath(inpath, "dw-transform.vbs")
        outfile = fso.BuildPath(outpath, "dw-transform.vbs")
        fso.CopyFile infile, outfile
    Else
        errMsg = "Error - Template file " & infile & " does not exist."
    End If
    CopyProjectFiles = errMsg
End Function

Sub Main
    Dim pname, errorCode, ptype, errMsg
    If Wscript.Arguments.Length > 0 Then
        ptype= Wscript.Arguments.Item(0)
    else
        ptype="article"
    end if
    Set fso = CreateObject("Scripting.FileSystemObject")
    toolpath = fso.GetFile(WScript.ScriptFullName).parentFolder
'    SetdWVersion
    dWVersion = GetdWVersion()
    pname = GetProjectName(ptype)
    if pname <> "" Then
        errMsg = CopyProjectFiles(pname, ptype)
        if errMsg = "" Then
            errorCode = false
        Else
            Msgbox errMsg
            errorCode = true
        End If
    Else
        errorCode = true
    End If
    wscript.quit(errorCode)
End sub

Main
