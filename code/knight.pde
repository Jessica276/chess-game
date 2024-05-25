//Chevalier

public class Knight extends Piece{
    public Knight(boolean white,String img){
        super(white,img);
    }

    @Override
    public boolean canMove(Board board, Spot start,Spot end){
    //On ne peut pas déplacer la pièce sur une case qui a une pièce de la même couleur
        if(end.getPiece() != null && end.getPiece().isWhite() == this.isWhite()){
            return false;
        }

        int x = Math.abs(start.getX() - end.getX());
        int y = Math.abs(start.getY() - end.getY());

        return x * y == 2;
    }

    public boolean isCastlingMove(Spot start,Spot end){
        //Vérifiez si le mouvement est un roque en comparant les positions initiales et finales
        if(Math.abs(start.getX() - end.getX()) == 2 && start.getY() == end.getY()){
            return true;
        }
        return false;
    }

    public String toString(){
        return "Knight";
    }
}
