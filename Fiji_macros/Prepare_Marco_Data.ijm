root="R:\\Marco\\Twitching Microscopy\\Widefield";
save_data="R:\\Marco\\Twitching Microscopy\\Localization_study";

file_list=getSpecificFilesList(root, "TCourse", "316", ".nd2");
print(file_list.length);
//open(file_list[0]);
run("Bio-Formats Importer", "open=["+file_list[0]+"] autoscale open_all_series concatenate_series color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");
		

/*for (i = 0; i < file_list.length; i++) {
	if(contains(file_list[i], "h")){
		print(file_list[i]);
	}
}*/

//run("Bio-Formats Importer", "open=["+file_list[0]+"] autoscale color_mode=Default split_channels view=Hyperstack stack_order=XYCZT");


//---------------------------------------------------------------Functions--------------------------------------------------------------


function contains(string1, string2) {
/* contains(string1, string2) cheks if string2 is constained in string1.
 * It returns "true" if it is and "false" if not
 */	
	ind_string2=indexOf(string1, string2);
	if (ind_string2>=0) {
		return true;
	} else {
		return false;
	}
}

function getExperimentFolders(root, string_in_name) {
/* getExperimentFolders(root, string_in_name) looks in folder givent as a path in "root"
 * for any subfolder name that contains the string defined in string_in_name
 */
 	dir_raw=getFileList(root);
	dir_filtered=newArray();
	for (i = 0; i < dir_raw.length; i++) {
		if(contains(dir_raw[i], string_in_name)){
			dir_filtered=Array.concat(dir_filtered,root+File.separator+dir_raw[i]);
		}
	}
	if (dir_filtered.length>0) {
		return dir_filtered;
	} else {
		exit("No subfolders containing '"+string_in_name+"' were found in 'root' folder");
	}
}

function getSrainFolders(dir_list, strain_in_name) {
/* getSrainFolders(dir_list, strain_in_name) looks for the strain defined in
 * "strain_in_name" in the directory list defined in "dir_list"
 */
	dir_filtered=newArray();
	for (i = 0; i < dir_list.length; i++) {
		if(contains(dir_list[i], strain_in_name)){
			dir_filtered=Array.concat(dir_filtered,dir_list[i]);
		}
	}
	if (dir_filtered.length>0) {
		return dir_filtered;
	} else {
		exit("No subfolders containing '"+strain_in_name+"' were found in 'root' folder");
	}
}

function getSpecificFilesList(root, string_in_name, strain_in_name, extension) {
/* getExperimentFolders(root, string_in_name) looks in folder givent as a path in "root"
 * for any subfolder name that contains the string defined in string_in_name
 */
	dir_string=getExperimentFolders(root, string_in_name);
	dir_filtered=getSrainFolders(dir_string, strain_in_name);
	file_list=newArray();
	if (dir_filtered.length>0) {
		for (i = 0; i < dir_filtered.length; i++) {
			temp=newArray();
			file_list_temp=listFiles(dir_filtered[0], extension, strain_in_name, temp);
			file_list=Array.concat(file_list, file_list_temp);
		}
	}
	return file_list;
}

function listFiles(root, extension, strain_in_name, empty_file_list) {
/* listFiles(root, extension) looks in folder and subfolders given as a path in "root"
 * for any file that ends with the extension defined in "extension".
 */
	list = getFileList(root);
	for (i=0; i<list.length; i++) {
		if (endsWith(list[i], "/")) {
			newList=replace(list[i], "/", "\\");
			temp=listFiles(""+root+newList, extension, strain_in_name, empty_file_list);
			empty_file_list=Array.concat(empty_file_list, temp);
		} else if (contains(list[i], strain_in_name) & endsWith(list[i], extension)) {
			empty_file_list=Array.concat(empty_file_list, root+File.separator+list[i]);
		}
	}
	return empty_file_list;
}