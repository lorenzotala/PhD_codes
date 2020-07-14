timeA=getTime();
setBatchMode(true);
dir=getDirectory("Choose a Directory");
dirList=getFileList(dir);
d=0;
stopDir=true;
while (stopDir) {
	if (endsWith(dirList[d], "/")){
		d=d+1;
	} else {
		if(d>0||d<dirList.length-1){
			start=Array.slice(dirList,0,d);
			end=Array.slice(dirList,d+1,dirList.length);
			dirList=Array.concat(start,end);
		} else if(d==0){
			dirList=Array.slice(dirList,d+1,dirList.length);
		} else if(d==(dirList.length-1)){
			dirList=Array.slice(dirList,0,d);
		}
	}
	
	if(d==dirList.length){
		stopDir=false;
	}
}
print(dirList.length);

if (dirList.length==0) {
	print("Welcome to the extraction of the PhaseContrast, Red and Green fluorescence channel of nd2 files");
	Dir=dir;
	splitDir=Dir + File.separator+"Split";
	print("Images will be saved in the following folder:\n" + splitDir);
	print("Extraction in progress, please wait. \n");
	File.makeDirectory(splitDir);
	File.makeDirectory(splitDir+File.separator+"PhaseContrast");
	File.makeDirectory(splitDir+File.separator+"RFP");
	File.makeDirectory(splitDir+File.separator+"FITC");
	list = getFileList(Dir);
	percent=0;
	progressBar="#";
	n=0;
	stopit=true;
	AVGBkg=0;
	AVGFrames=newArray(0);
	while (stopit) {
		if((endsWith(list[n], ".nd2"))){
			if(indexOf(list[n], "Bkg")>-1){		
				if(n>0||n<list.length-1){
					start=Array.slice(list,0,n);
					end=Array.slice(list,n+1,list.length);
					list=Array.concat(start,end);
				} else if(n=0){
					list=Array.slice(list,n+1,list.length);
				} else if(n=list.length-1){
					list=Array.slice(list,0,n);
				}
			} else totImages=totImages+1;
		} n=n+1;
		if(n>lengthOf(list)-1) stopit=false;
	}
	print("tot images = " + totImages+"\n");
	for (i=0; i<list.length; i++) {
	     if (endsWith(list[i], ".nd2")){
	     	print("\\Update:"+percent+"% :"+progressBar);		
			run("Bio-Formats Importer", "open=["+Dir+File.separator+list[i]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
			
			selectWindow(list[i]+" - C=0");
			imgName=getTitle();
			idPC=getImageID();
			run("Bin...", "x=2 y=2 z=1 bin=Average");
			saveAs("Tiff", splitDir+File.separator+"PhaseContrast"+File.separator+imgName+".tif");
		
			selectWindow(list[i]+" - C=1");
			imgName=getTitle();
			idRFP=getImageID();
			run("Duplicate...", "use");
			idRFP_first=getImageID;
			run("Subtract Background...", "rolling=50 sliding");
			run("Bin...", "x=2 y=2 z=1 bin=Average");
			temp=getValue("Median");
			AVGFramesRFP=Array.concat(AVGFrames,temp);
			saveAs("Tiff", splitDir+File.separator+"RFP"+File.separator+imgName+".tif");
		
			selectWindow(list[i]+" - C=2");
			imgName=getTitle();
			idFITC=getImageID();
			run("Duplicate...", "use");
			idFITC_first=getImageID;
			run("Subtract Background...", "rolling=50 sliding");
			run("Bin...", "x=2 y=2 z=1 bin=Average");
			temp=getValue("Median");
			AVGFramesFITC=Array.concat(AVGFrames,temp);
			saveAs("Tiff", splitDir+File.separator+"FITC"+File.separator+imgName+".tif");
			
			run("Close All");
	    }
	     percent=floor((i+1)/list.length*100);
	     progressBar=progressBar+"#";
	}
	print("\\Update:"+percent+"%"+progressBar);
	run("Close All");
} else{
	for (j=0; j<dirList.length; j++) {
		print("Welcome to the batch extraction of the PhaseContrast, Red and Green fluorescence channel of nd2 files");
		Dir=dir+dirList[j];
		splitDir=Dir+"Split";
		print("Images will be saved in the following folder:\n" + splitDir);
		print("Extraction in progress, please wait. \n");
		File.makeDirectory(splitDir);
		File.makeDirectory(splitDir+File.separator+"PhaseContrast");
		File.makeDirectory(splitDir+File.separator+"RFP");
		File.makeDirectory(splitDir+File.separator+"FITC");
		list = getFileList(Dir);
		Array.print(list);
		percent=0;
		progressBar="#";
		n=0;
		stopit=true;
		AVGBkg=0;
		AVGFrames=newArray(0);
		while (stopit) {
			if((endsWith(list[n], ".nd2"))){
				if(indexOf(list[n], "Bkg")>-1){		
					if(n>0||n<list.length-1){
						start=Array.slice(list,0,n);
						end=Array.slice(list,n+1,list.length);
						list=Array.concat(start,end);
					} else if(n=0){
						list=Array.slice(list,n+1,list.length);
					} else if(n=list.length-1){
						list=Array.slice(list,0,n);
					}
				} else totImages=totImages+1;
			} n=n+1;
			if(n>lengthOf(list)-1) stopit=false;
		}
		print("tot images = " + totImages+"\n");
		for (i=0; i<list.length; i++) {
		     if (endsWith(list[i], ".nd2")){
		     	print("\\Update:"+percent+"% :"+progressBar);		
				run("Bio-Formats Importer", "open=["+Dir+File.separator+list[i]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
				imgName=getTitle();
				print(imgName);
				selectWindow(list[i]+" - C=0");
				imgName=getTitle();
				idPC=getImageID();
				run("Bin...", "x=2 y=2 z=1 bin=Average");
				saveAs("Tiff", splitDir+File.separator+"PhaseContrast"+File.separator+imgName+".tif");
			
				selectWindow(list[i]+" - C=1");
				imgName=getTitle();
				idRFP=getImageID();
				run("Duplicate...", "use");
				idRFP_first=getImageID;
				run("Subtract Background...", "rolling=50 sliding");
				run("Bin...", "x=2 y=2 z=1 bin=Average");
				temp=getValue("Median");
				AVGFramesRFP=Array.concat(AVGFrames,temp);
				saveAs("Tiff", splitDir+File.separator+"RFP"+File.separator+imgName+".tif");
			
				selectWindow(list[i]+" - C=2");
				imgName=getTitle();
				idFITC=getImageID();
				run("Duplicate...", "use");
				idFITC_first=getImageID;
				run("Subtract Background...", "rolling=50 sliding");
				run("Bin...", "x=2 y=2 z=1 bin=Average");
				temp=getValue("Median");
				AVGFramesFITC=Array.concat(AVGFrames,temp);
				saveAs("Tiff", splitDir+File.separator+"FITC"+File.separator+imgName+".tif");
				
				run("Close All");
		    }
		     percent=floor((i+1)/list.length*100);
		     progressBar=progressBar+"#";
		}
	
	print("\\Update:"+percent+"%"+progressBar);
	run("Close All");
	}
}	
	setBatchMode(false);
	
	timeB=getTime();
	ExecTime=(timeB-timeA)/1000;
	
	Array.getStatistics(AVGFrames, min, max, meanOfmedians, stdDevOfmedians);
	
	if((meanOfmedians+stdDevOfmedians)<AVGBkg){
		print("Bkg median value = "+AVGBkg);
		print("Frame median value = "+meanOfmedians+" (std="+stdDevOfmedians+")");
		Dialog.create("Warning");
			Dialog.addMessage("Background correction induced negative intensity values!\n Please consider choosing a better background image");
		Dialog.show();
	}
	
print("done in "+ExecTime+" s");








/*

selectWindow("fliC-_PaQa_t0h001.nd2 - C=0");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=1");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=2");
run("Bin...", "x=2 y=2 z=301 bin=Average");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=1");
run("Bin...", "x=2 y=2 z=301 bin=Average");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=0");
run("Bin...", "x=2 y=2 z=1 bin=Average");
//run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
doCommand("Start Animation [\\]");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=1");
//run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=2");
//run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=1");
selectWindow("fliC-_PaQa_t0h001.nd2 - C=0");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
run("Out [-]");
run("Out [-]");
run("Out [-]");
run("Out [-]");
run("Out [-]");
run("Out [-]");
run("Out [-]");
run("In [+]");
run("In [+]");
run("In [+]");
run("Out [-]");
run("Out [-]");
run("In [+]");
run("In [+]");
run("Out [-]");
doCommand("Start Animation [\\]");
*/