


// script starts here

run("HeLa Cells (48-bit RGB)");
run("Duplicate...", "duplicate channels=1-2");
selectWindow("hela-cells.tif");
close();
selectWindow("hela-cells-1.tif");
rename("original");
run("Split Channels");
//start with C1
selectWindow("C1-original");
run("Duplicate...", "");
selectWindow("C1-original-1");
run("Subtract Background...", "rolling=50");
run("Gaussian Blur...", "sigma=2");
setAutoThreshold("Otsu dark");
//run("Threshold...");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Divide...", "value=255");

// move to C2
selectWindow("C2-original");
run("Duplicate...", "");
run("Subtract Background...", "rolling=50");
run("Gaussian Blur...", "sigma=2");
setAutoThreshold("Otsu dark");
//run("Threshold...");
run("Convert to Mask");
run("Divide...", "value=255.000");
// make a composite of both of the binary images. This gives an image, where:
// 0 = background
// 1 = signal (from either of chanels
// 2 = colocalised pixels
imageCalculator("Add create", "C1-original-1","C2-original-1");
// start work wirht the coloc masks. first we create the coloc binary mask
selectWindow("Result of C1-original-1");
setAutoThreshold("Otsu dark");
//run("Threshold...");
setAutoThreshold("Default dark");
setThreshold(2, 255);
run("Convert to Mask");
//do mask stuff
run("Create Mask");
run("Create Selection");
roiManager("Split");
selectWindow("C1-original");
run("Restore Selection");
roiManager("Measure");

// afterwards clear everything

run("Select All");
roiManager("Deselect");
roiManager("Delete");


//close all windows afterwards
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 

