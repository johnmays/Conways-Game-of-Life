/*This is John Conway's Game of Life with User Input:
* It is a grid, with cells
* A cell may be alive(1) or dead(0)
* This data is kept track of in a matrix.
* The matrix is analyzed and remade every step of the program based on several rules:
* 1.) A live cell dies by isolation if it has less than one live neighbor
* 2.) A live cell dies by overpopulation if it has 4 or more live neighbors
* 3.) A live cell lives if it has 2 or 3 neighbors, as if normal conditions
* 4.) A dead cell can come alive if it has exactly three neighbors, as if by reproduction
* Remember, a neighbor is one of the eight other cells around a cell.
*/

//  GLOBAL VARIABLES:
boolean paused = true;
final int DELAY = 55;//MINIMUM OF 10 MILLISECONDS, GIVE PROGRAM TIME TO RUN ON BIG MATRICES
final int clickResponseDelay = 100;
final int numRows = 100;
final int numCols = 100;
final int HEIGHT = 500;
final int WIDTH = 500;
int[][] initialMatrix = new int[numCols][numRows];
//GLOBALS FOR LOOP PROCESSION:
int ig = 0;
int jg = 0;
//

void setup(){
  size(500,500);
  noStroke();
  //CREATES BEGINNING ARRAY AND GETS THE PROGRAM STARTED
  
  //RANDOM BEGINNING MATRIX
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numCols; j++){
      int matrixValue = (int)random(0,1.5);
      initialMatrix[i][j] = matrixValue;
    }
  }
  
  //OR CLEAR MATRIX
  //for(int i = 0; i < numRows; i++){
    //for(int j = 0; j < numCols; j++){
      //initialMatrix[i][j] = 0;//-DEAD
    //}
  //}
  printMatrix(); 
  delay(1000);
}
void draw(){
  if(paused == false){
    //REPEATS EVERY (DELAY) MILLESECONDS
    initialMatrix = assessMatrix();
    
    delay(DELAY);
  }else{
    cursorControlMatrix();
  }
  printMatrix();
  fill(255,0,0);
  

}
int[][] assessMatrix(){
 /*  THIS FUNCTION READS THE CURRENT ARRAY
  *  AND KILLS OR PRESERVES CELLS BASES ON numNeighbors
  *  MAKING newArray AND EXCHANGING IT FOR initialArray
  *  EFFECTIVELY ASSESSING THE ARRAY.
  */
  int[][] newMatrix = new int[numRows][numCols];//  makes an array for just this function
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numCols; j++){
      newMatrix[i][j] = 0;
    }
  }
  for(int i = 0; i< numRows; i++){
    for(int j = 0; j < numCols; j++){
    //SELECTS POINT ON ARRAY AND REASSIGNS GLOBALS
      ig = i;
      jg = j;
    //CHECKS numNeighbors WITH THE assessNeighbors FUNCTION
      int numNeighbors = assessNeighbors();
    /*THESE IF/ELSES TELL THE newMatrix IF IT IS GOING TO HAVE A 0 OR A 1 IN IT'S 
    *RESPECTIVE initialArray POSITION
    */
      if(initialMatrix[i][j] == 1){
        //ALIVE
        if(numNeighbors < 4 && numNeighbors > 1){
          newMatrix[i][j] = 1;
        }else{
          newMatrix[i][j] = 0;
        }
      }
      if(initialMatrix[i][j] == 0){
        //DEAD
        if(numNeighbors ==3){
          newMatrix[i][j] = 1;
        }else{
          newMatrix[i][j] = 0;
        }
      }
    }
  }
  initialMatrix = newMatrix;
  return initialMatrix;
}

int assessNeighbors(){
 /*  FUNCTION RETURNS A NUMBER OF NEIGHBORS, CHECKING EACH OF THE EIGHT SPACES AROUND THE
  *  CELL(initialArray[ig][jg])
  *  BEFORE CHECKING FOR THAT NEIGHBOR, IT ENSURES THAT THERE WILL BE NO POSSIBILITY OF AN OUT
  *  OUT OF BOUNDS VALUE ON THE MATRIX, WHICH IS A FATAL ERROR.
  *  THE NUMBER OF NEIGHBORS IS TALLIED WITH THE int neighbors AND RETURNED TO THE assessArray
  *  FUNCTION SO THAT IT MAY CONTINUE IN ASSEMBLING THE NEW ARRAY
  */
  int neighbors = 0;
  if(ig != 0 && jg != 0){//top left 
    if(initialMatrix[ig-1][jg-1] == 1){
      neighbors++;
    }
  }
  if(ig != 0){//top center
    if(initialMatrix[ig-1][jg] == 1){
      neighbors++;
    }
  }
  if(ig != 0 && jg != numCols-1){//top right
    if(initialMatrix[ig-1][jg+1] == 1){
      neighbors++;
    }
  }
  if(jg != 0){//left center
    if(initialMatrix[ig][jg-1] == 1){
     neighbors++;
    }
  }
  if(jg != numCols-1){//right center
    if(initialMatrix[ig][jg+1] == 1){
     neighbors++;
    }
  }
  if(ig != numRows-1 && jg != 0){//bottom left
    if(initialMatrix[ig+1][jg-1] == 1){
      neighbors++;
    }   
  }
  if(ig != numRows-1){//bottom center
    if(initialMatrix[ig+1][jg] == 1){
      neighbors++;
    }
  }
  if(ig != numRows-1 && jg != numCols-1){//bottom right
    if(initialMatrix[ig + 1][ jg + 1] == 1){
      neighbors++;
    }
  }
  return neighbors;
}
void printMatrix(){
  //  THIS FUNCTION TAKES THE CURRENT VERSION OF INITIAL MATRIX AND DISPLAYS IT
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numCols; j++){
      int xPos = j * (width/numCols);
      int yPos = i * (height/numRows);
      int rectWidth = (width/numCols);
      int rectHeight = (height/numRows);
      if(initialMatrix[i][j] == 0){
        fill(20);//  DEAD AND BLACK
      }else{
        fill(235);//  ALIVE AND WHITE
      }
      rect(xPos, yPos, rectWidth, rectHeight); 
    }
  }
  //findOrganisms();
}



void keyReleased(){
  if(key == ENTER || key == ' '){
    if(paused == true){
      paused = false;
    }else if(paused == false){
      paused = true;
    }
  }
  delay(DELAY);
}

void cursorControlMatrix(){
 /*  THIS FUNCTION ALLOWS YOU TO CHANGE THE ORIENTATION OF A CELL WHENEVER
  *  THE GAME IS PAUSED.
  *  IF YOUR CURSOR IS ABOUVE A CELL AND mousePressed == true
  *  THEN THAT CELL WILL CHANGE ONCE, EITHER FROM 1 TO 0 OR 0 TO 1
  */
  
  //  IDENTIFY WHICH CELL THE CURSOR IS OVER
  int cursorColumn = mouseX /5;
  int cursorRow = mouseY /5;
  
  //  CHANGE THAT CELL DEPENDING ON mousePressed
  if(initialMatrix[cursorRow][cursorColumn] == 0 && mousePressed){
    initialMatrix[cursorRow][cursorColumn] = 1;
    delay(clickResponseDelay);
  }else if(initialMatrix[cursorRow][cursorColumn] == 1 && mousePressed){
    initialMatrix[cursorRow][cursorColumn] = 0;
    delay(clickResponseDelay);
  }
}

void findOrganisms(){
 /*  Since this is going to be a very long function, I'm putting it at the bottom,
  *  even though it is called by printMatrix().  This function will find certain 
  *  organisms and color them based on their type.
  */
  for(int i = 0; i< numRows; i++){
    for(int j = 0; j < numCols; j++){
      if(checkForSquare()){
      }      
      
      
      
    }
  }
  
  
}

boolean checkForSquare(){
  boolean isSquare = true;
  
//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE//RIGHTHERE
  
  return isSquare;
}