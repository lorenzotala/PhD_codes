// @File(label="Select the folder of images to process", style="directory") dir
// @Integer(label="iSCAT ROI", value=1024) iSCAT_ROI
// @Integer(label="TIRF ROI", value=768) TIRF_ROI
// @Boolean(label="Bin?", value=false) doBinning
// @Integer(label="TIRF Bin", value=4) TIRFBinning
// @Integer(label="iSCAT Bin", value=2) xBin
// @Integer(label="iSCAT z or t Bin", value=1) zBin
// @Boolean(label="Burst?", value=false) doBurst
// @Boolean(label="Open Processed images?", value=true) iSCATproc
// @Boolean(label="Open Filtered images?", value=false) FFilter
// @Boolean(label="   Bandpass Filtering?", value=true) doBPfilter
// @Integer(label="   Filter large structures", value=13) FL
// @Integer(label="   Filter Small structures", value=1) FS
// @Integer(label="   Tolerance of direction", value=10) Tol
// @Boolean(label="   Gaussian blurr?", value=false) Blurr
// @Double(label="    Sigma", value=2) Sigma
// @Boolean(label="   Close?", value=false) CloseMe
// @Boolean(label="Save the filtered version?", value=false) SaveMe
// @Boolean(label="Open TIRF images?", value=false) TIRF
// @Boolean(label="Open TIRF images for first time?", value=false) TIRF_first
TimeA=getTime;
yBin=xBin;
RegFactor=1.382075;
RAWeq=iSCAT_ROI/RegFactor;
FloorEQ=floor(RAWeq);
ModTIRF=modulo(FloorEQ,2);
if(ModTIRF==0){
	if(FloorEQ<RAWeq) FloorEQ=FloorEQ+2;
}
else {FloorEQ=FloorEQ+1;}
Binned=FloorEQ/TIRFBinning;
RectSize=floor(Binned)+1;
Offset=(TIRF_ROI/TIRFBinning-RectSize)/2;
Scale=floor(iSCAT_ROI/xBin);

print("Starting Batch Macro with RectSize= "+RectSize+" and Offset= "+Offset);
n=0;
if (doBurst){
	print("Burst concatenation");
	SavingDir=dir+File.separator+"Concatenated";
	File.makeDirectory(SavingDir);
	renameFiles(dir,SavingDir,5,doBinning,iSCATproc,FFilter,TIRF,n);
	run("Close All");
	NBEvents=listFiles(SavingDir,doBinning,xBin,yBin,zBin,iSCATproc,FFilter,doBPfilter,FL,FS,Tol,Blurr,Sigma,CloseMe,SaveMe,TIRF,n);
	print(NBEvents);
	if(iSCATproc){
		run("Concatenate...", "all_open title=[Concatenated_Events_iSCAT.tif]");
	}
	else if(TIRF){ 
		print("Tirf");
		run("Concatenate...", "all_open title=[Concatenated_Events_TIRF.tif]");
		//run("Images to Stack", "name=Concatenated_Events_TIRF.tif title=[] use");
		Title=getTitle;
		/*makeRectangle(Offset,Offset,RectSize,RectSize);
		run("Crop");
		getDimensions(a,b,c,Slices,f);
		run("Scale...", "x=- y=- z=1.0 width="+Scale+" height="+Scale+" depth="+Slices+" interpolation=Bilinear average process create");*/
		saveAs("tiff",SavingDir+File.separator+Title);
	}
	else if(!iSCATproc&&!TIRF){
		run("Concatenate...", "all_open title=[Concatenated_Events_RawSCAT.tif]");
		run("Bin...", "x="+xBin+" y="+yBin+" z=1 bin=Average");
		Title=getTitle;
		TitleID=getImageID;
		saveAs("tiff",SavingDir+File.separator+Title);
		run("Z Project...", "projection=Median");
		Med=getTitle;
		MedID=getImageID;
		imageCalculator("Divide create 32-bit stack", TitleID,MedID);
		Results=getImageID;
		selectImage(TitleID);
		close();
		selectImage(MedID);
		close();
		selectImage(Results);
		RawIndex=indexOf(Title,"Raw");
		StartString=substring(Title,0,RawIndex);
		EndString=substring(Title,RawIndex+3);
		rename(StartString+"Processed"+EndString);
		ResultsTitle=getTitle;
		run("Subtract...", "value=1 stack");
		getDimensions(a,b,c,Slices,f);
		run("Enhance Contrast", "saturated=0.35");
		BitDepth=bitDepth();
		if (BitDepth!=32) run("32-bit");
		
		getDimensions(a,b,c,Slices,f);
		
		run("Set Measurements...", "area mean standard min median stack display redirect=None decimal=3");
		FL=13;
		FS=1;
		
		rename("FL"+FL+"_FS"+FS+"_"+ResultsTitle);
		Filter=getTitle;
		FilterID=getImageID;
		selectImage(FilterID);
		run("Bandpass Filter...", "filter_large="+FL+" filter_small="+FS+" suppress=None tolerance="+Tol+" autoscale saturate process");
							
		for (i=1;i<Slices+1;i++){
				setSlice(i);
				getStatistics(area, mean);
				run("Subtract...", "value="+mean);
			}
			
		setMinAndMax(-0.0030, 0.0020);
		run("Gaussian Blur...", "sigma=1 stack");
		//run("Scale...", "x=- y=- z=1.0 width="+RectSize+" height="+RectSize+" depth="+Slices+" interpolation=Bilinear average process create");
		saveAs("tiff",SavingDir+File.separator+Filter);
	}
	
	if(iSCATproc)saveAs("tiff",SavingDir+File.separator+"Concatenated_Events_iSCAT.tif");
	else if(TIRF)saveAs("tiff",SavingDir+File.separator+"Concatenated_Events_TIRF.tif");
}
else{
	listFiles(dir,doBinning,xBin,yBin,zBin,iSCATproc,FFilter,doBPfilter,FL,FS,Tol,Blurr,Sigma,CloseMe,SaveMe,TIRF,n);
	if(!CloseMe) run("Tile");
}
TimeB=getTime;
ElapsedTime=(TimeB-TimeA)/1000;
print("Elapsed Time: "+ElapsedTime+" s");
beep();

//----------------------------------Functions----------------------------------------------------

/* modulo(IntVal, Integer) is a function that returns 0 if the IntVal can be devided by the Integer, or the
 * reminder of the division.
 */
function modulo(IntVal, Integer){
	Mod=IntVal-(floor(IntVal/Integer)*Integer);
	return Mod;
}

/* isImage(filename) is a function that checks if the input file is an image of type "lsm", "lei",
 * "lif", "tif", "ics", "bmp", "png", "TIF", "tiff", "czi", "zvi", "nd2"
 */
function isImage(filename){
	// list of accepted file format
	extensions= newArray("ids", "lsm", "lei", "lif", "ics", "tif", "bmp", "png", "TIF", "tiff", "czi", "zvi", "nd2"); 
	for (i=0; i<extensions.length; i++) { // loop over each index of the array extensions
		if(endsWith(filename, "."+extensions[i])) { // check if the imageName given endswith the ith element 
			return true; // if its true, it's an image, so we don't need to continue so return
		} 
	} 
	return false; // when every element have been check, it's not an image.
}

/* isTextImage(filename) is a function that checks if the input file is an image of type "txt"
 */
function isTextImage(filename){
	// list of accepted file format
	extensions= newArray("txt"); 
	for (i=0; i<extensions.length; i++) { // loop over each index of the array extensions
		if(endsWith(filename, "."+extensions[i])) { // check if the imageName given endswith the ith element 
			return true; // if its true, it's an image, so we don't need to continue so return
		} 
	} 
	return false; // when every element have been check, it's not an image.
}

/* addDigits(Title,TotDigits,Char) is a function that rename the events with a defined number of digits
 *  For example, if the file to open is callet event1.tif, and the number of digits is 5, the function will
 *  rename it event00001.tif
 */
function addDigits(ID,TotDigits,Char){
	selectImage(ID);
	Title=getTitle;
	EventIndex=indexOf(Title,"event");
	Event=substring(Title,0,EventIndex+5);
	End=substring(Title,EventIndex+5);
	endNumber=indexOf(Title,Char);
	digits=endNumber-(EventIndex+5);
	for (i=0;i<TotDigits-digits;i++){
		Event=Event+0;
	}
	NewTitle=Event+End;
	selectImage(ID);
	rename(NewTitle);
}

//listFiles(dir) is a function that allows to list all the TDMS files converted to TIFF
function listFiles(dir,doBinning,xSize,ySize,zSize,iSCATproc,FFilter,doBPfilter,FL,FS,Tol,Blurr,Sigma,CloseMe,SaveMe,TIRF,n) {
	list = getFileList(dir);
	//Array.print(list);
	NbEvents=0;
	for (i=0; i<list.length; i++) {
		if (endsWith(list[i], "/")){
			print("listFiles Recursive loop "+n);
			
			NewDir=dir+File.separator+list[i];
			print("Working directory: "+NewDir);
			n=n+1;
			listFiles(NewDir,doBinning,xSize,ySize,zSize,iSCATproc,FFilter,doBPfilter,FL,FS,Tol,Blurr,Sigma,CloseMe,SaveMe,TIRF,n); 
			
		}
		else{
			if (isImage(list[i])){
				if(iSCATproc){
					indSCAT=indexOf(list[i], "T_Stack_processed.tif");
					indFFilter=indexOf(list[i], "_FS");
					if((indSCAT>0)&&!(indFFilter>0)){
						print("iSCAT file "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle();
						ID=getImageID;
						if(doBinning){
							selectImage(ID);
							run("Bin...", "x="+xSize+" y="+ySize+" z="+zSize+" bin=Average");
						}
						if(doBPfilter){
							selectImage(ID);
							BitDepth=bitDepth();
							Path=getDirectory("image");
							
							if (BitDepth!=32) run("32-bit");
							
							getDimensions(a,b,c,Slices,f);
							
							run("Set Measurements...", "area mean standard min median stack display redirect=None decimal=3");
							
							
							rename("FL"+FL+"_FS"+FS+"_"+Title);
							Filter=getTitle;
							FilterID=getImageID;
							selectImage(FilterID);
							run("Bandpass Filter...", "filter_large="+FL+" filter_small="+FS+" suppress=None tolerance="+Tol+" autoscale saturate process");
												
							for (i=1;i<Slices+1;i++){
									setSlice(i);
									getStatistics(area, mean);
									run("Subtract...", "value="+mean);
								}
								
							setMinAndMax(-0.0030, 0.0020);
							
							if (SaveMe) saveAs("Tiff", Path+File.separator+Filter);
							if (Blurr) run("Gaussian Blur...", "sigma="+Sigma+" stack");						
						}
					}
					if(CloseMe) run("Close All");
				}
				else if (TIRF){
					indTIRF=indexOf(list[i], "_tirf");
					if(indTIRF>0){
						print("TIRF file: "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle();
						ID=getImageID;
						if(doBinning){
							selectImage(ID);
							run("Bin...", "x="+xSize+" y="+ySize+" z="+zSize+" bin=Average");
						}
					}
				}
				else if (FFilter){
					indFFilter=indexOf(list[i], "_FS");
					if(indFFilter>0){
						print("Filtering: "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle();
						ID=getImageID;
						if(doBinning){
							selectImage(ID);
							run("Bin...", "x="+xSize+" y="+ySize+" z="+zSize+" bin=Average");
						}
						if (Blurr) run("Gaussian Blur...", "sigma="+Sigma+" stack");
						if (SaveMe) saveAs("Tiff", Path+File.separator+Filter);
					}
				}
				else{//Raw iSCAT stack
					indALL=indexOf(list[i], "PreNbin");
					if(indALL>0){
						print("Raw iSCAT files: "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle();
						ID=getImageID;
						if(doBinning){
							selectImage(ID);
							run("Bin...", "x="+xSize+" y="+ySize+" z="+zSize+" bin=Average");
						}
						NbEvents=NbEvents+1;
					}
				}
				
			}
			else if (TIRF_first && isTextImage(list[i])){
				if (TIRF){
					IndMF=indexOf(list[i], "MF");
					if (IndMF<0){
						run("Text Image... ", "open=["+dir+File.separator+list[i]+"]");
						IDText=getImageID;
						rename(list[i]);
						Title=getTitle();
						Ind=indexOf(Title, ".");
						NewTitle=substring(Title, 0, Ind);
						selectImage(IDText);
						run("Bin...", "x=1 y=1 bin=Average");
						run("Subtract Background...", "rolling=25 sliding");
						saveAs("tiff", dir+File.separator+NewTitle+"_C=1");
						selectImage(IDText);
						run("Duplicate...", " ");
						IDMask=getImageID();
						setAutoThreshold("Moments dark");
						setOption("BlackBackground", false);
						run("Convert to Mask");
						run("Median...", "radius=2");
						saveAs("tiff", dir+File.separator+NewTitle+"_C=0");
					}
				}
			}
			
			else print(list[i]+" is not a valid image");
		}		
			
	} 
	n=0;
	return NbEvents;
} 

//renameFiles(dir) is a function that allows to list all the TDMS files converted to TIFF
function renameFiles(dir,SaveDir,NDigits,doBinning,iSCATproc,FFilter,TIRF,n) {
	print("Function renameFiles started");
	list = getFileList(dir);
	//Array.print(list);
	
	for (i=0; i<list.length; i++) {
		if (endsWith(list[i], "/")&&!endsWith(list[i], "Concatenated/")){
			print("renameFiles Recursive loop "+n);
			
			NewDir=dir+File.separator+list[i];
			print("Working directory: "+NewDir);
			n=n+1;
			renameFiles(NewDir,SaveDir,NDigits,doBinning,iSCATproc,FFilter,TIRF,n); 
			
		}
		else{
			if (isImage(list[i])){
				if(iSCATproc){
					indSCAT=indexOf(list[i], "T_Stack_processed.tif");
					indFFilter=indexOf(list[i], "_FS");
					if((indSCAT>0)&&!(indFFilter>0)){
						print("Processed iSCAT file: "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle();
						ID=getImageID;
						Char="_N";
						addDigits(ID,NDigits,Char);
						Title=getTitle;
						IDigits=getImageID;
						//run("Z Project...", "stop=5 projection=[Average Intensity]");
						//selectImage(nImages);
						saveAs("tiff",SaveDir+File.separator+Title);
						run("Close All");
						
					}
				}
				else if (TIRF){
					indTIRF=indexOf(list[i], "_tirf_RAW");
					if(indTIRF>0){
						print("Raw TIRF file: "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle();
						ID=getImageID;
						Char="_tirf";
						addDigits(ID,NDigits,Char);
						Title=getTitle;
						IDigits=getImageID;
						//run("Z Project...", "projection=[Sum Slices]");
						selectImage(nImages);
						saveAs("tiff",SaveDir+File.separator+Title);
						run("Close All");
						
					}
				}
				else {
					indALL=indexOf(list[i], "PreNbin");
					if(indALL>0){
						print("Raw iSCAT files: "+list[i]);
						open(dir+File.separator+list[i]);
						rename(list[i]);
						Title=getTitle;
						ID=getImageID;
						addDigits(ID,NDigits,"_PreNbin");
						Title=getTitle;
						saveAs("tiff",SaveDir+File.separator+Title);	
						
					}
				}
			}
			else print(list[i]+" is not a valid image");
		}		
			
	} 
	n=0;
	print("Function renamFiles ended");
} 
