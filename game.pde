class Game{
    private ArrayList<Player> players = new ArrayList<>();
    public Board board = new Board();
    private Player currentTurn;
    private GameStatus status;
    private ArrayList<Move> movesPlayed = new ArrayList<>();

    public void initialize(Player p1, Player p2){
        this.players.add(p1);
        this.players.add(p2);
        board.resetBoard();
        this.currentTurn = p1.isWhiteSide() ? p1 : p2;
        this.status = GameStatus.ACTIVE;
        movesPlayed.clear();
    }

    public boolean isEnd(){
        return this.getStatus() != GameStatus.ACTIVE;
    }

    public GameStatus getStatus(){
        return this.status;
    }

    public void setStatus(GameStatus status){
        this.status = status;
    }

    public Player getCurrentTurn(){
        return this.currentTurn;
    }

    public void switchTurn(){
        this.currentTurn = this.currentTurn == players.get(0) ? players.get(1) : players.get(0);
    }

    public boolean playerMove(Player player, int startX, int startY, int endX, int endY) {
        Spot startBox = board.getBox(startX, startY);
        Spot endBox = board.getBox(endX, endY);
        Move move = new Move(player, startBox, endBox);

        return this.makeMove(move, player);
    }

    private boolean makeMove(Move move, Player player){
        Piece sourcePiece = move.getStart().getPiece();
        Spot start = move.getStart();
        Spot end = move.getEnd();
   
        if(sourcePiece == null){
            return false;
        }
        if(player != currentTurn){
            return false;
        }
        if(sourcePiece.isWhite() != player.isWhiteSide()){
            return false;
        }
        if(!sourcePiece.canMove(board, move.getStart(), move.getEnd())){
            return false;
        }

 
        Piece destPiece = move.getEnd().getPiece();
        if(destPiece != null){
            println("sourcePiece",sourcePiece);
            destPiece.setKilled(true);
            move.setPieceKilled(destPiece);
        }

        if(sourcePiece instanceof King && ((King) sourcePiece).isCastlingMove(start, end)){
            move.setCastlingMove(true);
        }

        movesPlayed.add(move);
        end.setPiece(sourcePiece);
        start.setPiece(null);
        
        if(destPiece instanceof King){
            setStatus(player.isWhiteSide() ? GameStatus.WHITE_WIN : GameStatus.BLACK_WIN);
            System.out.println("Échec et mat");
        } 

        return true;
    }
}
