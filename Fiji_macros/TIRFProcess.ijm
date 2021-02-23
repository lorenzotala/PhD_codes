Title=getTitle();
Path=getDirectory("image");
getDimensions(a,b,c,f, Slices);
/*setSlice(1);
run("Delete Slice");
run("Reduce...", "reduction=2");*/
run("Median...", "radius=1 stack");
run("Subtract Background...", "rolling=50 stack"); //50
for (i=1;i<f+1;i++){
		setSlice(i);
		
		getStatistics(area, mean);
		run("Subtract...", "value="+mean);
}

//run("Bin...", "x=1 y=1 z=2 bin=Sum");
saveAs("Tiff", Path+"\\"+"Processed_"+Title);
beep();