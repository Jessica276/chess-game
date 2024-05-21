//Fou

class Bishop extends Piece{
    public Bishop(boolean white,String img){
        super(white,img);
    }
    
    @Override
    public boolean canMove(Board board, Spot start, Spot end){
        if(end.getPiece() !=null && end.getPiece().isWhite() == this.isWhite()){
            return false;
        }

        int x = Math.abs(start.getX() - end.getX());
        int y = Math.abs(start.getY() - end.getY());

        //Déplacement en diagonale
        if(x != y){
            return false;
        }

    //Vérifie si le chemin est libre
        // Déterminer la direction du déplacement
        int xDirection = (end.getX() - start.getX()) > 0 ? 1 : -1;
        int yDirection = (end.getY() - start.getY()) > 0 ? 1 : -1;

        int currentX = start.getX() + xDirection;
        int currentY = start.getY() + yDirection;

        while(currentX != end.getX() && currentY != end.getY()){
            if(board.boxes[currentX][currentY].getPiece() != null){
                return false;
            }
            currentX += xDirection;
            currentY += yDirection;
        }

        return true;
    }

    public boolean isCastlingMove(Spot start,Spot end){
        //Vérifiez si le mouvement est un roque en comparant les positions initiales et finales
        if(Math.abs(start.getX() - end.getX()) == 2 && start.getY() == end.getY()){
            return true;
        }
        return false;
    }

    public String toString(){
        return "Bishop";
    }
}
