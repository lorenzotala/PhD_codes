timeA=getTime();
setBatchMode(true);
dir=getDirectory("Choose a Directory");
print("Welcome to the extraction of the PhaseContrast and Green fluorescence channel of nd2 files");
splitDir=dir + File.separator+"Split";
print("Images will be saved in the following folder:\n" + splitDir);
print("Extraction in progress, please wait. \n")
File.makeDirectory(splitDir);
File.makeDirectory(splitDir+File.separator+"PhaseContrast");
File.makeDirectory(splitDir+File.separator+"Fluorescence");
list = getFileList(dir);
percent=0;
progressBar="#";
n=0;
stopit=true;

while (stopit) {
	if(indexOf(list[n], "Bkg")>-1){
		run("Bio-Formats Importer", "open=["+dir+list[n]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
		selectWindow(list[n]+" - C=0");
		BkgPC=getTitle();
		idBkgPC=getImageID();
		saveAs("Tiff", splitDir+File.separator+"PhaseContrast"+File.separator+BkgPC+".tif");
		//run("Gaussian Blur...", "sigma=50");

		selectWindow(list[n]+" - C=1");
		BkgFluo=getTitle();
		idBkgFluo=getImageID();
		saveAs("Tiff", splitDir+File.separator+"Fluorescence"+File.separator+BkgFluo+".tif");

		if(n>0||n<list.length-1){
			start=Array.slice(list,0,n);
			end=Array.slice(list,n+1,list.length);
			list=Array.concat(start,end);
		} else if(n=0){
			list=Array.slice(list,n+1,list.length);
		} else if(n=list.length-1){
			list=Array.slice(list,0,n);
		}
		stopit=false;
	} n=n+1;
}
for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".nd2")){
               print("\\Update:"+percent+"% "+progressBar);
	
	run("Bio-Formats Importer", "open=["+dir+list[i]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
	
	selectWindow(list[i]+" - C=0");
	imgName=getTitle();
	idPC=getImageID();
	/*imageCalculator("Subtract create 32-bit", idPC, idBkgPC);
	idPC_corr=getImageID();*/
	saveAs("Tiff", splitDir+File.separator+"PhaseContrast"+File.separator+imgName+".tif");

	selectWindow(list[i]+" - C=1");
	imgName=getTitle();
	idFluo=getImageID();
	imageCalculator("Subtract create 32-bit", idFluo, idBkgFluo);
	idFluo_corr=getImageID();
	saveAs("Tiff", splitDir+File.separator+"Fluorescence"+File.separator+imgName+".tif");
	selectImage(idPC);
	close();
	//selectImage(idPC_corr);
	//close();
	selectImage(idFluo);
	close();
	selectImage(idFluo_corr);
	close();
     }
     percent=floor((i+1)/list.length*100);
     progressBar=progressBar+"#";
}
print("\\Update:"+percent+"%"+progressBar);
selectImage(idBkgPC);
close();
selectImage(idBkgFluo);
close();
setBatchMode(false);
timeB=getTime();
ExecTime=(timeB-timeA)/1000;
print("done in "+ExecTime+" s");