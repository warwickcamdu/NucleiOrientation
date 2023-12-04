imageName=getTitle();
run("Split Channels");
selectImage("C1-"+imageName);
setOption("BlackBackground", true);
run("Convert to Mask", "method=MaxEntropy background=Dark calculate black create");
run("3D OC Options", "  dots_size=5 font_size=10 store_results_within_a_table_named_after_the_image_(macro_friendly) redirect_to=none");
run("3D Objects Counter", "threshold=128 slice=50 min.=10 max.=104857600 exclude_objects_on_edges objects summary");
run("3D Ellipsoid Fitting", "draw_vectors");
