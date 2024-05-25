//Dame

public class Queen extends Piece{
    public Queen(boolean white,String img){
        super(white,img);
    }

    public boolean canMove(Board board,Spot start,Spot end){
        if(end.getPiece() != null && end.getPiece().isWhite() == isWhite()){
            return false;
        }

        return moveRook(board,start,end) || moveBishop(board,start,end);
    }

    public boolean moveRook(Board board,Spot start,Spot end){
        int x = end.getX() - start.getX();
        int y = end.getY() - start.getY();

        // La tour se déplace horizontalement ou verticalement
        if(x != 0 && y != 0){
            return false;
        }

        int min_X = Math.min(start.getX(), end.getX());
        int min_Y = Math.min(start.getY(), end.getY());
        int max_X = Math.max(start.getX(), end.getX());
        int max_Y = Math.max(start.getY(), end.getY());

        //Mouvement horizontal
        if(x != 0){
            for(int i=min_X + 1;i<max_X;i++){
                if(board.boxes[i][start.getY()].getPiece() != null){
                    return false;
                }
            }
        }

        //Mouvement vertical
        if(y != 0){
            for(int i = min_Y + 1;i<max_Y;i++){
                if(board.boxes[start.getX()][i].getPiece() != null){
                    return false;
                }
            }
        }
        
        return true;
    }

    public boolean moveBishop(Board board,Spot start,Spot end){
        int x = Math.abs(start.getX() - end.getX());
        int y = Math.abs(start.getY() - end.getY());
        
        //Déplacement en diagonale
        if(x != y){
            return false;
        }
    //Vérifie si le chemin est libre
        //Déterminer la direction du déplacement
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
        return "Queen";
    }
}
