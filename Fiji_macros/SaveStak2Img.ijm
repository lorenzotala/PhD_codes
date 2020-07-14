Dir=getDirectory("image");
Titre=getTitle();
IND=indexOf(Titre, '.tif');
NoExtension=substring(Titre, 0, IND);
SaveDir=Dir+File.separator+NoExtension;
File.makeDirectory(SaveDir);
setBatchMode(true);
run("Stack to Images");

n=nImages;
for (i = 0; i < n; i++) {
	selectImage(nImages);
	Title=getTitle();
	saveAs("Tiff", SaveDir+File.separator+NoExtension+"_"+nImages);
	close();
}
setBatchMode(false)


