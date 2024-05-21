float extent = 100;

public class Board{
    Spot[][] boxes;

    public Board(){
        this.boxes = new Spot[8][8];
        this.resetBoard();
        //this.displayBoard();
    }

    public Spot getBox(int x, int y){
        if(x<0 || x>7 || y<0 || y>7){
            throw new IllegalArgumentException("Index out of bound");
        }

        return boxes[x][y];
    }

    public void resetBoard(){
        //initialisation des pièces blanches
        boxes[0][0] = new Spot(0, 0, new Rook(false,"rook_b.png"));
        boxes[0][1] = new Spot(0, 1, new Knight(false,"knight_b.png"));
        boxes[0][2] = new Spot(0, 2, new Bishop(false,"bishop_b.png"));
        boxes[0][3] = new Spot(0, 3, new Queen(false,"queen_b.png"));
        boxes[0][4] = new Spot(0, 4, new King(false,"king_b.png"));
        boxes[0][5] = new Spot(0, 5, new Bishop(false,"bishop_b.png"));
        boxes[0][6] = new Spot(0, 6, new Knight(false,"knight_b.png"));
        boxes[0][7] = new Spot(0, 7, new Rook(false,"rook_b.png"));

        for(int i=0;i<8;i++){
            boxes[1][i] = new Spot(1, i, new Pawn(false,"pawn_b.png"));
        }

        for(int i=0;i<8;i++){
            boxes[6][i] = new Spot(6, i, new Pawn(true,"pawn_w.png"));
        }

        //initialisation des pièces noires
        boxes[7][0] = new Spot(7, 0, new Rook(true,"rook_w.png"));
        boxes[7][1] = new Spot(7, 1, new Knight(true,"knight_w.png"));
        boxes[7][2] = new Spot(7, 2, new Bishop(true,"bishop_w.png"));
        boxes[7][3] = new Spot(7, 3, new Queen(true,"queen_w.png"));
        boxes[7][4] = new Spot(7, 4, new King(true,"king_w.png"));
        boxes[7][5] = new Spot(7, 5, new Bishop(true,"bishop_w.png"));
        boxes[7][6] = new Spot(7, 6, new Knight(true,"knight_w.png"));
        boxes[7][7] = new Spot(7, 7, new Rook(true,"rook_w.png"));

        //initialisation des cases sans pièces
        for(int i=2;i<6;i++){
            for(int j=0;j<8;j++){
                boxes[i][j] = new Spot(i, j, null);
            }
        }
    }
    
    public boolean isSpotUnderAttack(Spot spot, boolean whiteAttacking){
        //Vérifie si une pièce adverse peut attaquer la case donnée
        for(int i=0;i<8;i++){
            for(int j=0;j<8;j++){
                Spot attackerSpot = this.getBox(i, j);
                Piece attackerPiece = attackerSpot.getPiece();
                if(attackerPiece != null && attackerPiece.isWhite() != whiteAttacking){
                    //Vérifie si la pièce adverse peut attaquer la case donnée
                    if(attackerPiece.canMove(this, attackerSpot, spot)){
                        return true;
                    }
                }
            }
        }
        
        return false;
    }
}
