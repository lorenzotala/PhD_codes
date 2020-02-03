// @File(label="DataSet save directory", style="directory") SaveDir
// @Boolean(Label="Reset registration parameters", value=false) NewReg
// @Float(Label="Scaling factor", value=1.38202) scaling
// @Integer(Label="Pole radius", value=10) radius
// @Integer(Label="BiologicalReplicate", value=1) BioRep
// @Integer(Label="Cell min area", value=450) MinCellArea
// @Boolean(Label="Specific fluorescent frame", value=false) JustFrame
// @Integer(Label="Fluorescent frame", value=1) FrameNb

print("\\Clear")

file_path=SaveDir+File.separator+"CurrentDataPoint.txt";
if (File.exists(file_path)){
	raw_data=File.openAsString(file_path);
	split_raw_data=split(raw_data, ",");
	l=lengthOf(split_raw_data);
	Coordinates=newArray(l);
	for(i=0; i<l; i++){
		Coordinates[i]=parseInt(split_raw_data[i]);
	}
} else Coordinates=newArray(287, 248, 125, 71, 279, 239, 116, 58);

run("Set Measurements...", "area mean min centroid redirect=None decimal=5");
if(isOpen("Results")){
		selectWindow("Results");
		run("Close");
 	}
roiManager("Reset");
titles = newArray(nImages());
for (i=1; i<=nImages(); i++) {
	selectImage(i);
	titles[i-1] = getTitle();
	if (indexOf(titles[i-1],"iSCAT")>0){
		IDiSCAT=getImageID;
	} else if (indexOf(titles[i-1],"tirf")>0){
		IDtirf=getImageID;
	}
}
selectImage(IDiSCAT);
run("Gaussian Blur...", "sigma=2 stack");
makeLine(Coordinates[0], Coordinates[1], Coordinates[2], Coordinates[3]);

selectImage(IDtirf);
makeLine(Coordinates[4], Coordinates[5], Coordinates[6], Coordinates[7]);

if (NewReg){
	waitForUser( "Pause","Draw a line in iSCAT and Fluorescence images \ncorresponding to shared landmarks");
}

selectImage(IDiSCAT);
getLine(iPointX1, iPointY1, iPointX2, iPointY2, lineWidth);

selectImage(IDtirf);
getLine(fPointX1, fPointY1, fPointX2, fPointY2, lineWidth);

run("Select All");
getDimensions(width, height, channel, slice, frame);
Title=getTitle();
dir=getInfo("image.directory");
if(JustFrame){
	setSlice(FrameNb);
	run("Duplicate...", "title=CopyTirf use");
} else run("Duplicate...", "title=CopyTirf duplicate");
IDCopy=getImageID;
run("Median...", "radius=2 stack");
run("Subtract Background...", "rolling=50 sliding stack");
if(!JustFrame){
	run("Z Project...", "projection=[Average Intensity]");
} else run("Duplicate...", "title=CopyTirf use");
IDAverage=getImageID;

//scaling=sqrt(((fPointX1-fPointX2)^2+(fPointY1-fPointY2)^2)/((iPointX1-iPointX2)^2+(iPointY1-iPointY2)^2));
angle=atan2((fPointX1-fPointX2), (fPointY1-fPointY2))-atan2((iPointX1-iPointX2), (iPointY1-iPointY2));
angleDeg=angle*180/PI;
NewWidth=round(width*scaling);
NewHeight=round(height*scaling);
run("Scale...", "x="+scaling+" y="+scaling+" width="+NewWidth+" height="+NewWidth+" interpolation=Bilinear average create title=["+"Registered_AVG_"+Title+"]");
IDReg=getImageID;
TitleTIRF=getTitle;
run("Rotate... ", "angle="+angleDeg+" grid=1 interpolation=Bilinear");
makeRectangle(266-256,266-256,512,512);
run("Crop");
saveAs("tif", dir+TitleTIRF);
selectImage(IDAverage);
close();
selectImage(IDCopy);
close();
run("Tile");
selectImage(IDReg);
run("In [+]");


selectImage(IDiSCAT);
run("In [+]");


Pole=newArray(2);
Pole[0]="Dim";
Pole[1]="Bright";
PiliCount = newArray(2);
FlagellaCount = newArray(2);
area = newArray(2);
mean = newArray(2);
min = newArray(2);
max = newArray(2);
std = newArray(2);
TotalFluPole = newArray(2);

Condition=true;
CellNb=1;
while (Condition==true){
	//n=getNResultsFromTabel("SummaryResults");
	n=nResults;
	roiManager("Show All with labels");
	waitForUser( "Pause","Draw line along the cell starting from the dim to the bright pole");
	getSelectionCoordinates( xPoles, yPoles );
	getSelectionBounds(x, y, SizeSquareX, SizeSquareY);
	//print(x+" "+y);

	selectImage(IDReg);
	correction=2*radius;
	makeRectangle(x-correction, y-correction, SizeSquareX+2*correction, SizeSquareY+2*correction);
	run("Duplicate...", "title=cell"+CellNb+" duplicate");
	CellID=getImageID;
	run("Duplicate...", "title=Mask"+CellNb+" duplicate");
	MaskID=getImageID;
	selectImage(MaskID);
	//run("Find Edges");
	/*setAutoThreshold("Default dark");
	setOption("BlackBackground", false);
	run("Convert to Mask");*/
	setAutoThreshold("Otsu dark"); //Li dark
	setOption("BlackBackground", false);
	run("Convert to Mask");
	//run("Skeletonize");
	//run("Fill Holes");
	run("Median...", "radius=2");
	//run("Dilate");
	run("Analyze Particles...", "size="+MinCellArea+"-Infinity show=[Bare Outlines]");
	ID_Particle=getImageID();
	run("Fill Holes");
	run("Create Selection");
	getSelectionCoordinates( xCell, yCell);
	//print(xCell[0]);
	selectImage(CellID);
	run("Restore Selection");
	getStatistics(Cellarea, Cellmean, Cellmin, Cellmax, Cellstd, histogram);
	TotalFlu=Cellmean*Cellarea;
	setResult("Label", n, Title);
	setResult("BiologicalReplicate", n, BioRep);
	setResult("CellArea", n, Cellarea);
	setResult("CellMean", n, Cellmean);
	setResult("CellTotalFluorescence", n, TotalFlu);
	setResult("CellMin", n, Cellmin);
	setResult("CellMax", n, Cellmax);
	setResult("CellStd", n, Cellstd);
	selectImage(MaskID);
	close();
	selectImage(CellID);
	close();
	selectImage(ID_Particle);
	close();
	
	new_x=correctSelection(xCell, x-correction);
	new_y=correctSelection(yCell, y-correction);
	selectImage(IDReg);
	makeSelection( "polyline", new_x, new_y );
	roiManager("Add");
	LastROI=roiManager("count");
	Poles_Coordinates=getPolesCoordinates(new_x, new_y , width);
	pole_rad=Poles_Coordinates[4];
	for(i=0; i<2; i++){
		if(i==0){
			r=0;
		} else if (i==1){
			r=2;
		}
		selectImage(IDReg);
		makeOval(Poles_Coordinates[5+r]-round(pole_rad/2),Poles_Coordinates[5+r+1]-round(pole_rad/2),pole_rad,pole_rad);
		getStatistics(area[i], mean[i], min[i], max[i], std[i], histogram);
		TotalFluPole[i]=mean[i]*area[i];
		print("Pole i="+i+" has "+TotalFluPole[i]);
	}
	if(TotalFluPole[0]<TotalFluPole[1]){
		Pole_order=true;
	} else Pole_order=false;
	//print("Keep pole order: "+Pole_order);
	for(i=0; i<2; i++){
		if (Pole_order==true) {
			p=i;
			if(i==0){
			r=0;
		} else if (i==1){
			r=2;
		}
		} else {
			if (i==0){
				p=1;
				r=2;
			} else if (i==1){
				p=0;
				r=0;
			}
		}
		//print("r is "+r);
		selectImage(IDiSCAT);
		roiManager("Show All with labels");
		roiManager("Select", LastROI-1);
		makeOval(Poles_Coordinates[5+r]-round(pole_rad/2),Poles_Coordinates[5+r+1]-round(pole_rad/2),pole_rad,pole_rad);
		waitForUser( "Pause","Count pili and flagella at the "+Pole[i]+" pole");
		Dialog.create("Pole at ("+Poles_Coordinates[5+p]+", "+Poles_Coordinates[5+p+1]+")");
			Dialog.addNumber("Number of pili at the pole", 0);
			Dialog.addNumber("Number of flagella at the pole", 0);
			if(i==1) Dialog.addCheckbox("add another cell?", true);
		Dialog.show();
		PiliCount[i]=Dialog.getNumber();
		FlagellaCount[i]=Dialog.getNumber();
		if(i==1) Condition=Dialog.getCheckbox();
	
		/*writeResult("SummaryResults", "Label", n, Title);
		writeResult("SummaryResults", "X_Pole"+Pole[i], n, xPoles[CoordIndex[i]]);
		writeResult("SummaryResults", "Y_Pole"+Pole[i], n, yPoles[CoordIndex[i]]);
		writeResult("SummaryResults", "AreaPole"+Pole[i], n, area[i]);
		writeResult("SummaryResults", "MeanPole"+Pole[i], n, mean[i]);
		writeResult("SummaryResults", "MinPole"+Pole[i], n, min[i]);
		writeResult("SummaryResults", "MaxPole"+Pole[i], n, max[i]);
		writeResult("SummaryResults", "StdPole"+Pole[i], n, std[i]);*/
		setResult("X_Pole"+Pole[p], n, Poles_Coordinates[5+p]);
		setResult("Y_Pole"+Pole[p], n, Poles_Coordinates[5+p+1]);
		setResult("AreaPole"+Pole[p], n, area[p]);
		setResult("MeanPole"+Pole[p], n, mean[p]);
		setResult("TotalFluorescencePole"+Pole[p], n, TotalFluPole[p]);
		setResult("MinPole"+Pole[p], n, min[p]);
		setResult("MaxPole"+Pole[p], n, max[p]);
		setResult("StdPole"+Pole[p], n, std[p]);
		setResult("Nb_Pili_Pole"+Pole[p], n, PiliCount[p]);
		setResult("Nb_Flagella_Pole"+Pole[p], n, FlagellaCount[p]);
	}
	cellFlu=TotalFlu-(TotalFluPole[0]+TotalFluPole[1]);
	ratio1=(TotalFluPole[0]+TotalFluPole[1])/cellFlu;
	ratio2=(area[0]+area[1])/(Cellarea-(area[0]+area[1]));
	PolarRatio=ratio1/ratio2;
	setResult("PolarRatio", n, PolarRatio);
}

selectImage(IDReg);
run("Save");
close();

Ind=indexOf(Title, "_tirf");
NewTitle=substring(Title, 0, Ind);
saveAs("Results", dir+NewTitle+".csv");

selectImage(IDiSCAT);
close();
selectImage(IDtirf);
close();

file=File.open(file_path);
print(file, iPointX1+","+iPointY1+","+iPointX2+","+iPointY2+","+fPointX1+","+fPointY1+","+fPointX2+","+fPointY2);

//----------------------------------------------------Functions--------------------------------------------------

/*  readResult(NameOfTable, Column, Row) return the value on the column and row of the Result
 *  table of NameOfTable. If NameOfTable exists it reads the value, if it doesn't exists it 
 *  prints a warning message If the column doesn't exist the function retruns "null".
 * 
 */
 function readResult(NameOfTable, Column, Row){
	if(isOpen(NameOfTable)){
		IJ.renameResults(NameOfTable,"Results");
		Value=getResult(Column, Row);
		if(isNaN(Value)) Value=getResultString(Column, Row);
		IJ.renameResults("Results",NameOfTable);
		return Value;
	}
	else {
		print(NameOfTable+" does not exist");
		return NaN;
	}
	
}

/*  writeResult(NameOfTable, Column, Row, Value) write the value on the column and row of the Result
 *  table of NameOfTable. If NameOfTable exists it calls it and make the desired change, if it
 *  doesn't exists it ceates it.
 * 
 */
function writeResult(NameOfTable, Column, Row, Value){
	if(isOpen(NameOfTable)){
		IJ.renameResults(NameOfTable,"Results");
		setResult(Column, Row, Value);
		IJ.renameResults("Results",NameOfTable);
	}
	else {
		if(isOpen("Results")) IJ.renameResults("Results","Tmp");
		setResult(Column, Row, Value);
		IJ.renameResults("Results",NameOfTable);
		if(isOpen("Tmp")) IJ.renameResults("Tmp","Results");
	}
}

/*  getNResultsFromTabel(NameOfTable) write the value on the column and row of the Result
 *  table of NameOfTable. If NameOfTable exists it calls it and make the desired change, if it
 *  doesn't exists it ceates it.
 * 
 */
 function getNResultsFromTabel(NameOfTable){
 	if(isOpen(NameOfTable)){
		IJ.renameResults(NameOfTable,"Results");
		n=nResults;
		IJ.renameResults("Results",NameOfTable);
 	} else n=0;
 	return n;
 }

/*  correctSelection(x_selection, y_selection, x_offset, y_offset) Correct the selection coordinates
 *  by translating the input coordinates by the offset in x and y.
 * 
 */
 function correctSelection(x_selection, x_offset){
 	x=newArray(x_selection.length);
 	for(i=0; i<x_selection.length; i++){
 		x[i]=x_selection[i]+x_offset;
 	}
 	return x;
 }

/* getPolesCoordinates(array_x, array_y, image_size) takes X and Y coordinates and the image size as input
 * and returns the coordinates of the two poles of a rodshaped bacterium, its center of mass, the width of
 * the bacterium and the index of the selection where the poles are defined.
 */
function getPolesCoordinates(array_x, array_y, image_size){
	//Getting the min and max value of the X and Y coordinates in order to find the initial center of mass.
	Array.getStatistics(array_x, minX, maxX, mean, stdDev);
	Array.getStatistics(array_y, minY, maxY, mean, stdDev);
	xCM=minX+(maxX-minX)/2;
	yCM=minY+(maxY-minY)/2;

	//Initializing output Array
	out=newArray(5);

	//Initializing working variables
	posLmax=-image_size;
	negLmax=-image_size;
	posLmin=image_size;
	negLmin=image_size;
	L=newArray(array_x.length);
	L0=newArray(array_x.length);
	L1=newArray(array_x.length);
	indexPole0=0;
	indexPole1=0;
	indexCenter0=0;
	indexCenter1=0;

	//Computing the lengths from CM to points of the selection in order to compute real CM
	for (i=0; i<array_x.length; i++){
		x0=array_x[i]-xCM;
		y0=array_y[i]-yCM;
		l=sqrt(x0*x0 + y0*y0);
		L[i]=l;
	}
	minima=Array.findMinima(L, 1);	//Returns the indexes of the minima of the lengths in increasing length order
	xCM=(array_x[minima[0]]+array_x[minima[1]])/2;
	yCM=(array_y[minima[0]]+array_y[minima[1]])/2;

	//Computing new Lengths from new CM.
	for (i=0; i<array_x.length; i++){
		x0=array_x[i]-xCM;
		y0=array_y[i]-yCM;
		l=sqrt(x0*x0 + y0*y0);
		L[i]=l;
	}

	//Getting index of Length maxima. These correspond to the two poles.
	//Initialization of variables
	n_maxima=Array.findMaxima(L, 1);
	raw_maxima=Array.sort(n_maxima); //From smallest to largest Index value
	maxLengths=newArray(raw_maxima.length);
	maxima=newArray(raw_maxima.length-1);

	//If There are more than 2 maxima, Get the corresponding lengths 
	if(raw_maxima.length>2){	
		for (i=0; i<raw_maxima.length; i++){
			maxLengths[i]=L[raw_maxima[i]];
		}
		//Get the index of the smallest length within the maxima
		Array.getStatistics(maxLengths, smallestL, m, me, std);
		ind_smallest_L=NaN;
		for (i=0; i<raw_maxima.length; i++){
			if(maxLengths[i]==smallestL){
				ind_smallest_L=i;
			}
		}
		//Checking the location of the smallest maxima (if more than 2 are found) in order to discard it
		//and take the bigger of the remaining ones
		if(ind_smallest_L==1){
			if(maxLengths[ind_smallest_L-1]<maxLengths[ind_smallest_L+1]){
				ind_smallest_L=ind_smallest_L+1;
			} else if (maxLengths[ind_smallest_L-1]>maxLengths[ind_smallest_L+1]){
				ind_smallest_L=ind_smallest_L-1;
			} else {
				ind_smallest_L=ind_smallest_L-1;
			}
		}
		
		n=0;
		for(i=0; i<raw_maxima.length;i++){
			if(i!=ind_smallest_L){
				maxima[n]=raw_maxima[i];
				n++;
			}
		}
	} else{
		maxima=raw_maxima;
	}

	//Generating coordinates of two spots in between the poles and the CM to extract the mean width of the bacterium
	x_0=(array_x[maxima[0]]+xCM)/2;
	y_0=(array_y[maxima[0]]+yCM)/2;
	x_1=(array_x[maxima[1]]+xCM)/2;
	y_1=(array_y[maxima[1]]+yCM)/2;

	//First pole
	for (i=0; i<array_x.length; i++){
		x0=array_x[i]-x_0;
		y0=array_y[i]-y_0;
		l=sqrt(x0*x0 + y0*y0);
		L0[i]=l;
	}
	minima0=Array.findMinima(L0, 1);
	x=(array_x[minima0[0]]-array_x[minima0[1]]);
	y=(array_y[minima0[0]]-array_y[minima0[1]]);
	r0=sqrt(x*x+y*y);

	//Second pole
	for (i=0; i<array_x.length; i++){
		x0=array_x[i]-x_1;
		y0=array_y[i]-y_1;
		l=sqrt(x0*x0 + y0*y0);
		L1[i]=l;
	}
	minima1=Array.findMinima(L1, 1);
	x=(array_x[minima1[0]]-array_x[minima1[1]]);
	y=(array_y[minima1[0]]-array_y[minima1[1]]);
	r1=sqrt(x*x+y*y);

	//Mean width
	r=(r0+r1)/2;
	//print("("+r0+"+"+r1+")/2="+r);
	
	out[0]=xCM;
	out[1]=yCM;
	out[2]=maxima[0];
	out[3]=maxima[1];
	out[4]=r;

	//Adding coordinates of poles
	out2=correctPolesCoordinates(out, array_x, array_y);
	final_out=Array.concat(out,out2);
	return final_out;
}

/* correctPolesCoordinates(Coordinates, array_x, array_y) takes an Array containing CM coordinates,
 * Index of the two poles and mean cell width and returns the corrected coordinates of the poles
 */
function correctPolesCoordinates(Coordinates, array_x, array_y){
	out=newArray(4);
	x0=array_x[Coordinates[2]];
	y0=array_y[Coordinates[2]];
	x1=array_x[Coordinates[3]];
	y1=array_y[Coordinates[3]];
	xCM=Coordinates[0];
	yCM=Coordinates[1];
	r=Coordinates[4]/2;
	
	norm0=sqrt((xCM-x0)*(xCM-x0)+(yCM-y0)*(yCM-y0));
	norm1=sqrt((xCM-x1)*(xCM-x1)+(yCM-y1)*(yCM-y1));
	
	corx0=r*(xCM-x0)/norm0;
	cory0=r*(yCM-y0)/norm0;
	corx1=r*(xCM-x1)/norm1;
	cory1=r*(yCM-y1)/norm1;
	
	out[0]=x0+corx0;
	out[1]=y0+cory0;
	out[2]=x1+corx1;
	out[3]=y1+cory1;
	
	return out;
}