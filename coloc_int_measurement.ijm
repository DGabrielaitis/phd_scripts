//2020 - 08 - 19
//Dovydas Gabrielaitis
//dovydas.gabrielaitis@gmc.vu.lt

//A simple macro that measures the Fluroescence intensity in colocalised pixels.

// For every sample please set the Subtract background and Gaussian filter parameters
// as this may cause issues with the segmentation later.

// This works with a 2 channel stack, where the the final intensities are meazured in Ch1
//
//When duplicating, please leave the suggested names 
// script starts here

//clear results if left from previous measurement
run("Clear Results");
//to avoid confusion, the selected file is renames into 'original'
rename("original");
//split stack into separate images so that it makes it easier to work with
run("Stack to Images");

//start with C1
selectWindow("original-0001");
	run("Duplicate...", "original-0001-1");
	selectWindow("original-0001-1");
	run("Subtract Background...", "rolling=50");
	run("Gaussian Blur...", "sigma=2");
	setAutoThreshold("Otsu dark");
	setOption("BlackBackground", false);
	run("Convert to Mask");
	//here we divide the image into a binary image. see later for clarification
	run("Divide...", "value=255");

// move to C2
selectWindow("original-0002");
	run("Duplicate...", "original-0002-1");
	selectWindow("original-0002-1");
	run("Subtract Background...", "rolling=200");
	run("Gaussian Blur...", "sigma=2");
	setAutoThreshold("Otsu dark");
	run("Convert to Mask");
	run("Divide...", "value=255.000");
// make a composite of both of the binary images. This gives an image, where:
// 0 = background
// 1 = signal (from either of chanels
// 2 = colocalised pixels
imageCalculator("Add create", "original-0001-1","original-0002-1");


// threshold the colocalised pixels into a mask
selectWindow("Result of original-0001-1");
setAutoThreshold("Otsu dark");
setAutoThreshold("Default dark");
setThreshold(2, 255);
run("Convert to Mask");

//we have a mask, so now we can plug it onto our original image
run("Create Mask");
run("Create Selection");
roiManager("Split");
selectWindow("original-0001");
run("Restore Selection");
roiManager("Measure");


//phew...
// finally close the windows, so that we wouldn't have so much clutter.
//close all windows afterwards and clear the ROI Manager.

//clear ROI Manager (just in case)
run("Select All");
roiManager("Deselect");
roiManager("Delete");
// close ROI manager
selectWindow("ROI Manager");
run("Close");
// and finally close everything
  macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 
