Game game = new Game();
Player p1 = new HumanPlayer(true);
Player p2 = new HumanPlayer(false);
boolean showGameOverMessage = false;
boolean firstClick = true;
int startX, startY, endX, endY;
ArrayList<int[]> possibleMoves = new ArrayList<>();
PImage gameOverImage;
PImage cassure;

void setup() {
  size(800, 800);
  game.initialize(p1, p2);
  cassure = loadImage("../piece_img/cassure.png");
  cassure.resize(width,height);
  gameOverImage = loadImage("../piece_img/checkmate.png");
  gameOverImage.resize(400,200);
}

void draw(){
  displayBoard();
  if(game.isEnd()){
    showGameOver();
  }
}

void displayBoard(){
  int extent = 100;
  for(int i=0;i<8;i++){
    for(int j=0;j<8;j++){
      if((i+j) % 2 == 0){
        fill(0,100,45); 
      }
      else{
        fill(255,206,158); 
      }

      for(int[] move : possibleMoves){
        if(move[0] == i && move[1] == j){
          fill(100,200,100); 
        }
      }

      square(j * extent, i * extent, extent);

      Piece piece = game.board.getBox(i, j).getPiece();
      if(piece != null){
        PImage pion = loadImage(piece.getImg());
        image(pion, j * extent + extent * 0.2, i * extent + extent * 0.2, extent * 0.6, extent * 0.6);
      }
    }
  }

  if(!firstClick){
    stroke(0, 0, 0);
    strokeWeight(1);
    noFill();
    rect(startY * extent, startX * extent, extent, extent);
    strokeWeight(1);
  }
  
  if(showGameOverMessage){
    showGameOver();
  }
}

void mousePressed(){
  if(showGameOverMessage){
    showGameOverMessage = false;
    game.initialize(p1, p2);
    possibleMoves.clear();
    return;
  }
  
  if(game.isEnd()){
    return;
  }
  
  int x = mouseX / 100;
  int y = mouseY / 100;

  if(firstClick){
    startX = y;
    startY = x;
    Piece selectedPiece = game.board.getBox(startX, startY).getPiece();

    if(selectedPiece != null && selectedPiece.isWhite() == game.getCurrentTurn().isWhiteSide()){
      possibleMoves = getPossibleMoves(selectedPiece, startX, startY);
      firstClick = false;
    }
    else{
      possibleMoves.clear();
    }
  }
  else{
    endX = y;
    endY = x;
    firstClick = true;
    makeMove();
    possibleMoves.clear();
  }
}

void makeMove(){
  boolean moveSuccessful = game.playerMove(game.getCurrentTurn(), startX, startY, endX, endY);
  println(moveSuccessful);
  if(moveSuccessful){
    game.switchTurn();
  }
}

ArrayList<int[]> getPossibleMoves(Piece piece, int x, int y){
  ArrayList<int[]> moves = new ArrayList<>();
  for(int i=0;i<8;i++){
    for(int j=0;j<8;j++){
      if(piece.canMove(game.board, game.board.getBox(x, y), game.board.getBox(i, j))){
        moves.add(new int[] {i, j});
      }
    }
  }
  
  return moves;
}

void showGameOver(){
  displayBoard();
  background(cassure);
  image(gameOverImage,width/2-gameOverImage.width/2,height/2-gameOverImage.height/2-50);

  fill(#31363F);
  textSize(70);
  textAlign(CENTER, CENTER);
  text("Checkmate", width / 2, height / 2 - 40);
  textSize(100);
  
  showGameOverMessage = true;
}
