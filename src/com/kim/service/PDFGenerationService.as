package com.kim.service
{
	import com.kim.collections.FileCollection;
	import com.kim.utils.Utils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.purepdf.elements.ReadOnlyRectangle;
	import org.purepdf.elements.images.ImageElement;
	import org.purepdf.pdf.PageSize;
	import org.purepdf.pdf.PdfDocument;
	import org.purepdf.pdf.PdfVersion;
	import org.purepdf.pdf.PdfWriter;
	import org.robotlegs.mvcs.Actor;
	
	public class PDFGenerationService extends Actor
	{
		private var __destinationFolder:String = 'destination';
		private var _pdf:PdfDocument;
		private var _writer:PdfWriter;
		private var _scale:int;
		private var _margin:int;
		private var _buffer:ByteArray;
		private var _currentFile:File;
		
		public function PDFGenerationService()
		{
			super();
		}
		
		//This will sort array alphabetically and numerically in ascending order
		private function sortAscending(element1:Object, element2:Object, fields:Array):int
		{
			var fileName1:String = File(element1).name.toLowerCase();
			var fileName2:String = File(element2).name.toLowerCase();
			
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
		
		public function generate(files:FileCollection):void{
			var path:String = this.__destinationFolder + File.separator;
			
			_buffer = new ByteArray();
			_writer = PdfWriter.create(_buffer, PageSize.A4);
			
			
			//Filter files before use
			var filteredFiles:FileCollection = Utils.filterFiles(files, ["png", "jpg", "jpeg"]);
			filteredFiles
			//Sort the files
			var nameSortField:SortField= new SortField();
			nameSortField.name = "name";
			nameSortField.caseInsensitive = true;
			
			var sort:Sort = new Sort();
			sort.fields = [nameSortField];
			sort.compareFunction = sortAscending;
			
			filteredFiles.sort = sort;
			filteredFiles.refresh();
			
			var byteArr:ByteArray;
			var fs:FileStream;
			for each(_currentFile in filteredFiles)
			{
				byteArr = new ByteArray();
				fs = new FileStream();
				fs.open(_currentFile,FileMode.READ);
				fs.readBytes(byteArr);
				createPDFPage(byteArr);
			}
			
			//Generate PDF
			var newPath:String = (new Date()).milliseconds.toString() + ".pdf";
			var destinationFile:File = File.applicationStorageDirectory.resolvePath(newPath);
			
			_pdf.close();
			_buffer.position = 0;
			
			fs = new FileStream();
			fs.open(destinationFile, FileMode.WRITE);
			fs.writeBytes(_buffer, 0, _buffer.length);
			fs.close();
		}
		
		//This will process image and create new pdf page
		private function createPDFPage(bArr:ByteArray):void
		{
			var image:ImageElement = ImageElement.getInstance(bArr);
			
			_pdf = _writer.pdfDocument;
			_pdf.setPdfVersion(PdfVersion.VERSION_1_5);
			_pdf.setMargins(2,2,2,2);
			
			//This will check if the size of image is greater than A4 size
			//It will also check whether image width is less than equal to A4 size width and image height is greater than equal to A4 size height
			//and also check whether image width is greater than equal to A4 size width and image height is less than equal to A4 size height
			//If any one of the condition is satisfied we will assign custom page size to the pdf page as image width and height
			if(image.width >= 595 && image.height >= 842
				|| image.width <= 595 && image.height >= 842
				|| image.width >= 595 && image.height <= 842){//where A4 width is 595 and A4 height is 842
				
				_pdf.pageSize = new ReadOnlyRectangle(0,0,image.width + 2, image.height + 2);
			}else{
				_pdf.pageSize = PageSize.A4;
			}
			
			if(_pdf.opened){
				_pdf.newPage();		
			}else{
				_pdf.open();
			}
			_pdf.add(image);
			
		}
	}
}