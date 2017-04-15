# Conways-Game-of-Life
This is a destination for editions and code relating to my personal Game of Life in Processing, a Java Graphics Environment.  

The Game of Life was devised by brilliant English mathematician and world-renowned code/number theorist, John Conway.  It is based off of a visually displayed matrix in which a cell, most often represented as a rectangle on a grid, is either alive(1) or dead(0).  The matrix is re-assessed and replaced every step of the program in which the function assessMatrix(); decides which cells will be on and off in the next sequence based on the number of live neighbors (the eight spaces in the grid around it.)  

The rules for a cell being alive or dead are as follows:  
1.) A living cell will die if it has less than two live neighbors, as if by isolation.  
2.) A living cell will die if it has more than three live neighbors, as if by overcrowding.  
3.) A living cell will remain alive if it has 2 or 3 neighbors, a healthy environment.  
4.) A dead cell will become alive if it has exactly 3 neighbors, as if by reproduction.  

As a result, the shapes and life forms in the matrices can create rather interesting multicellular life forms and serve as a computational model for VERY primitive life.  In the future, I hope to add a user input system, making the arrays accessible and modifiable.  I also hope to add a method in which the organisms are analyzed and colored based on their shape. I hope you at least find enjoyment from this code.
  
  Best Regards,
  
  John Mays
