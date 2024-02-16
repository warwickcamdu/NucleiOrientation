#@ File (label = "Results Folder", style = "directory") results_folder
#@ File (label = "Save Location", style = "directory") output

list = getFileList(results_folder);
for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], ".csv")){
			processFile(results_folder, list[i]);
		}
}

function processFile(folder,file){
//run("Bio-Formats (Windowless)", "open=["+image_folder + File.separator + list[0]+"]");
open(results_folder+ File.separator + file);
print(file);
name_part=split(file,"-");
print(name_part[0]);
IJ.renameResults(file,"Results");
XY2_pref=prefNucleiOri("XY2(deg)");
print("Preferred Nuclei Orientation XY: "+XY2_pref);
XZ2_pref=prefNucleiOri("XZ2(deg)");
print("Preferred Nuclei Orientation XZ: "+XZ2_pref);
YZ2_pref=prefNucleiOri("YZ2(deg)");
print("Preferred Nuclei Orientation YZ: "+YZ2_pref);
count=nResults();
XY2_norm=newArray(count);
XZ2_norm=newArray(count);
YZ2_norm=newArray(count);
for (i = 0; i < count; i++) {
    XY2_norm[i]= abs(getResult("XY2(deg)", i)-XY2_pref);
    XZ2_norm[i]= abs(getResult("XZ2(deg)", i)-XZ2_pref);
    YZ2_norm[i]= abs(getResult("YZ2(deg)", i)-YZ2_pref);
}
replaceIntensity(results_folder, name_part[0], XY2_norm, "XY2");
replaceIntensity(results_folder, name_part[0], XZ2_norm, "XZ2");
replaceIntensity(results_folder, name_part[0], YZ2_norm, "YZ2");
selectWindow("Results");
run("Close");
Array.show("Results (row numbers)",XY2_norm,XZ2_norm,YZ2_norm);
saveAs("Results",output + File.separator + name_part[0] + "_normangles.csv");
selectWindow("Results");
run("Close");
close("*");
}

//Replace intensity values with orienation value
function replaceIntensity(results_folder, name, deg_norm, angle_str){
open(results_folder + File.separator + name + "-1.oir_Ellipsoids.tif");
image=getTitle();
run("32-bit");
totalZ=nSlices;
selectImage(image);
setThreshold(1, 1E30);
for (j = 1; j <= totalZ; j++) {
    setSlice(j);
    min=getValue("Min limit");
    max=getValue("Max limit");
    for (i = min; i <= max; i++) {
    changeValues(i, i, deg_norm[i-1]);
    }
}
saveAs("Tiff", output + File.separator  + name_part[0] + "_Ellipsoids"+angle_str+".tif");
}

function prefNucleiOri (angle_str){
count=nResults();
nan_total=0;
deg=newArray(count);
for (i = 0; i < count; i++) {
    deg[i]= getResult(angle_str, i);
    if (isNaN(deg[i])){
    	nan_total=nan_total+1;
    }
}
print(nan_total + " NaN values found");
//Remove NaNs and caluclate mean
Array.sort(deg);
deg=Array.slice(deg,0,count-nan_total);
Array.getStatistics(deg, min, max, mean, stdDev);
return mean
}