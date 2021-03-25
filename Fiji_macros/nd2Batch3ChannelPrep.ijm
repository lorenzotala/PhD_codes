// @File(label="Select the folder of images to process", style="directory") dir
// @String(label="1st channel name", value="PhaseContrast") channel1
// @String(label="2nd channel name", value="PaQa") channel2
// @String(label="3rd channel name", value="RFP") channel3

/* This macro allows to split all nd2 files (containing 3 channels only) included in the user defined directory.
 * A background subtraction is done on 3 channels separately and save individual images into separate folders
 * named by the user.
 */

// Get start time to compute the macro duration
timeA=getTime();

// Do not display images to gain some computation speed
setBatchMode(true);

// Get directory content
dirList=getFileList(dir);
d=0;
stopDir=true;
while (stopDir) { // Count how many subfolders there are in the user defined directory so to go through each of them
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

//Setting up the progress bar
progressBar_length = 50;
empty_character = "  ";


if (dirList.length==0) { // Do if all images are located in the user defined directory
	print("Number of directories found = "+dirList.length);
	print("Entering single folder extraction of the "+channel1+", "+channel2+" and "+channel3+" fluorescence channels of nd2 files");

	Dir=dir;
	splitDir=Dir + File.separator+"Split";
	print("Images will be saved in the following folder:\n" + splitDir);
	print("Extraction in progress, please wait. \n");
	File.makeDirectory(splitDir);
	File.makeDirectory(splitDir+File.separator+channel1);
	File.makeDirectory(splitDir+File.separator+channel2);
	File.makeDirectory(splitDir+File.separator+channel3);
	list = getFileList(Dir);
	percent=0;
	
	n=0;
	totImages=0;
	stopit=true;
	AVGBkg=0;
	AVGFrames=newArray(0);
	while (stopit) {
		if((endsWith(list[n], ".nd2"))){
			totImages=totImages+1;
		} n=n+1;
		if(n>lengthOf(list)-1) stopit=false;
	}
	print("tot images = " + totImages+"\n");
	progress_steps=floor(progressBar_length/totImages);
	progressBar=genStr(empty_character, progressBar_length);
	for (i=0; i<list.length; i++) {
	     if (endsWith(list[i], ".nd2")){
	     	print("\\Update:"+"Progress:"+progressBar+" : "+percent+"%");		
			run("Bio-Formats Importer", "open=["+Dir+File.separator+list[i]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
			
			selectWindow(list[i]+" - C=0");
			imgName=getTitle();
			idPC=getImageID();
			//run("Bin...", "x=2 y=2 z=1 bin=Average");
			saveAs("Tiff", splitDir+File.separator+channel1+File.separator+imgName+".tif");
		
			selectWindow(list[i]+" - C=2");
			imgName=getTitle();
			idRFP=getImageID();
			run("Duplicate...", "use");
			idRFP_first=getImageID;
			run("Subtract Background...", "rolling=50 sliding");
			//run("Bin...", "x=2 y=2 z=1 bin=Average");
			temp=getValue("Median");
			AVGFramesRFP=Array.concat(AVGFrames,temp);
			saveAs("Tiff", splitDir+File.separator+channel2+File.separator+imgName+".tif");
		
			selectWindow(list[i]+" - C=1");
			imgName=getTitle();
			idFITC=getImageID();
			run("Duplicate...", "use");
			idFITC_first=getImageID;
			run("Subtract Background...", "rolling=50 sliding");
			//run("Bin...", "x=2 y=2 z=1 bin=Average");
			temp=getValue("Median");
			AVGFramesFITC=Array.concat(AVGFrames,temp);
			saveAs("Tiff", splitDir+File.separator+channel3+File.separator+imgName+".tif");
			
			run("Close All");
	    }
	     percent=floor((i+1)/list.length*100);
	     progress=genStr("#", (i+1)*progress_steps);
	     empty_spaces=genStr(empty_character, progressBar_length-(i+1)*progress_steps);
	     progressBar=progress+empty_spaces;
	}
	print("\\Update:"+"Progress:"+progressBar+" : "+percent+"%");
	run("Close All");
} else{ // Do if you want to process all subfolder. As for example if you want to process different strains made in one day.
	print("Number of directories found = "+dirList.length);
	print("Entering batch extraction mode of the "+channel1+", "+channel2+" and "+channel3+" fluorescence channels of nd2 files");
	for (j=0; j<dirList.length; j++) {
		Dir=dir+File.separator+dirList[j];
		splitDir=Dir+"Split";
		print("Images will be saved in the following folder:\n" + splitDir);
		print("Extraction in progress, please wait. \n");
		File.makeDirectory(splitDir);
		File.makeDirectory(splitDir+File.separator+channel1);
		File.makeDirectory(splitDir+File.separator+channel2);
		File.makeDirectory(splitDir+File.separator+channel3);
		list = getFileList(Dir);
		Array.print(list);
		percent=0;
		progressBar="#";
		n=0;
		totImages=0;
		stopit=true;
		AVGBkg=0;
		AVGFrames=newArray(0);
		while (stopit) {
			if(endsWith(list[n], ".nd2")){
				totImages=totImages+1;
			} n=n+1;
			if(n>lengthOf(list)-1) stopit=false;
		}
		print("tot images = " + totImages+"\n");
		progress_steps=floor(progressBar_length/totImages);
		progressBar=genStr(empty_character, progressBar_length);
		for (i=0; i<list.length; i++) {
		     if (endsWith(list[i], ".nd2")){
		     	print("\\Update:"+"Progress:"+progressBar+" : "+percent+"%");		
				run("Bio-Formats Importer", "open=["+Dir+File.separator+list[i]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
				imgName=getTitle();
				selectWindow(list[i]+" - C=0");
				imgName=getTitle();
				idPC=getImageID();
				//run("Bin...", "x=2 y=2 z=1 bin=Average");
				saveAs("Tiff", splitDir+File.separator+channel1+File.separator+imgName+".tif");
			
				selectWindow(list[i]+" - C=1");
				imgName=getTitle();
				idRFP=getImageID();
				run("Duplicate...", "use");
				idRFP_first=getImageID;
				run("Subtract Background...", "rolling=50 sliding");
				//run("Bin...", "x=2 y=2 z=1 bin=Average");
				temp=getValue("Median");
				AVGFramesRFP=Array.concat(AVGFrames,temp);
				saveAs("Tiff", splitDir+File.separator+channel2+File.separator+imgName+".tif");
			
				selectWindow(list[i]+" - C=2");
				imgName=getTitle();
				idFITC=getImageID();
				run("Duplicate...", "use");
				idFITC_first=getImageID;
				run("Subtract Background...", "rolling=50 sliding");
				//run("Bin...", "x=2 y=2 z=1 bin=Average");
				temp=getValue("Median");
				AVGFramesFITC=Array.concat(AVGFrames,temp);
				saveAs("Tiff", splitDir+File.separator+channel3+File.separator+imgName+".tif");
				
				run("Close All");
		    }
		    percent=floor((i+1)/list.length*100);
		    progress=genStr("#", (i+1)*progress_steps);
	     	empty_spaces=genStr(empty_character, progressBar_length-(i+1)*progress_steps);
	     	progressBar=progress+empty_spaces;
		}
	print("\\Update:"+"Progress:"+progressBar+" : "+percent+"%");
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
	
print("done in "+ExecTime+" s\n");

//------------------------------------------------------------------functions-------------------------------------------------------------------

/* genStr(Char, Reps) is a function that returns 0 if the IntVal can be devided by the Integer, or the
 * reminder of the division.
 */
function genStr(Char, Reps){
	my_string = "";
	for (i = 0; i < Reps; i++) {
		my_string=my_string+Char;
	}
	return my_string;
}