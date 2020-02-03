getSelectionCoordinates( xCell, yCell);
image_size=512;
Coordinates=getPolesCoordinates( xCell,  yCell, image_size);
Plot.create("MyPlot", "X", "Y", Coordinates);
radius=Coordinates[4];

if(Coordinates.length<10){
	makeOval(Coordinates[0]-round(radius/2),Coordinates[1]-round(radius/2),radius,radius);
	roiManager("Add");
	makeOval(Coordinates[5]-round(radius/2), Coordinates[6]-round(radius/2),radius,radius);
	roiManager("Add");
	makeOval(Coordinates[7]-round(radius/2), Coordinates[8]-round(radius/2),radius,radius);
	roiManager("Add");
}
//---------------------------------------------Functions--------------------------------------------------

function getPolesCoordinates(array_x, array_y, image_size){
	Array.getStatistics(array_x, minX, maxX, mean, stdDev);
	Array.getStatistics(array_y, minY, maxY, mean, stdDev);
	xCM=minX+(maxX-minX)/2;
	yCM=minY+(maxY-minY)/2;
	out=newArray(5);
	posLmax=-image_size;
	negLmax=-image_size;
	posLmin=image_size;
	negLmin=image_size;
	L=newArray(array_x.length);
	indexPole0=0;
	indexPole1=0;
	indexCenter0=0;
	indexCenter1=0;
	for (i=0; i<array_x.length; i++){
		x0=array_x[i]-xCM;
		y0=array_y[i]-yCM;
		l=sqrt(x0*x0 + y0*y0);
		L[i]=l;
	}
	
	minima=Array.findMinima(L, 1);
	
	x=(array_x[minima[0]]-array_x[minima[1]]);
	y=(array_y[minima[0]]-array_y[minima[1]]);
	r=sqrt(x*x+y*y);
	
	xCM=(array_x[minima[0]]+array_x[minima[1]])/2;
	yCM=(array_y[minima[0]]+array_y[minima[1]])/2;

	for (i=0; i<array_x.length; i++){
		x0=array_x[i]-xCM;
		y0=array_y[i]-yCM;
		l=sqrt(x0*x0 + y0*y0);
		L[i]=l;
	}
	
	n_maxima=Array.findMaxima(L, 1);
	raw_maxima=Array.sort(n_maxima);
		maxima=newArray(raw_maxima.length-1);
	maxLengths=newArray(raw_maxima.length);
	if(raw_maxima.length>2){	
		for (i=0; i<raw_maxima.length; i++){
			maxLengths[i]=L[raw_maxima[i]];
		}
		
		Array.getStatistics(maxLengths, smallestL, m, me, std);
		ind_smallest_L=NaN;
		for (i=0; i<raw_maxima.length; i++){
			if(maxLengths[i]==smallestL){
				ind_smallest_L=i;
				
			}
		}
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
	
	
	out[0]=xCM;
	out[1]=yCM;
	out[2]=maxima[0];
	out[3]=maxima[1];
	out[4]=r;

	out2=correctPolesCoordinates(out, array_x, array_y);
	final_out=Array.concat(out,out2);
	return final_out;
}

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

function diff(array){
	diff_array=newArray(array.length-1);
	for(i=0; i<diff_array.length; i++){
		diff_array[i]=array[i+1]-array[i];
	}
	return diff_array;
}

function findInflexion(array){
	indexes_of_inflection=newArray();
	for(i=1; i<array.length-1; i++){
		if(array[i]==0){
			if(array[i-1]<0 && array[i+1]>0){
				indexes_of_inflection=Array.concat(indexes_of_inflection, i);
			}
			
		}
		
	}
	return indexes_of_inflection;
}