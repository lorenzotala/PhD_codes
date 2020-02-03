// @File(label="DataSet save directory", style="directory") SaveDir
// @Boolean(Label="Reset registration parameters", value=false) NewReg
// @Float(Label="Scaling factor", value=1.38202) scaling
// @Integer(Label="Pole radius", value=10) radius
// @Integer(Label="BiologicalReplicate", value=1) BioRep
// @Integer(Label="Cell min area", value=450) MinCellArea
// @Boolean(Label="Specific fluorescent frame", value=false) JustFrame
// @Integer(Label="Fluorescent frame", value=1) FrameNb


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
CoordIndex=newArray(2);
CoordIndex[0]=0;
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
	CoordIndex[1]=xPoles.length-1;

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
	
	for(i=0; i<2; i++){
		selectImage(IDiSCAT);
		roiManager("Show All with labels");
		roiManager("Select", LastROI-1);
		makeOval(xPoles[CoordIndex[i]]-round(radius/2),yPoles[CoordIndex[i]]-round(radius/2),radius,radius);
		waitForUser( "Pause","Count pili and flagella at the "+Pole[i]+" pole");
		Dialog.create("Pole at ("+xPoles[CoordIndex[i]]+", "+yPoles[CoordIndex[i]]+")");
			Dialog.addNumber("Number of pili at the pole", 0);
			Dialog.addNumber("Number of flagella at the pole", 0);
			if(i==1) Dialog.addCheckbox("add another cell?", true);
		Dialog.show();
		PiliCount[i]=Dialog.getNumber();
		FlagellaCount[i]=Dialog.getNumber();
		if(i==1) Condition=Dialog.getCheckbox();
		selectImage(IDReg);
		makeOval(xPoles[CoordIndex[i]]-round(radius/2),yPoles[CoordIndex[i]]-round(radius/2),radius,radius);
		getStatistics(area[i], mean[i], min[i], max[i], std[i], histogram);
		TotalFluPole[i]=mean[i]*area[i];
		
		/*writeResult("SummaryResults", "Label", n, Title);
		writeResult("SummaryResults", "X_Pole"+Pole[i], n, xPoles[CoordIndex[i]]);
		writeResult("SummaryResults", "Y_Pole"+Pole[i], n, yPoles[CoordIndex[i]]);
		writeResult("SummaryResults", "AreaPole"+Pole[i], n, area[i]);
		writeResult("SummaryResults", "MeanPole"+Pole[i], n, mean[i]);
		writeResult("SummaryResults", "MinPole"+Pole[i], n, min[i]);
		writeResult("SummaryResults", "MaxPole"+Pole[i], n, max[i]);
		writeResult("SummaryResults", "StdPole"+Pole[i], n, std[i]);*/
		setResult("X_Pole"+Pole[i], n, xPoles[CoordIndex[i]]);
		setResult("Y_Pole"+Pole[i], n, yPoles[CoordIndex[i]]);
		setResult("AreaPole"+Pole[i], n, area[i]);
		setResult("MeanPole"+Pole[i], n, mean[i]);
		setResult("TotalFluorescencePole"+Pole[i], n, TotalFluPole[i]);
		setResult("MinPole"+Pole[i], n, min[i]);
		setResult("MaxPole"+Pole[i], n, max[i]);
		setResult("StdPole"+Pole[i], n, std[i]);
		setResult("Nb_Pili_Pole"+Pole[i], n, PiliCount[i]);
		setResult("Nb_Flagella_Pole"+Pole[i], n, FlagellaCount[i]);
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
