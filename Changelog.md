# Change Graph Kit

## **v1.6.0**  
***14-1-2020***  

- Updated most subroutines to the new Dignified FUNC proto-function
- Replaced operators with the new Dignified +=, ++, etc where possible
- "|M|Kys" not showing anymore on Edit screen if on ML fallback
- Made DEFINEs for chr$ keys, keyboard scans and screen drawing
- Error handling improvements
- Small code adjustments, cleanup and optimizations
- Fixed bug with a wrong error number when a support file was not found

## **v1.5.1**  
***17-9-2019***  
- External .com file ML routines, keeping a simplified version on DATA as a fall back
- - New, exclusive in the .com: rotate, slide(move), flip and improved copy to VRAM 
- Better ML DEFINE calls using the new Dignified DEFINEs variables
- Streamlined initialization sequence, ML routines and error text only load once
- New mini preview area with Copy and Paste and the editing area address
- Small layout changes with file name now on top line and more space for the step text
- Configuration can now be saved and is automatically load at the start. Color only
- Option to scan only the area under the cursor
- Better region map calculation
- Better overview region location report
- Game addresses now starts at position 0 not position 1
- Cursor cannot go or stay beyond game length anymore
- Files now have a minimum limit of 800 bytes to be loaded
- Fixed bug (bad coding, aham) leaking memory on the overview display
- Converted 0 - 1 variables to the new Dignified TRUE - FALSE
- Small code optimizations 

## **v1.4.0**  
***24-8-2019***  
- ML Routines.  
- - Quickly clear the scan area.  
- - Show and erase window requester.  
- - Erase and invert the mini preview.  
- - Refresh the edit area with the mini preview data.  
- Faster save using the mini preview data.  
- Multi purpose window requester.  
- Edit screen mini preview with independent colors.  
- No more save, was not needed. P key now exits.  
- File always closed on exit, new, errors or break.  
- On Stop handling of break.  
- Better error report (Portuguese and English only).  
- Code optimization.  

## **v1.3.0**  
***23-7-2019***
- "File requester".  
- Confirmation for new file.  

## **v1.2.5**  
- Bug fixes.  
- Converted variables to long name (Dignified).   
