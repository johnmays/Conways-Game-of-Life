/*This is John Conway's Game of Life:
* It is a grid, with cells
* A cell may be alive(1) or dead(0)
* This data is kept track of in a matrix.
* The matrix is analyzed and remade every step of the program based on several rules:
* 1.) A cell dies by isolation if it has less than one live neighbor
* 2.) A cell dies by overpopulation if it has 4 or more live neighbors
* 3.) A cell lives if it has 2 or 3 neighbors
* Remember, a neighbor is one of the eight other cells around a cell.
*
*/

//GLOBAL VARIABLES:
int numRows = 16;
int numCols = 16;
int height = 640;
int width = height;
int ig = 0;
int jg = 0;
//

/*MAKES A CLEAR MATRIX
*int[][] initialArray = new int[cols][rows];
*for(var i = 0; i < numRows; i++){
*  for(var j = 0; j < numCols; j++){
*    initialMATRIX[i][j] = 0;
*  }
*}
*/

//SO YOU CAN VISUALLY EDIT THE MATRIX(BUILT AROUND A 16 X 16 MATRIX):
int[][] initialMatrix = {{0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0},//16x16 grid, 0 is off, 1 is on
                         {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
                         {0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                         {0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0},
                         {0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0},
                         {0,1,1,1,1,0,0,0,0,0,0,0,0,1,1,0},
                         {0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,1},
                         {0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0}
                        };
                        
//RANDOM BEGINNING ARRAY       
      
//int[][] initialMatrix = new int[numCols][numRows];



void setup(){
  //for(int i = 0; i < numRows; i++){
    //for(int j = 0; j < numCols; j++){
      //int matrixValue = (int)random(0,1.5);
      //initialMatrix[i][j] = matrixValue;
    //}
  //}
  size(640, 640);
  printMatrix(); 
  delay(1000);
}
void draw(){
  initialMatrix = assessMatrix();
  printMatrix();
  delay(250);
}
int[][] assessMatrix(){
  /*this function reads the current array,
  *assesses the number of neighbors,
  *and kills or preserves cells based upon their # of neighbors
  *making a new array and then making the old array = new array
  *effectively remaking the array
  */
  int[][] newMatrix = new int[numRows][numCols];//makes a array for just this function
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
    //CHECKS THE NUMBER OF NEIGHBORS AND DECIDES
      int numNeighbors = assessNeighbors();
    //tell it if it's 0 or 1: 0 is dead, 1 is alive
      if(initialMatrix[i][j] == 1){
        //it is alive
        if(numNeighbors < 4 && numNeighbors > 1){
          newMatrix[i][j] = 1;
        }else{
          newMatrix[i][j] = 0;
        }
      }
      if(initialMatrix[i][j] == 0){
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
  /*FUNCTION RETURNS A NUMBER OF NEIGHBORS, CHECKING EACH OF THE EIGHT SPACES AROUND THE
  *CELL(initialArray[ig][jg])
  *BEFORE CHECKING FOR THAT NEIGHBOR, IT ENSURES THAT THERE WILL BE NO POSSIBILITY OF AN OUT
  *OUT OF BOUNDS VALUE ON THE MATRIX, WHICH IS A FATAL ERROR.
  *THE NUMBER OF NEIGHBORS IS TALLIED WITH THE int neighbors AND RETURNED TO THE assessArray
  *FUNCTION SO THAT IT MAY CONTINUE IN ASSEMBLING THE NEW ARRAY
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
  //this function takes the current version of initialArray and displays it.
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numCols; j++){
      int xPos = j * (width/numCols);
      int yPos = i * (height/numRows);
      int rectWidth = (width/numCols);
      int rectHeight = (height/numRows);
      if(initialMatrix[i][j] == 0){
        fill(235);//dead and white
      }else{
        fill(20);//alive and black
      }
      rect(xPos, yPos, rectWidth, rectHeight); 
    }
  }
}