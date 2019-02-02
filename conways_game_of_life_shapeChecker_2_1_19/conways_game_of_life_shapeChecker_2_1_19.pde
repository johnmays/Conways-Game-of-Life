//GLOBAL VARIABLES:
int numRows = 100;
int numCols = 100;
int height = 1300;
int width = height;
int ig = 0;
int jg = 0;

int[][] initialMatrix = new int[numCols][numRows];

void setup(){
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numCols; j++){
      int matrixValue = (int)random(0,1.5);
      initialMatrix[i][j] = matrixValue;
    }
  }
  size(1300, 1300);
  printMatrix(); 
  delay(1000);
}

void draw(){
  initialMatrix = assessMatrix();
  printMatrix();
  delay(20);
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

boolean identifyNeighbors_static_block(){
  /*  This function a sixteen square area to determine if there is an isolated block shape.
   *  First, it looks to see if the top center, top right, and right blocks are live.
   *  Then, if every other block is dead, it will identify the square and color it.
   */
  boolean isBlock = true;
  if(ig != 0 && jg != 0){//top left 
    if(initialMatrix[ig-1][jg-1] == 1){
      return false;
    }
  }
  if(ig != 0){//top center
    if(initialMatrix[ig-1][jg] == 0){
      return false;            //must be alive
    }
  }
  if(ig != 0 && jg != numCols-1){//top right
    if(initialMatrix[ig-1][jg+1] == 0){      //must be alive
      return false;
    }
  }
  if(jg != 0){//left center
    if(initialMatrix[ig][jg-1] == 1){
     return false;
    }
  }
  if(jg != numCols-1){//right center
    if(initialMatrix[ig][jg+1] == 0){        //must be alive
     return false;
    }
  }
  if(ig != numRows-1 && jg != 0){//bottom left
    if(initialMatrix[ig+1][jg-1] == 1){
      return false;
    }   
  }
  if(ig != numRows-1){//bottom center
    if(initialMatrix[ig+1][jg] == 1){
      return false;
    }
  }
  if(ig != numRows-1 && jg != numCols-1){//bottom right
    if(initialMatrix[ig + 1][ jg + 1] == 1){
      return false;
    }
  }
  
  //now I need to check the rest of the periphery, AKA two blocks away on the top and right
  
  if(ig != numRows-1 && jg != numCols-2){//bottom right right
    if(initialMatrix[ig + 1][ jg + 2] == 1){
      return false;
    }
  }
  if(jg != numCols-2){//center right right
    if(initialMatrix[ig][jg+2] == 1){
      return false;
    }
  }
  
  if(ig != 0 && jg != numCols-2){//top right right
    if(initialMatrix[ig-1][jg+2] == 1){
      return false;
    }
  }
  if(ig-1 != 0 && jg != numCols-2){//top top right right
    if(initialMatrix[ig-2][jg+2] == 1){
      return false;
    }
  }
  if(ig-1 != 0 && jg != numCols-1){//top top right
    if(initialMatrix[ig-2][jg+1] == 1){      
      return false;
    }
  }
  if(ig-1 != 0){//top top center
    if(initialMatrix[ig-2][jg] == 1){
      return false;            
    }
  }
  if(ig-1 != 0 && jg != 0){//top top left 
    if(initialMatrix[ig-2][jg-1] == 1){
      return false;
    }
  }
  if(initialMatrix[ig][jg] == 0){
    return false;
  }
  //now I need to check if the center block is alive
  return true;
  
}



void printMatrix(){
  //this function takes the current version of initialArray and displays it.
  noStroke();
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numCols; j++){
      int xPos = j * (width/numCols);
      int yPos = i * (height/numRows);
      int rectWidth = (width/numCols);
      int rectHeight = (height/numRows);
      if(initialMatrix[i][j] == 0){
        fill(245);//dead and white
      }else{
        fill(200, 0, 0);//alive and black
      }
      rect(xPos, yPos, rectWidth, rectHeight); 
    }
  }
}
