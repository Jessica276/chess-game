//Tour

public class Rook extends Piece{
    private boolean castlingDone = false;
  
    public Rook(boolean white,String img){
        super(white,img);
    }
    
    public boolean isCastlingDone(){
        return this.castlingDone;
    }

    public void setCastlingDone(boolean castlingDone){
        this.castlingDone = castlingDone;
    }

    @Override
    public boolean canMove(Board board,Spot start,Spot end){
        if(end.getPiece() != null && end.getPiece().isWhite() == this.isWhite()){
            return false;
        }

        int x = Math.abs(start.getX() - end.getX());
        int y = Math.abs(start.getY() - end.getY());

        //La tour se déplace soit horizontalement soit verticalement
        if(x != 0 || y != 0){
            return false;
        }

    //Vérifie si le chemin est libre, elle ne peut pas sauter une pièce
        int min_X = Math.min(start.getX(),end.getX());
        int min_Y = Math.min(start.getY(),end.getY());
        int max_X  = Math.max(start.getX(),end.getX());
        int max_Y = Math.max(start.getY(),end.getY());

        //Déplacement verical
        if(x==0){
            for(int i=min_Y+1;i<max_Y;i++){
                if(board.boxes[start.getX()][i].getPiece() == null){
                    return true;
                }
            }

            return false;
        }

        //Déplacement horizontal
        if(y==0){
            for(int i=min_X+1;i<max_X;i++){
                if(board.boxes[i][start.getY()].getPiece() == null){
                    return true;
                }
            }

            return false;
        }
        

        return true;
    }

    public boolean isCastlingMove(Spot start,Spot end){
        //Vérifie si le mouvement est un roque en comparant les positions initiales et finales
        if(Math.abs(start.getX() - end.getX()) == 2 && start.getY() == end.getY()){
            return true;
        }
        return false;
    }
    
    public String toString(){
        return "Rook";
    }
}
