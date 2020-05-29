// @String(label="iSCAT filtering protocol", description="Chose between Normal, Median or Average", value="Normal") Process
// @Integer(label="Filter large structures", value=13) FL
// @Integer(label="Filter Small structures", value=1) FS
// @Integer(label="Tolerance of direction", value=10) Tol
// @Boolean(label="Bandpass Filtering?", value=true) doBPfilter
// @Boolean(label="Save when job is done?", value=false) SaveMe
// @Boolean(label="Gaussian blurr?", value=false) Blurr
// @Double(label="Sigma", value=2) Sigma

Title=getTitle;
id1=getImageID();
BitDepth=bitDepth();
Path=getDirectory("image");

if (BitDepth!=32) run("32-bit");
if (indexOf(Process, "Median")>0) {
	run("Temporal Moving Median", "half=100 undersampling=20");
} else if (indexOf(Process, "Average")>0) {
	run("Temporal Moving Median", "half=100 undersampling=20");
} else if (indexOf(Process, "Normal")>0) {
	run("Z Project...", "projection=Median");
	id2=getTitle();
	imageCalculator("Divide create 32-bit stack", id1,id2);
	id3=getTitle();
	selectWindow(id3);
	run("Subtract...", "value=1 stack"); //Subtracts the value 
}
ID2=getImageID();
Title2=getTitle();
Duplicata=Title2;
getDimensions(a,b,c,f, Slices);

run("Set Measurements...", "area mean standard min median stack display redirect=None decimal=3");

if(doBPfilter){
	run("Duplicate...", "title=FL"+FL+"_FS"+FS+"_"+Title2+" duplicate");
	Duplicata=getTitle;
	selectWindow(Duplicata);
	run("Bandpass Filter...", "filter_large="+FL+" filter_small="+FS+" suppress=None tolerance="+Tol+" autoscale saturate process");
}

/*for (i=1;i<Slices+1;i++){
	setSlice(i);
	run("Select All");
	run("Measure");
	medInt=getResult("Median",nResults-1);
	run("Select All");
	run("Subtract...", "value="+medInt);
}*/
//print(f);
for (i=1;i<f+1;i++){
		setSlice(i);
		
		getStatistics(area, mean);
		run("Subtract...", "value="+mean);
	}
//setMinAndMax(-0.0030, 0.0020);
setMinAndMax(-0.0070, 0.0060);
if (Blurr) run("Gaussian Blur...", "sigma="+Sigma+" stack");
if (SaveMe) saveAs("Tiff", Path+"\\"+Duplicata);
