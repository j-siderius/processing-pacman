class Player {
  // player variables
  int playerX, playerY;
  char playerDirection;

  // player contructor
  Player(int x, int y, char dir) {
    playerX = x;
    playerY = y;
    playerDirection = dir;
  }

  // renders the player
  void render() {
    fill(yellow);
    circle(playerX*blockHeight + blockHeight/2, playerY*blockHeight + blockHeight/2, blockHeight * 0.8);
  }

  // changes player parameters
  void update() {
    // player movement
    if (playerDirection == 'N' && playingField[playerY-1][playerX] != 1) playerY -= 1;
    else if (playerDirection == 'S' && playingField[playerY+1][playerX] != 1) playerY += 1;
    else if (playerDirection == 'W' && playingField[playerY][playerX-1] != 1) playerX -= 1;
    else if (playerDirection == 'E' && playingField[playerY][playerX+1] != 1) playerX += 1;
  }

  // changes the direction, called by keypress
  void changeDirection(char desiredDir) {
    if (desiredDir == 'W' || desiredDir == 'w' && playingField[playerY-1][playerX] != 1) playerDirection = 'N';
    else if (desiredDir == 'S' || desiredDir == 's' && playingField[playerY+1][playerX] != 1) playerDirection = 'S';
    else if (desiredDir == 'A' || desiredDir == 'a' && playingField[playerY][playerX-1] != 1) playerDirection = 'W';
    else if (desiredDir == 'D' || desiredDir == 'd' && playingField[playerY][playerX+1] != 1) playerDirection = 'E';
  }

  // return the player position
  int getX() {
    return playerX;
  }

  int getY() {
    return playerY;
  }
}
