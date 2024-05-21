//Roi

public class King extends Piece{
    private boolean castlingDone = false;

    public King(boolean white,String img){
        //Appelle le constructeur de la superclasse (classe mère Piece)
        super(white,img);
    }

    public boolean isCastlingDone(){
        //si le roque est terminé
        return this.castlingDone;
    }

    public void setCastlingDone(boolean castlingDone){
        this.castlingDone = castlingDone;
    }

    @Override
    public boolean canMove(Board board,Spot start,Spot end){
        //On ne peut pas déplacer la pièce sur une case qui a une pièce de la même couleur
        if(end.getPiece() != null && end.getPiece().isWhite() == this.isWhite()){
            return false;
        }
        int x = Math.abs(start.getX() - end.getX());
        int y = Math.abs(start.getY() - end.getY());
        
        //Vérifie si ce mouvement ne met pas le roi en echec
        if(x<=1 && y<=1){
            return true;
        } 

        if(this.isValidCastling(board, start, end)){
            return true;
        }

        return false;
    }

    private boolean isValidCastling(Board board,Spot start,Spot end){
        if(this.isCastlingDone()){
            return false;
        }
        
        
        //Vérifie que le mouvement est de 2 cases horizontalement
        if(Math.abs(start.getX() - end.getX()) != 2 || start.getY() != end.getY()){
            return false;
        }

        //Détermine la direction du roque
        int direction = (end.getX() - start.getX()) > 0 ? 1 : -1;

        //Vérifie les cases entre le roi et la tour
        for(int i=1;i<3;i++){
            Spot intermediateSpot = board.getBox(start.getX() + i * direction, start.getY());
            if(intermediateSpot.getPiece() != null){
                return false;
            }
        }

        //Vérifie la tour correspondante
        Spot rookSpot = board.getBox(start.getX() + 3 * direction, start.getY());
        Piece rook = rookSpot.getPiece();
        if(rook == null || !(rook instanceof Rook) || ((Rook) rook).isCastlingDone()){
            return false;
        }

        //Vérifie que le roi ne passe pas par une case attaquée
        for(int i=0;i<=2;i++){
            Spot checkSpot = board.getBox(start.getX() + i * direction, start.getY());
            if(board.isSpotUnderAttack(checkSpot, !this.isWhite())){
                return false;
            }
        }

        return  true;
    }

    public boolean isCastlingMove(Spot start,Spot end){
        //Vérifiez si le mouvement est un roque en comparant les positions initiales et finales
        if(Math.abs(start.getX() - end.getX()) == 2 && start.getY() == end.getY()){
            return true;
        }

        return false;
    }

    public String toString(){
        return "King";
    }
}
