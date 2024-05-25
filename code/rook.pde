public class Rook extends Piece{
    private boolean castlingDone = false;

    public Rook(boolean white, String img){
        super(white, img);
    }

    public boolean isCastlingDone(){
        return this.castlingDone;
    }

    public void setCastlingDone(boolean castlingDone){
        this.castlingDone = castlingDone;
    }

    @Override
    public boolean canMove(Board board, Spot start, Spot end){
        // Check if the end spot has a piece of the same color
        if(end.getPiece() != null && end.getPiece().isWhite() == this.isWhite()){
            return false;
        }

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

    public boolean isCastlingMove(Spot start, Spot end){
        return Math.abs(start.getX() - end.getX()) == 2 && start.getY() == end.getY();
    }

    public String toString() {
        return "Rook";
    }
}
