abstract class Piece{
    private boolean killed = false;
    private boolean white = false;
    private String img="";

    public Piece(boolean white,String img){
        this.setWhite(white);
        this.img = img;
    }
    
    public String getImg(){
        return img;
    }
    
    public boolean isWhite(){
        return this.white;
    }

    public void setWhite(boolean white){
        this.white = white;
    }

    public boolean isKilled(){
        return this.killed;
    }

    public void setKilled(boolean killed){
        this.killed = killed;
    }

    public abstract boolean canMove(Board board, Spot start, Spot end);

    public abstract boolean isCastlingMove(Spot start, Spot end);
}
