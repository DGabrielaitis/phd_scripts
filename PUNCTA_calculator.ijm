run("Clear Results");
// get file name
file_name = getTitle();

run("Duplicate...", "title=duplicate");
run("Subtract Background...", "rolling=50");
run("Gaussian Blur...", "sigma=2");
//do automatic Otsu
setAutoThreshold("Otsu");
run("Convert to Mask");
run("Create Mask");
run("Create Selection");
roiManager("Split");
selectWindow(file_name);
run("Restore Selection");
roiManager("Measure");


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