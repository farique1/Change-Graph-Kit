  
# Change Graph Kit  
v1.7  
  
**CGK** is a MSX 1 Basic program that reads a binary file on disk (eg: a game), display its contents as binary graphic patterns and modify them on the disk itself.  
A small set of machine language routines with 'advanced' edit tools called `CGKTools.com` are loaded if they are available.  
  
Back in the olden MSX days, I wanted to be able to change the graphics of the games I played, working on cassettes and without assembler knowledge, however, the way I managed to do this was to make three very small Basic programs that could live on memory, one at a time, without conflicting with the games they intended to modify, hence the "Kit" on the name. They worked but they were not pretty.  
So, for a long time, I wanted to know how far I could go remaking it and at the same time I also wanted to know how close I could get to my usual workflow coding in Basic for the MSX.  
  
That is why **Change Graph Kit** was reborn, as an experiment on several things, among them **MSX Basic Dignified**, a Python program that convert an MSX Basic written with modern standards to the classic native format, assembler routines and a reconnection with the MSX in general.  
  
> There are three versions of the Change Graph Kit code:  
>[`CGK-Dignified.bad`](https://github.com/farique1/Change-Graph-Kit/blob/master/CGK-Dignified.bad) - The **MSX Basic Dignified** version.  
>[`CGK-Classic.asc`](https://github.com/farique1/Change-Graph-Kit/blob/master/CGK-Classic.asc) - The Classic MSX Basic converted to ASCII format with [**MSX Basic Dignified**](https://github.com/farique1/msx-basic-dignified).  
>[`CGK-Classic.bas`](https://github.com/farique1/Change-Graph-Kit/blob/master/CGK-Classic.bas) - The Classic MSX Basic saved in tokenized format with [**MSX Basic Tokenizer**](https://github.com/farique1/MSX-Basic-Tokenizer).  
  
Here is a little introduction.  
  
### "File Requester":  
![# File Requester](https://github.com/farique1/Change-Graph-Kit/blob/master/Images/File%20Requester.png)  
  
- Pick the game without typing.  
  
  
### Main Interface:  
![# Main Interface](https://github.com/farique1/Change-Graph-Kit/blob/master/Images/Main%20Interface.png)  
  
Top left:  
- Region view. Binary display of 800 bytes of game contents.  
  
Top right:  
- Cursor Movement step.  
- Region jump on browsing.  
  
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
