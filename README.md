# Change Graph Kit  

**CGK** is a MSX 1 Basic program that reads a binary file on disk, display its contents and modify them on site, on the disk itself.  

Back in the olden MSX days, I wanted to be able to change the graphics on the games I played, working on cassetes and without assembler knowledge, however, the way I managed to do this was to make three very small Basic programs that could live on memory, one at a time, without conflicting with the games they intended to modify, hence the "Kit". They worked but they were not pretty.  
So, for a long time, I wanted to know how far I could go remaking it and at the same time I also wanted to know how close I could get to my usual coding workflow coding in Basic for the MSX.  

And **Change Graph Kit** was reborn, as an experiment on several things, among them [MSX Basic Dignified](https://github.com/farique1/msx-basic-dignified), a Python program that convert an MSX Basic written with modern standards to the classic native format.   

> There are two versions of Change Graph Kit:  
>`CGK-Classic.bas` - The executable MSX Basic.  
>`CGK-Source.bas` - The **MSX Basic Difnified** version.  


Here is a little introduction.  

### Main Interface:  
![# Main Interface](https://github.com/farique1/Change-Graph-Kit/blob/master/Images/Main%20Interface.png)  

Top left:  
- Region view. Binary display of 800 bytes of game contents.  

Top right:  
- Cm: Cursor Movement step.  
- Rm: Region jump on browsing.  
- Game being edited.  

Bottom left:  
Memory positions.  
- C: Cursor initial and final position.  
- R: Region initial and final position.  
- G: Game initial and final position.  

Bottom right:  
- Game map and region position inside it.  


### Overview  
![# Overview](https://github.com/farique1/Change-Graph-Kit/blob/master/Images/Overview.png)  

The Exploded View can be used to see a map of the whole game. It displays 100 chunks of 8 bytes spread evenly through the game.  
 Just select something promising and the program will be taken to that memory region.  

### Edit Screen  
![# Edit Screen](https://github.com/farique1/Change-Graph-Kit/blob/master/Images/Edit%20Screen.png)     

Enter calls the Edit Screen where the art can be properly modified.  
