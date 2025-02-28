//Macro citation (pending pub): Campbell, Jessica. 2021. Macro for the Frontal Sinus Total Difference Method. Github
//2022	Campbell J, Butaric L.  A Validation Test of the Total Difference Technique for Assessing the Frontal Sinus.  American Academy of Forensic Sciences 74th Annual Scientific Meeting (poster).  Seattle, WA.

//USER NOTES:  
//ROI starters file should be downloaded prior to applying this macro, or a new file created and saved.
//Explanations are preceeded by forward slashes.
//This macro was written in java script, created in FIJI, but can be used in the original ImageJ.
//Fiji and ImageJ are free to all users!
//Comments, questions, and changes can be directed to the author.
//See the TDM_Manual for detailed instructions.
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


//START HERE:  USER INPUT REQUIRED: change /input paths/ and customizers
//Change input paths in lines 24, 36 (line numbers preference location in this venue and can change if you copy/paste or only select bits of this code)
//Designate starting image, lines 42, 43
//Identify and define scalar, lines 52-55
//Change folder location where you want to write your results into, line 113
//Make sure all paths and locations use /FORWARD slashes/, if copying the path name from a Windows based system.
//After you make these changes, click "RUN" or "CTRL+R" to start macro; do not pre-open images

//enter path to the folder where radiograph outline images are stored, in quotations and using /forward slashes/ into parentheses
input_path = getDirectory("C:/Users/your path/folder with images"); 
//in pop-up click to select folder with images

fileList = getFileList(input_path);

for (i = 0; i < fileList.length; i++) {
 		
	//clean to prepare for next image
	roiManager("reset");
	//roi starters can be downloaded from GitHub https://github.com/jcampbelljess/FrontalSinus_TD_macros/RoiStarters
		
	//enter path to the .zip file with stored roi's
	roiManager("open", "C:/Users/your path/folder with ROI starters/RoiStarters.zip");
	run("Close All"); 
	run("Clear Results");
	
	//open image
	//For the first image in your session: Starting with 0, enter the image number from the folder you want to start working on in both of the following lines:
	open(input_path + fileList[i+0]); //if add a +number; starts with image number "xx" in the file folder
	print(input_path + fileList[i+0]); //display the file working on

	//get the title of the image
	title = File.nameWithoutExtension;
	
	//Set Scale
	//Can be changed to match another measuring aid or radiographic scale bar.
	setTool("line");
	makeLine(1600, 1800, 2172, 1892);
	waitForUser("Set the Scale", "Draw Orbital Breadth: Dacryon>Ectoconchion");
	run("Set Scale...", "known=39.49 unit=mm"); 
	//if a ruler was radiographed, change "known=" to that distance (1 for 1 cm or 1 inch, etc), and the "unit=" (inches, cm, mm, etc.)
	//can also change your prompt box above; example: "Draw scalar length" in place of "Draw Orbital Breadth..."

	
	//Measure total sinus outline
	setTool("wand");
	//doWand(2010, 1557);
	waitForUser("Tool: Magic Wand", "Highlight Blue Sinus Outline");
	roiManager("Add");
	roiManager("Select", 3);
	roiManager("Rename", "Total Sinus");
	Roi.move(700, 2500);
	
	//Make midline to find origin point
	setTool("line");
	setLineWidth(3);
	makeLine(840, 1170, 852, 2634);
	waitForUser("Align Midline", "Adjust midline endpoints or draw a new midline");
	setForegroundColor(255, 255, 255);
	run("Fill", "slice");
	
	//Draw baseline and note angle for overlay rotation
	setTool("line");
	roiManager("Show All with labels");
	roiManager("Select", 1);
	waitForUser("Reset Baseline", "1.) Grab center point (ROI Label #2) to move line 2.) Move end points 3.) Record angle from ImageJ operations line");
	Roi.move(500, 2700);
	
	//Rotate overlay to outline
	setTool("wand");
	makeRectangle(50, 500, 2700, 1800); // rectangle must include sinus outline
	
	//Enter baseline angle to rotate sinus
	baselineAngle = getNumber("Enter baseline angle", -0.90);
	run("Rotate... ", "angle=baselineAngle grid=1 interpolation=Bilinear");
	
	//Draw right side baseline
	roiManager("Select", 2);
	setTool("line");
	waitForUser("Set Right-side Baseline", "1.) Grab center point (ROI Label #3) to move line; 2.) Move end points to origin, right terminus");
	Roi.move(600, 2800);
	
	//Move Overlay
	roiManager("Select", 0);
	waitForUser("Move Overlay", "1.) Use arrow keys or grab the center point (ROI Label #1) to drag overlay; align origin and pre-existing sinus outline baseline");
	
	//Draw angles
	setTool("angle");
	waitForUser("Draw initial 3° angle", "Right baseline terminus >to> origin >to> 3°(first ray on right side overlay");
	roiManager("Add");
	roiManager("Select", 4);
	roiManager("Set Color", "cyan");
	roiManager("Set Line Width", 1);
	roiManager("update");
	waitForUser("Draw 58 remaining lines to innermost border of furthest intersection with the blue sinus outline", "Drag moveable end of angle line around every 3° (exclude 180°), pressing t to record a new ROI for each ray of overlay");
		
	//Mesaure all ROIs
	run("Set Measurements...", "area perimeter display redirect=None decimal=3");
	roiManager("Select", newArray(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62));
	roiManager("Measure");
	
	//Save results
	saveAs("results", "C:/Users/input path/Results folder/" + title + "_compare.csv");
	waitForUser("Check save file; if compromised, select all results in results window and copy into an excel file");
	
}