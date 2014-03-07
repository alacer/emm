// DwImageSize class
//
// This sample class is designed to report the size of an image
// by loading it and then reporting width and height. On Linux
// an operation X Window system is required.
// The program takes one or more input graphic file names which may be
// in the local file system, or on the web via http.
// Files with a protocol-independent URL (e.g. "//www.ibm.com/xxx")
// will be checked for by prefixzing the URL with "http:".
// similarly, files that start with a single slash (/) will be checked
// for by prefixing the name with "http://www.ibm.com"
// For each image found whose height and width are available a 
// single line is output showing the source, full source (as expanded for // and / URLs)
// For example: java -cp DwImageSize.jar DwImageSize figure1.gif
// might report
// src=figure1.gif full=figure1.gif height=146 width=315
// If there is an error, then the line will contain the word "Error!" followed
// by the failing input parameter.
// Author - Ian Shields ishields@us.ibm.com
// © Copyright IBM Corporation 2007. All rights reserved.

import java.lang.String;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.File;
import java.io.IOException;
import java.net.URL;

public class DeveloperWorksImageSize {
    public static void main(String[] args)
    {  
	BufferedImage img = null;
	for (int ix = 0; ix < args.length; ix++) {
	    String imageToCheck = args[ix];
	    if (args[ix].length() >= 2 && args[ix].charAt(0) == '/') {
		if (args[ix].charAt(1) == '/') {
		    imageToCheck = "http:" + args[ix];
		} else {
		    imageToCheck = "http://www.ibm.com" + args[ix];
		}
	    }
	    if (imageToCheck.indexOf("://") >= 0) {
	        try {
		    img = ImageIO.read(new URL(imageToCheck));
		    System.out.println("src=" + args[ix] + " full="
				       + imageToCheck + " height=" + img.getHeight()
				       + " width=" + img.getWidth());
		} catch (IOException e) {
		    System.out.println("Error! " + args[ix]);
		}
	    } else {
		try {
		    img = ImageIO.read(new File(imageToCheck));
		    System.out.println("src=" + args[ix] + " full="
				       + imageToCheck + " height=" + img.getHeight()
				       + " width=" + img.getWidth());
		} catch (IOException e) {
		    System.out.println("Error! " + args[ix]);
		}
	    }
	}
    }
}

