package com.kim.utils
{
	import com.kim.collections.FileCollection;
	
	import flash.filesystem.File;

	public class Utils
	{
		public static function filterFiles(files:FileCollection, allowedExtensions:Array):FileCollection{
			var allowedFiles:FileCollection = new FileCollection();
			
			//Filter files based on the extensions allowed
			for each(var file:File in files){
				if (allowedExtensions.indexOf(file.extension) != -1) {
					allowedFiles.addItem(file);
				}
			}
			
			return allowedFiles;
		}
		
		//This will sort array alphabetically and numerically in ascending order
		public static function sortFiles(file1:Object, file2:Object, fields:Array):int{
			var fileName1:String = File(file1).name.toLowerCase();
			var fileName2:String = File(file2).name.toLowerCase();
			
			if(isNaN(Number(fileName1)) || isNaN(Number(fileName2))){
				if (fileName1 < fileName2){
					return -1;
				}else if (fileName2 < fileName1){
					return 1;
				}else{
					return 0;
				}
			}else{
				var num1:Number = Number(fileName1);
				var num2:Number = Number(fileName2);
				if (num1 < num2){
					return -1;
				}else if (num2 < num1){
					return 1;
				}else{
					return 0;
				}
			}
		}
	}
}