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
	}
}