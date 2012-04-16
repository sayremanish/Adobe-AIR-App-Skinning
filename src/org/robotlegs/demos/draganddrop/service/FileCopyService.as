package org.robotlegs.demos.draganddrop.service
{
	import flash.filesystem.File;
	import flash.net.FileReference;
	
	import org.robotlegs.mvcs.Actor;
	
	import org.robotlegs.demos.draganddrop.model.vo.FileCollection;
	
	public class FileCopyService extends Actor
	{
		
		private var __destinationFolder:String = 'destination';
		
		public function process(filesToCopy:FileCollection):void {
			// first we determine the destination path using FileReference
			var path:String = this.__destinationFolder + File.separator;
			
			// we take these filesToCopy
			// and copy a version to destination path
			for each(var file:File in filesToCopy) {
				// form the new destination FileReference per file
				var newPath:String = path + file.name;
				var destination:FileReference = File.applicationStorageDirectory.resolvePath(newPath);
				// actual copying of the file to the new destination
				file.copyTo(destination);
			}
		}
	}
}