//Pion

class Pawn extends Piece{
    public Pawn(boolean white, String img){
        super(white, img);
    }

    @Override
    public boolean canMove(Board board, Spot start, Spot end){
        if(end.getPiece() != null && end.getPiece().isWhite() == isWhite()){
            return false;
        }
        
        int startX = start.getX();
        int startY = start.getY();
        int endX = end.getX();
        int endY = end.getY();
        
         // 1:le pion blanc va vers le haut et -1 celui du pion noir mais vers le bas 
        int direction = isWhite() ? -1 : 1; 
        println(startX,startY,endX,endY,direction);

        //Déplacement vertical
        //Si le pion se trouve à la position de départ il ne peut se déplacer que 2 cases sinon une seule 
        if(startX == (isWhite()?6:1)){
          if(endX == startX + 2 * direction &&  endY == startY && end.getPiece()==null){
            return true;
          }
          if(endX == startX + direction && endY == startY && end.getPiece() == null){
            return true;
           }
          
          return false;
        }
        //Si le pion se trouve à la dernière case ascendante(desc) on peut changer de pièce à part changer en roi
        else if(startX == (isWhite() ? 0 : 7)){
          
          
          return true;
        }
        else{
          if(endX == startX + direction && endY == startY && end.getPiece() == null){
            return true;
          }
        }
      

        // Capture diagonale
        if(endX == startX + direction && Math.abs(endY - startY) == 1 && end.getPiece() != null && end.getPiece().isWhite() != isWhite()){
            return true;
        }

        return false;
    }
    
    public boolean isCastlingMove(Spot start, Spot end){
      return false;
    }
    
    @Override
    public String toString() {
        return "Pawn";
    }
}
