' See the "Author guidelines" tab at
' http://www.ibm.com/developerworks/aboutdw/
' for more information on how to use this program.
' © Copyright IBM Corporation 2004, 2005. 2008, 2009 All rights reserved.
Option Explicit

' Define global objects and variables.
Dim fso, pgmname, filepath, toolpath, dwVersionPrev, dwVersion, errorFound, msxmlVersions
msxmlVersions = Array("6.0", "4.0")
Function HelpInfo
    dim helptext
    helptext = vbNewLine & _
    "About:" & vbTab & pgmname & " is an XML file validator." & vbNewLine & _
    vbNewLine & _
    "Syntax:" & vbTab & pgmname & " [input_file]" & vbNewLine & _
    vbNewLine & _
    "Where:" & vbTab & "input_file is an xml file." & vbNewLine & vbNewLine & _
    "If input_file is omitted, it defaults to index.xml.  " & _
    "If input_file is a directory," & vbNewLine & "then " & pgmname & _
    " will attempt to process index_file\index.xml" & vbNewLine & _
    "Results are returned in a console message." & vbNewLine & vbNewLine
    HelpInfo = helptext
End Function

Function SplitText(inText, maxlen)
    Dim remainder, outText, piecelen, thisPos, thisLine
    remainder = inText
    outText = ""
    while (len(remainder) > maxlen)
        thisPos = InstrRev(remainder, vbNewLine, maxlen, vbTextCompare)
        if (thisPos > 0) Then
            thisLine = left(remainder, thisPos - 1) ' will add newline later
            remainder = ltrim(right(remainder, len(remainder) - thisPos - 1)) ' 2 pos for cRLF
        Else
            thisLine = remainder
            remainder = ""
        End If
        while (len(thisLine) > maxlen)
            thisPos = InstrRev(thisLine, " ", maxlen)
            if (thisPos = 0) Then
                thisPos = maxlen
            End If
            outText = outText & Rtrim(Left(ThisLine, thisPos)) & vbNewLine
            thisline = Right(thisLine, len(thisLine) - thisPos)
        wend
        outText = outText & Rtrim(thisLine) & vbNewLine
    wend
    SplitText= outText & remainder
End Function

Function GetScriptVersion
   GetScriptVersion = ScriptEngine & " Version " & ScriptEngineMajorVersion & "." & _
   ScriptEngineMinorVersion & "." & ScriptEngineBuildVersion
End Function

Function ValidateFile(sFile)
    Dim f, hfile, schemaCache, schemaSpec, basename, str, seearticle, xdoc, xsl, xslspec, html, htmlfile, htmlfn, writerc
    Dim xslTemplate, xslProc, localbase
    Dim docTypeNode, dwContentType, idNode, documentType, useMSXMLVersion, level, versionStrings
    Dim isV16, contentPreviewFile, v16XslDir
    Dim v16XslFolder, v16LangFolders, langFolder, langFolderName, previewFile
    Const ForReading = 1, ForWriting = 2, ForAppending = 8
    seearticle = "See 'Using the developerWorks XML validation tools'" & vbNewLine & _
                 "(http://www.ibm.com/developerworks/library/i-dwauthors-tools/)"  & vbNewLine & _
                 "for additional information about this tool." & vbNewLine & _
                 GetScriptVersion()

    Const maxLineLen = 100

    Set f = fso.GetFile(sfile)
    ' Create DOM document object for XML file
    useMSXMLVersion = ""
    versionStrings = ""
    for level = LBound(msxmlVersions) to UBound(msxmlVersions)
      if useMSXMLVersion = "" Then
        versionStrings = versionStrings & msxmlVersions(level) & " "
         On Error Resume Next
        Set xdoc = CreateObject("Msxml2.DOMDocument." & msxmlVersions(level) )
        If err <> 0 Then
          Err.Clear
        Else
          useMSXMLVersion = msxmlVersions(level)
          str = "Using MSXML Core Services version " & useMSXMLVersion & vbNewLine
        End If
        On Error Goto 0
      end if
    next

    If useMSXMLVersion = "" Then
      str = "Could not create document XML parser" & vbNewLine & _
             "Ensure you have the supported MS XML Core services version (one of " & trim(versionStrings) & ")" & vbNewLine & _
             seearticle
      errorFound = true
    Else
      xdoc.validateOnParse = False
      xdoc.async = False
      xdoc.load(sfile)
      If xdoc.parseError.errorCode = 0 Then
        documentType = ""
        localSite = ""

	  set docTypeNode = xdoc.selectSingleNode("/*")
	  set docTypeNode = xdoc.selectSingleNode("/dw-document//*")
	  If isObject(docTypeNode) Then
		documentType = docTypeNode.nodeName
	    ' Make sure locaSite is a string
		localSite = "" & docTypeNode.getAttribute("local-site")
      End If
        If documentType = "" Then
          str = str & vbNewLine & "Error:" & vbTab & "Cannot determine document type for file " & _
              vbNewLine & vbTab & sfile & vbNewLine
          errorFound = true
        Else
          If localSite = "" Then
            str = str & vbNewLine & "Error:" & vbTab & "Cannot determine local site for " & documentType &" - file " & _
              vbNewLine & vbTab & sfile & vbNewLine
            errorFound = true
          Else
            Set xdoc = Nothing

            Set xdoc = CreateObject("Msxml2.DOMDocument." & useMSXMLVersion )

            isV16 = false
            v16XslDir = fso.GetAbsolutePathName(toolpath & "/../xsl/" & dwVersion)
            if fso.folderExists(v16XslDir) Then
              Set v16XslFolder = fso.GetFolder(v16XslDir)
              Set v16LangFolders = v16XslFolder.SubFolders
              For Each langFolder in v16LangFolders
                If Not isV16 Then
                  langFolderName = v16XslDir & "\" & langfolder.name
                  previewFile = langFolderName  & "\" & documentType & _
                     "-preview-" & localSite & "-" & dwVersion & ".xsl"
                  If fso.FileExists(previewFile) Then
                    isV16 = true
               		xslSpec = fso.GetAbsolutePathName(langFolderName  & _
               		"/dw-document-html-" & localSite & "-" & dwVersion & ".xsl")
                  End If
                End If
              Next
            End If
            if isV16 Then
	           	schemaSpec = fso.GetAbsolutePathName(toolpath & "/../schema/" & dwVersion  & "/dw-document-" & _
             	dwVersion & ".xsd")
            Else
				schemaSpec = fso.GetAbsolutePathName(toolpath & "/../schema/" & dwVersionPrev  & "/dw-document-" & _
                dwVersionPrev & ".xsd")
            End If

            if (fso.FileExists(schemaSpec)) Then
              basename = f.Name
              ' Load XML input file & validate it
              Set schemaCache = CreateObject("Msxml2.XMLSchemaCache." & useMSXMLVersion)
              schemaCache.add "",schemaSpec
              xdoc.schemas = schemaCache
              xdoc.validateOnParse = True
              xdoc.async = False
              xdoc.load(sfile)
              If xdoc.parseError.errorCode = 0 Then
                ' XML is valid against schema so try to run transform
				set docTypeNode = xdoc.selectSingleNode("/dw-document//*")
                documentType = docTypeNode.nodeName
                set idNode = xdoc.selectSingleNode("/dw-document/" & docTypeNode.nodeName & "/id")
                if (idNode is nothing) THEN
                  set idNode = xdoc.createElement("id")
                  idNode.setAttribute "domino-uid", ""
                  idNode.setAttribute "content-id", ""
                  idNode.setAttribute "original", "yes"
                else
                End If
                ' Force CMA-id to 0 for MSXML transforms
                idNode.setAttribute "cma-id", "0"
                localSite = docTypeNode.getAttribute("local-site")

                str = str & vbNewLine & basename & " is a valid " & documentType & " using schema " & schemaSpec
                If Not isV16 THEN
                  xslSpec = fso.GetAbsolutePathName(toolpath & "/../xsl/" & dwVersionPrev  & _
                    "/dw-document-html-" & dwVersionPrev & ".xsl")
                End If
                if (fso.FileExists(xslSpec)) Then
                  Set xsl = CreateObject("Msxml2.FreeThreadedDOMDocument." & useMSXMLVersion)
                  xsl.async = false
                  xsl.validateOnParse = false
                  xsl.resolveExternals = true
' Add for msxml 6
                  xsl.setProperty "ProhibitDTD", False
                  xsl.load(xslSpec)
                  if xsl.parseError.errorCode = 0 Then
                      ' Stylesheet loaded OK

                    dim translatedTextNode, localSite, translatedTextFile, outputEncoding
                    xsl.setProperty "SelectionLanguage", "XPath"
                    xsl.setProperty "SelectionNamespaces", "xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"""
                    If NOT isV16 THEN
                      set translatedTextNode = xsl.selectSingleNode("//xsl:include")
                      translatedTextFile = "dw-translated-text-" & localSite & "-" & dwVersionPrev & ".xsl"
                      translatedTextNode.setAttribute "href", translatedTextFile
                    End If
                    outputEncoding = "UTF-8"
                    str = str & vbNewLine & vbNewLine & "Transforming for developerWorks site - " & localSite
                    str = str & vbNewLine & "Using stylesheet " & xslSpec
                    set xslTemplate =  CreateObject("Msxml2.XSLTemplate." & useMSXMLVersion)

                    set xslTemplate.stylesheet = xsl
                    set xslProc = xslTemplate.createProcessor()
                    xslProc.input = xdoc
                    xslProc.addParameter "xform-type", "preview"
                    localbase= MakeURI("file:///" & fso.GetAbsolutePathName(toolpath & "/.."))
                    xslProc.addParameter "local-url-base", localbase
                    If documentType = "dw-tutorial" Then
                      htmlfn = "index.html"
                      xslProc.addParameter "page-name", htmlfn
                    Else
                      htmlfn = mid(sfile, 1, len(sFile) - 4) & ".html"
                    End If
                    xslProc.Transform
                    if xsl.parseError.errorCode = 0 Then
                      ' Transform worked OK, so write output file
                      writerc = WriteOutput(xslProc, htmlfn)

                      str = str & vbNewLine & vbNewLine & "HTML output is in file " & htmlfn & vbNewLine
                      If documentType = "dw-tutorial" Then
                        ' Attempt to write the remaining pages withotu error reporting
                        writerc = WriteTutorialPages(xslProc, xdoc)
                      End If
                    Else
                      ' Error loading XSL stylesheet
                      str = str & vbNewLine & "Transformation Error: "  & vbTab & "Line: " & xsl.parseError.line & _
                      " at position: " & xsl.parseError.linepos & vbNewLine & _
                      "URL: " & vbTab & xsl.parseError.url & vbNewLine & _
                      "Schema: " & vbTab & schemaSpec & vbNewLine & _
                      "Source: " &vbTab & vbTab & xsl.parseError.srcText & vbNewLine & _
                      xsl.parseError.reason & vbNewLine & vbNewLine & _
                      seearticle
                    End If
                    On Error goto 0
                  else
                    ' Error loading XSL stylesheet
                    str = str & vbNewLine & "Stylesheet load Error: "  & vbTab & "Line: " & xsl.parseError.line & _
                      " at position: " & xsl.parseError.linepos & vbNewLine & _
                      "URL: " & vbTab & xsl.parseError.url & vbNewLine & _
                      "Schema: " & vbTab & schemaSpec & vbNewLine & _
                      "Source: " &vbTab & vbTab & xsl.parseError.srcText & vbNewLine & _
                      xsl.parseError.reason & vbNewLine & vbNewLine & _
                      seearticle
                  End If
                Else
                  str = str & vbNewLine & vbNewline & "Can't find XSL file " & xslspec
                  errorFound = true
                End If
              ElseIf xdoc.parseError.errorCode <> 0 Then
                str = "Error: "  & vbTab & "Line: " & xdoc.parseError.line & _
                  " at position: " & xdoc.parseError.linepos & vbNewLine & _
                  "File: " & vbTab & sfile & vbNewLine & _
                  "Schema: " & vbTab & schemaSpec & vbNewLine & _
                  "Source:" &vbNewLine & SplitText(xdoc.parseError.srcText, maxLineLen ) & vbNewLine & _
                  "Reason:" & vbNewLine & _
                  SplitText( xdoc.parseError.reason, maxLineLen ) & vbNewLine &  _
                  seearticle
'                  "See 'Using the developerWorks XML validation tools'" & vbNewLine & _
'                  "(http://www.ibm.com/developerworks/library/i-dwauthors-tools/)"  & vbNewLine & _
'                  "for additional information about this tool."
                errorFound = true
              End If
              Set schemaCache = Nothing
              Set xdoc = Nothing
            Else
              str = vbNewLine & "Error:" & vbTab & "Schema file " & _
                  schemaSpec & " not found" & vbNewLine
              errorFound = true
            End If
          End If
        End If

      Else
        str = "Error: "  & vbTab & "Line: " & xdoc.parseError.line & _
          " at position: " & xdoc.parseError.linepos & vbNewLine & _
          "File: " & vbTab & sfile & vbNewLine & _
          "Source:" &vbNewLine & SplitText(xdoc.parseError.srcText, maxLineLen ) & vbNewLine & _
          "Reason:" & vbNewLine & _
          SplitText( xdoc.parseError.reason, maxLineLen ) & vbNewLine &  _
          seearticle
        errorFound = true
      End If
    End If
    ValidateFile = str
End Function

Function WriteOutput(xslProc, htmlfn)
   Dim html, hfile
   dim htmlOutputStream, adTypeText, adSaveCreateOverWrite
   html = xslProc.output
   if (fso.FileExists(htmlfn)) Then
     Set hfile = fso.GetFile(htmlfn)
     hfile.attributes = 0
     fso.DeleteFile(htmlfn)
   End If
   Set htmlOutputStream = CreateObject("ADODB.Stream")
   adTypeText = 2
   htmlOutputStream.Type = adTypeText
   htmlOutputStream.CharSet = "UTF-8"
   htmlOutputStream.Open
   htmlOutputStream.WriteText html
   adSaveCreateOverWrite = 2
   htmlOutputStream.SaveToFile htmlfn, adSaveCreateOverWrite
   WriteOutput = "done"
End function

Function WriteTutorialPages(xslProc, xDoc)
  Dim htmlfn, sections, downloads, resources, authors, writerc, sectionnum
  set sections = xdoc.selectNodes("/dw-document/dw-tutorial/section")
  for sectionnum = 2 to sections.length
    htmlfn = "section" & sectionnum & ".html"
    xslProc.addParameter "page-name", ""
    xslProc.addParameter "page-name", htmlfn
    xslProc.Transform
    writerc = WriteOutput(xslProc, htmlfn)
  next
  Set downloads = xdoc.selectNodes("/dw-document/dw-tutorial/target-content-file|/dw-document/dw-tutorial/target-content-page")
  if downloads.length > 0 Then
    htmlfn = "downloads.html"
    xslProc.addParameter "page-name", ""
    xslProc.addParameter "page-name", htmlfn
    xslProc.Transform
    writerc = WriteOutput(xslProc, htmlfn)
  End If
  Set resources = xdoc.selectNodes("/dw-document/dw-tutorial/resources")
  if resources.length > 0 Then
    htmlfn = "resources.html"
    xslProc.addParameter "page-name", ""
    xslProc.addParameter "page-name", htmlfn
    xslProc.Transform
    writerc = WriteOutput(xslProc, htmlfn)
  End If
  htmlfn = "authors.html"
  xslProc.addParameter "page-name", ""
  xslProc.addParameter "page-name", htmlfn
  xslProc.Transform
  writerc = WriteOutput(xslProc, htmlfn)
  WriteTutorialPages = 0
End function

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

' Convert back slashes to forward slashes for stylesheet
' It gets bitter otherwise
Function MakeURI(inString)
   dim outString, ix, strLen, outMsg
   outString = inString
   strLen = Len(inString)
   ix = InStr( outString, "\" )
   while ix > 0
      if ix < strLen then
         outString = left(outString, ix-1) & "/" & right(outString, (strLen -ix))
      else
         outString = left(outString, ix-1) & "/"
      End if
      ix = InStr( outString, "\" )
   wend
   ix = InStr( outString, " " )
   while ix > 0
      strLen = Len(outString)
      if ix < strLen then
         outString = left(outString, ix-1) & "%20" & right(outString, (strLen -ix))
      else
         outString = left(outString, ix-1) & "%20"
      End if
      ix = InStr( outString, " " )
   wend
   if right(outString, 1) = "/" then
      outString = left(outString, Len(outString)-1)
   End if
   MakeURI = outString
End Function


Sub Main
    Dim fspec, outString, filetype
    ' Main code execution starts here
    'Set global constants and variables.

    errorFound = false
    Set fso = CreateObject("Scripting.FileSystemObject")
    toolpath = fso.GetFile(WScript.ScriptFullName).parentFolder

    dwVersion = GetdWVersion()
'    SetdWVersion
    pgmname = mid(WScript.ScriptName, 1, len(WScript.ScriptName) - 4)
    ' Get the file to be processed
    If Wscript.Arguments.Length > 0 Then
       fSpec = Wscript.Arguments.Item(0)
       if fso.FolderExists(fspec) Then
           fspec = fso.BuildPath(fspec ,"/index.xml")
       End If
    Else
       fSpec = "index.xml"
    End If
    fspec = fso.GetAbsolutePathName(fspec)
    filetype = UCase(fso.GetExtensionName(fspec))
    if filetype = "XML" Then
        If fso.fileExists(fspec) Then
            outString = ValidateFile(fspec)
        Else
           outString = HelpInfo()
        End If
    Else
        outString = "Error: " & vbTab & "File " & fspec & vbNewLine & _
        "is not of type .XML" & vbNewLine & vbNewLine & _
	HelpInfo()
    End If
    Wscript.Echo outString
    ' clean up and exit
    Set fso = Nothing
End Sub

' do the real work
Main

' the following little piece of code handles the bizarre case where the user
' has set the default script host to cscript. Microsoft doesn't seem to provide
' any easy way to figure this out, the the idea is to try writing a warning
' message to stdout. This produces an error if we are running under wscript.
' Thus, if we are running under cscript, we can put up a readline and wait for
' user input before the window goes POOF!
Dim ScriptType, dummyLine
ScriptType="wscript"
on error resume next
wscript.stdout.WriteLine vbNewline & "You appear to have non-standard defaults for Windows script host"
wscript.stdout.writeLine "You can revert to standard behavior by running:"
wscript.stdout.writeLine "  wscript //H:WScript"
wscript.stdout.writeLine "from a DOS command line"
wscript.stdout.writeLine ""
wscript.stdout.writeLine "Press enter to close this window."
if err <> 0 then
  err.clear
  ScriptType="wscript"
else
  ScriptType="cscript"
end if
on error goto 0
if ScriptType <> "wscript" then
  dummyLine=wscript.stdin.readLine
end if


wscript.quit(errorFound)
