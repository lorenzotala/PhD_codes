// @String(label="iSCAT filtering protocol", description="Chose between: Nothing, Normal, Median, Average or Differential", value="Normal") Process
// @Integer(label="Filter large structures", value=13) FL
// @Integer(label="Filter Small structures", value=1) FS
// @Integer(label="Tolerance of direction", value=10) Tol
// @Integer(label="Half window", value=100) half
// @Integer(label="Undersampling factor", value=20) usf
// @Boolean(label="Bandpass Filtering?", value=true) doBPfilter
// @Boolean(label="Save when job is done?", value=false) SaveMe
// @Boolean(label="Gaussian blurr?", value=false) Blurr
// @Double(label="Sigma", value=2) Sigma

Title=getTitle;
id1=getImageID();
BitDepth=bitDepth();
Path=getDirectory("image");
getDimensions(a,b,c,Slices,Frames);
if (Slices>Frames) {
	use_slices=true;
} else {
	use_slices=false;
}

TimeA=getTime;
if (BitDepth!=32) run("32-bit");
if (indexOf(Process, "Median")>=0) {
	run("Temporal Moving Median", "half="+half+" undersampling="+usf);
} else if (indexOf(Process, "Average")>=0) {
	run("Temporal Moving Average", "half="+half+" undersampling="+usf);
} else if (indexOf(Process, "Normal")>=0) {
	run("Z Project...", "projection=Median");
	id2=getImageID();
	imageCalculator("Divide create 32-bit stack", id1,id2);
	id3=getImageID();
	selectImage(id3);
	rename("Processed_"+Title);
	run("Subtract...", "value=1 stack"); //Subtracts the value
	selectImage(id2);
	close();
	selectImage(id3);
} else if (indexOf(Process, "Differential")>=0) {
	getDimensions(a,b,c,Slices,Frames);
	run("Duplicate...", "title="+Title+"_1 duplicate");
	IDcopy1=getImageID();
	run("Duplicate...", "title="+Title+"_2 duplicate");
	IDcopy2=getImageID();
	if(use_slices){
		setSlice(Slices);
	} else {
		Stack.setFrame(Frames);
	}
	run("Delete Slice");
	selectImage(IDcopy1);
	if(use_slices){
		setSlice(1);
	} else {
		Stack.setFrame(1);
	}
	run("Delete Slice");
	imageCalculator("Subtract create 32-bit stack", IDcopy1,IDcopy2);
	id3=getImageID();
	rename("Differential_"+Title);
	selectImage(IDcopy1);
	close();
	selectImage(IDcopy2);
	close();
	selectImage(id3);
} else if (indexOf(Process, "Nothing")>=0) {}

ID2=getImageID();
Title2=getTitle();
getDimensions(a,b,c,Slices,Frames);
if (Slices>Frames) {
	use_slices=true;
} else {
	use_slices=false;
}

if(use_slices){
	f=Slices;
} else {
	f=Frames;
}
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
	if(use_slices){
		setSlice(i);
	} else {
		Stack.setFrame(i);
	}
		
		getStatistics(area, mean);
		run("Subtract...", "value="+mean);
}
//setMinAndMax(-0.0030, 0.0020);
//setMinAndMax(-0.0015, 0.0015);
getStatistics(area, mean, min, max, std, histogram);

diff_x_val=linspace(min, max, (max-min)/(histogram.length-1));
diff_hist=diff(histogram);
Array.getStatistics(diff_hist, thresh_min, thresh_max, mean, stdDev);
factor=0.1;

min_set=findHigherTreshold(diff_hist, thresh_max*factor);

max_set=findLowerTreshold(diff_hist, thresh_min*factor);

//Plot.create("Histogram", "Value", "Count", diff_x_val, diff_hist);
//print(diff_x_val[min_set[0]]+", "+ diff_x_val[max_set[max_set.length-1]]);
setMinAndMax(diff_x_val[min_set[0]], diff_x_val[max_set[max_set.length-1]]);
if (Blurr) run("Gaussian Blur...", "sigma="+Sigma+" stack");
if (SaveMe) saveAs("Tiff", Path+"\\"+Duplicata);

if (indexOf(Process, "Nothing")<0) {
	selectImage(ID2);
	close();
}

TimeB=getTime;
ElapsedTime=(TimeB-TimeA)/1000;
print("Elapsed Time: "+ElapsedTime+" s");
beep();

//-------------------------------------------------Functions-------------------------------------------------

function diff(MyArray){
	diff_array=newArray(MyArray.length-1);
	for(i=0;i<MyArray.length-1;i++){
		diff_array[i]=MyArray[i+1]-MyArray[i];
	}
	return diff_array;
}

function linspace(start, end, spacing){
	length=round((end-start)/spacing);
	x_val=newArray(length);
	for(i=0; i<length; i++){
		x_val[i]=start+i*spacing; 
	}
	return x_val;
}

function findHigherTreshold(myArray, Threshold){
	Indexes=newArray;
	for (i=0; i<myArray.length; i++){
		if(myArray[i]>Threshold){
			Indexes=Array.concat(Indexes,i);
		}
	}
	return Indexes;
}

function findLowerTreshold(myArray, Threshold){
	Indexes=newArray;
	for (i=0; i<myArray.length; i++){
		if(myArray[i]<Threshold){
			Indexes=Array.concat(Indexes,i);
		}
	}
	return Indexes;
}
