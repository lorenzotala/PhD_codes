// @Integer(label="Filter large structures", value=13) FL
// @Integer(label="Filter Small structures", value=1) FS
// @Integer(label="Tolerance of direction", value=10) Tol
// @Boolean(label="Bandpass Filtering?", value=true) doBPfilter
// @Boolean(label="Save when job is done?", value=false) SaveMe
// @Boolean(label="Gaussian blurr?", value=false) Blurr
// @Double(label="Sigma", value=2) Sigma

Title=getTitle;
BitDepth=bitDepth();
Path=getDirectory("image");
Duplicata=Title;
if (BitDepth!=32) run("32-bit");

getDimensions(a,b,c,f, Slices);

run("Set Measurements...", "area mean standard min median stack display redirect=None decimal=3");

if(doBPfilter){
	run("Duplicate...", "title=FL"+FL+"_FS"+FS+"_"+Title+" duplicate");
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

