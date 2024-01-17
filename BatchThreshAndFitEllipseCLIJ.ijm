/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".oir") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

// Init GPU
run("CLIJ2 Macro Extensions", "cl_device=");

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
run("Duplicate...", "duplicate channels=1");
image_1 = getTitle();
Ext.CLIJ2_pushCurrentZStack(image_1);

// Copy
Ext.CLIJ2_copy(image_1, image_2);
Ext.CLIJ2_release(image_1);

//Ext.CLIJ2_pull(image_2);

// Threshold Max Entropy
Ext.CLIJ2_thresholdMaxEntropy(image_2, image_3);
//Ext.CLIJ2_thresholdTriangle(image_2, image_3);
Ext.CLIJ2_release(image_2);

//Ext.CLIJ2_pull(image_3);

// Connected Components Labeling Box
Ext.CLIJ2_connectedComponentsLabelingBox(image_3, image_4);
Ext.CLIJ2_release(image_3);

//Ext.CLIJ2_pull(image_4);
//run("glasbey_on_dark");

// Exclude Labels On Edges
Ext.CLIJ2_excludeLabelsOnEdges(image_4, image_5);
Ext.CLIJ2_release(image_4);

//Ext.CLIJ2_pull(image_5);
//run("glasbey_on_dark");

// Exclude Labels Outside Size Range
minimum_size = 10.0;
maximum_size = 600.0;
Ext.CLIJ2_excludeLabelsOutsideSizeRange(image_5, image_6, minimum_size, maximum_size);
Ext.CLIJ2_release(image_5);

Ext.CLIJ2_pull(image_6);
run("glasbey_on_dark");

name1=split(image_1,".");
if (name1.length > 1) {
name2=split(name1[0]+"."+name1[1],"/");
} else {
	name2=split(name1[0],"/");
}
name=name2[name2.length-1];
save(output + File.separator + name + "_Objects.tif");
Ext.CLIJ2_release(image_4);

//Fit ellipses
run("3D Ellipsoid Fitting", "draw_vectors");

//Save outputs
	print("Saving to: " + output);
	selectImage("Ellipsoids");
	save(output + File.separator + name + "_Ellipsoids.tif");
	selectImage("Vectors1 (Max)");
	save(output + File.separator + name + "_Vectors1.tif");
	selectImage("Vectors2 (Middle)");
	save(output + File.separator + name + "_Vectors2.tif");
	selectImage("Vectors3 (Min)");
	save(output + File.separator + name + "_Vectors3.tif");
	selectWindow("Results");
	saveAs("results", output + File.separator + name + "_results.csv");
	run("Close");
	close("*");
}
