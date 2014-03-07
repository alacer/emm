#!/bin/bash
# See the "Author guidelines" tab at 
# http://www.ibm.com/developerworks/aboutdw/
# for more information on how to use this program.
# © Copyright IBM Corporation 2004. All rights reserved.

GetDwDir() 
{
# Get dw directory (parent of dir from which this tool runs)
   local dwdir tooldir
   tooldir=`dirname "$0"`
   dwdir=`(cd "$tooldir/.."; pwd)`
   echo "$dwdir"
}

GetdWVersion() 
{
#  Read current dwVersionPrev from dwversion.txt file.
# Default value is 6.0
   local mydir
   mydir=`dirname "$0"`
   test -f "$mydir/dwversion.txt"
   if [ $? -eq 0  ]; then
      cat "$mydir/dwversion.txt"
   else 
      echo "6.0"
   fi
}

find_link() 
{
  linkval=`which "$1"`
  while [  -L "$linkval" ]; do
    linkval="$(readlink "$linkval")"
  done
  echo "$(basename "$linkval")"
}

get_dialog_program() 
{
  local dialog_pgm=
  local dialog_pgm_list="whiptail dialog"
  local sess_mgr_pid=
  local sess_pgm=
  if [ -n "$SESSION_MANAGER" ]; then
    sess_mgr_pid=$(basename $(echo $SESSION_MANAGER | awk -F[:,] ' { print $2 } '))
  fi
  if [ ! -z "$sess_mgr_pid" ]; then
    if [ -L "/proc/$sess_mgr_pid/exe" ] ; then
      sess_pgm="$(basename $(readlink "/proc/$sess_mgr_pid/exe"))"
    else 
      sess_pgm="$(find_link $(ps -p $sess_mgr_pid -o comm=))"
    fi
    if [ ".$sess_pgm" = ".gnome-session" ]; then
      dialog_pgm_list="zenity gdialog $dialog_pgm_list"
    elif [ ".$sess_pgm" = ".kdeinit" ]; then
      dialog_pgm_list="kdialog $dialog_pgm_list"
    fi
  fi
  for pgm in $dialog_pgm_list;
    do
      if [ ! -z "$(type -p $pgm 2>/dev/null)" ] ; then 
        dialog_pgm="$(basename $(type -p $pgm 2>/dev/null))"
        break
      fi
    done
  echo "$dialog_pgm"
}

findJava() {
# Read last saved Java program from dwjava.txt file.
   local mydir tooldir
   tooldir=$(GetDwDir)
   dwdir=`(cd "$tooldir/.."; pwd)`
   mydir="$tooldir/tools"
   javapgm=""
   test -f "$mydir/dwjava.txt"
   if [ $? -eq 0  ]; then
      javapgm=$(cat "$mydir/dwjava.txt")
      test -f "$javapgm"
      if [ $? -ne 0  ]; then
        javapgm=""
      fi
   fi
   test -n "$javapgm" 
   if [ $? -ne 0  ]; then
     javapgm="$(searchJava)"
     test -n "$javapgm" 
     if [ $? -eq 0  ]; then
       echo "$javapgm">"$mydir/dwjava.txt"
     fi
   fi
   echo "$javapgm"
}

versionGE ()
{
  # Check whether version supplied in $1 is greater than or equal to that in $2
  # Versions are assumed to be of the general form n1.n2.n6.0
  # Comparison is perform3ed integer component by integer component.
  # Returns 0 if $1 at least as big as $2
# # Returns 1 if $1 is a strictly lower version
  # Returns 2 if either version is not of the correct form.
  # Note that x.10 is considered greater than x.9!!
  status="="
  validator="^[0-9][0-9]*\(\.[0-9][0-9]*\)*$"
  testVersion=$(echo "$1" | grep "$validator")
  baseVersion=$(echo "$2" | grep "$validator")
  [ -z "$testVersion" -o -z "$baseVersion" ] && status="X"
  while [ "$status" = "=" -a "$testVersion" != "$baseVersion" ]
    do
      testVal=${testVersion%%.*}
      testVersion=${testVersion#*.}
      baseVal=${baseVersion%%.*}
      baseVersion=${baseVersion#*.}
      [ "$testVal" = "$testVersion" ] && testVersion=""
      [ "$baseVal" = "$baseVersion" ] && baseVersion=""
      if (( "$testVal" > "$baseVal" )) ; then
        status=">"
      elif (( "$testVal" < "$baseVal" )) ; then
        status="<"
      elif [ -z "$testVersion" -a -n "$baseVersion" ] ; then
        status="<"
      elif [ -z "$baseVersion" ] ; then
        testVersion=""
      fi
    done
  if [ "$status" = "=" -o "$status" = ">" ] ; then
    return "0"
  elif [ "$status" = "<" ] ; then
    return "1"
  elif [ "$status" = "X" ] ; then
    return "2"
  fi
}


searchJava() 
{
  mydir=`dirname "$0"`
  ibmj50=`find /opt /usr -maxdepth 8 -type f -ipath "*ibm*[5-9]0*/java" 2>/dev/null | sort -r`
  java50ibm=""
  for fn in $ibmj50; do
    if [  -n "`type -p ${fn} 2>/dev/null`" ]; then
       java50ibm="${fn}"
       break
    fi
  done
  
  if [ -z "$java50ibm" ]; then
     if [ ! -z "$(type -p java 2>/dev/null)" ] ; then 
        whichjava="$(type -p java 2>/dev/null)"
     fi

     optjava=`find /opt -type f -name "java" 2>/dev/null`
     usrjava=`find /usr -type f -name "java" 2>/dev/null`
     java15pgm=""
     for jpgm in $whichjava $optjava $usrjava; do
        javacheck=`$jpgm -cp "${mydir}/dwxmlxslt.jar" DeveloperWorksJavaCheck | head -n 1`

        javalevel=`echo "$javacheck" | awk -F"\t" '{print $1}'`
        javaruntimelevel=`echo "$javacheck" | awk -F"\t" '{print $2}'`
        javavendor=`echo "$javacheck" | awk -F"\t" '{print $3}'`
        if [ "$javalevel" = "1.5" ]; then
           if [ -z "$java15pgm" ] ; then
              java15pgm="$jpgm"
           fi
        fi
     done
  fi
  if [ -n "$java50ibm" ] ; then
      echo "$java50ibm"
  elif [ -n "$java15pgm" ] ; then
     echo "$java15pgm"
  else
     echo ""
  fi
}

displayMessage() 
{
  dialog_pgm=`get_dialog_program`
  title="IBM developerWorks"
  msg="$1"
  msgtype="${2:-"info"}"
  case "$dialog_pgm" in
    "whiptail")
      whiptail --title "$title" --msgbox "$msg" 0 0
    ;;
    "dialog")
      dialog --no-lines --title "$title" --msgbox "$msg" 0 0 
    ;;
    "gdialog")
      gdialog --title "$title" --msgbox "$msg" 25 60 
    ;;
    "zenity")
      # Zenity or GTk must use XML markup internally as <> cause problems
      msg2="$(echo "$msg" | sed -e 's/>/\&gt;/g;s/</\&lt;/g')"
      if [[ "$msgtype" == "error" ]] ; then
        zenity --title "$title" --error --text="$msg2" 2>/dev/null
      else
        zenity --title "$title" --info --text="$msg2" 2>/dev/null
      fi
    ;;
    "kdialog")
      if [[ "$msgtype" == "error" ]] ; then
        kdialog --title "$title" --error "$msg"
      else
        kdialog --title "$title" --msgbox "$msg"
      fi
    ;;
  esac
  echo ""
}

# Main routine starts here
if [ $# -gt 0 ] ; then
   javapgm=`findJava`
   dialog_pgm=`get_dialog_program`
   if [ -n "$javapgm" ] ; then
      xalanver=$($javapgm org.apache.xalan.Version 2>>/dev/null)
      if [ -z "$xalanver" ]; then
         displayMessage "The script requires Apache Xalan Java version 2.5 or better" "error"
      else
         echo "$xalanver" | grep -qs TXE
         usingTXE=$?
         if [ $usingTXE -eq 0 ]; then
           xalanvernum="2.7"
         else 
           xalanvernum=$(echo "$xalanver" | awk ' { print $3 } ' | sed -e 's/\([0-9][0-9]*\.[0-9][0-9]*\).*/\1/')
         fi
         xvmaj=${xalanvernum%.*}
         xvmin=${xalanvernum#*.}
         if [ $xvmaj -gt 2 ] || [ $xvmaj -eq 2 -a $xvmin -ge 5 ] ; then 
            xmlFile="$1"
            dwDir=`GetDwDir`
            dwVersions=`GetdWVersion`
            dwVersionPrev="${dwVersions%/*}"
            dwVersionV16="${dwVersions#*/}"
            getContentTypeXslFile="${dwDir}/tools/dw-content-type-and-site.xsl"
            contentInfo=`$javapgm "org.apache.xalan.xslt.Process" -IN "$xmlFile" "-XSL" "$getContentTypeXslFile" 2>/dev/null`
            contentLine=$(echo "$contentInfo"|grep "^content-type=")
            localSiteLine=$(echo "$contentInfo"|grep "^local-site=")
            contentType="${contentLine#content-type=}"
            localSite="${localSiteLine#local-site=}"
            if [ -x "$contentType" ]; then
               displayMessage "Cannot determind content type (e.g. dw-article)"  "error"
            elif [ -x "$localSite" ]; then
               displayMessage "Cannot determind local site (e.g. worldwide)"  "error"
            else
               previewFileCandidate="${contentType}-preview-${localSite}-${dwVersionV16}.xsl"
               previewFile=$(find "$dwDir/xsl/$dwVersionV16" -name "$previewFileCandidate")
echo "$contentType $localSite pf=$previewFile pfc=$previewFileCandidate" >> ~/junk
               if [ -n "$previewFile" ]; then             
                 schemaFile="${dwDir}/schema/${dwVersionV16}/dw-document-${dwVersionV16}.xsd"
		 # RTC 14070: spaces in paths. ITO 11/05/2012
		 # needs testing on Linux, OSX
                 # xslFile="$(dirname $previewFile)/dw-document-html-${localSite}-${dwVersionV16}.xsl"
		 xslFile=$(dirname "$previewFile")"/dw-document-html-${localSite}-${dwVersionV16}.xsl"
		 
               else
                 schemaFile="${dwDir}/schema/${dwVersionPrev}/dw-document-${dwVersionPrev}.xsd"
                 xslFile="${dwDir}/xsl/${dwVersionPrev}/dw-document-html-${dwVersionPrev}.xsl"
               fi
               mycp="${dwDir}/tools/dwxmlxslt.jar"
               if [ ! -z "$CLASSPATH" ]; then
                  mycp="$mycp:$CLASSPATH"
               fi
               forceFactory="-Djavax.xml.transform.TransformerFactory=org.apache.xalan.processor.TransformerFactoryImpl"
              if [ $usingTXE -eq 0 ]; then
                  result1=`$javapgm "$forceFactory" -cp "$mycp" DeveloperWorksXML "$xmlFile" "$schemaFile"`
               else
                  result1=`$javapgm -cp "$mycp" DeveloperWorksXML "$xmlFile" "$schemaFile"`
               fi 
               echo "$result1" | tail -n 2 | grep -q "is a valid $contentType"
echo "$javapgm $forceFactory -cp $mycp DeveloperWorksXML $xmlFile $schemaFile" >> ~/junk
echo "r1= $result1" >> ~/junk
               if [ $? -ne 0 ] ; then
                 displayMessage "$result1" "error"
               else 
                   if [ $usingTXE -eq 0 ]; then
                     result2=`$javapgm "$forceFactory" -cp "$mycp" DeveloperWorksXML "$xmlFile" "$xslFile"`
                  else
                     result2=`$javapgm -cp "$mycp" DeveloperWorksXML "$xmlFile" "$xslFile"`
                  fi 
                  result2=`echo "$result2" | grep -v "^Using Java runtime"`
                  echo "$result2" | tail -n 2 | grep -q "^Output file"
                  if [ $? -ne 0 ] ; then
                    displayMessage "$result1" "error"
                  else 
                    displayMessage "$result1\n\n$result2" "info"
                  fi
               fi
           fi
         else
             displayMessage "Xalan Java version $xalanvernum not 2.5 or greater"  "error"
         fi
      fi
   else
      displayMessage "Error: Could not find suitable Java 5 version" "error"
   fi
else
   displayMessage "Error: No arguments specified" "error"
fi

