/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	run("Bio-Formats (Windowless)", "open=["+input + File.separator + file+"]");
	imageName=getTitle();
	name=split(imageName,".");
	if (name.length-2 > 0) {
		saveName=name[0]+"."+name[1];
	} else {
		saveName=name[0];
	}
	print(saveName);
	selectImage(imageName);
	run("Z Project...", "projection=[Max Intensity]");
	selectImage(imageName);
	close();
	selectImage("MAX_"+imageName);
	run("OrientationJ Analysis", "tensor=2.0 gradient=0 color-survey=on hsb=on hue=Orientation sat=Coherency bri=Original-Image radian=on ");
	selectImage("OJ-Color-survey-1");
	saveAs("Tiff", output+File.separator +saveName+"_OJ-Color-survey-1.tif");
	close();
	selectImage("MAX_"+imageName);
	run("OrientationJ Distribution", "tensor=2.0 gradient=0 radian=on orientation mask=on histogram=off table=on min-coherency=0.0 min-energy=0.0 ");
	selectImage("OJ-Histogram-1-slice-1");
	saveAs("PNG", output+File.separator +saveName+"_OJ-Histogram-1-slice-1.png");
	close();
	selectImage("OJ-Histogram-1-slice-2");
	saveAs("PNG", output+File.separator +saveName+"_OJ-Histogram-1-slice-2.png");
	close();
	selectWindow("OJ-Distribution-1");
	saveAs("Results", output+File.separator +saveName+"_OJ-Distribution-1.csv");
	run("Close");
	selectImage("MAX_"+imageName);
	saveAs("Tiff", output+File.separator +saveName+"_MAX.tif");
	close();
	run("Close All");
}
