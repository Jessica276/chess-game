import javax.swing.JOptionPane;

Game game = new Game();
Player p1 = new HumanPlayer(true);
Player p2 = new HumanPlayer(false);
boolean firstClick = true;
int startX, startY, endX, endY;
ArrayList<int[]> possibleMoves = new ArrayList<>();

void setup() {
  size(800, 800);
  game.initialize(p1, p2);
}

void draw(){
  displayBoard();
  if(game.isEnd()){
    showGameOverMessage();
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
}

void mousePressed(){
  if (game.isEnd()) {
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

void showGameOverMessage(){
  GameStatus status = game.getStatus();
  String message = "";
  if(status == GameStatus.WHITE_WIN){
    message = "White wins!";
  }
  else if (status == GameStatus.BLACK_WIN){
    message = "Black wins!";
  }
  else if (status == GameStatus.RESIGNATION){
    message = "The game is a draw!";
  }

  JOptionPane.showMessageDialog(null, message);
  game.initialize(p1, p2);  // Reinitialise la partie
  firstClick = true;
  possibleMoves.clear();
}
