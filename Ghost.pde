class Ghost {
  // ghost variables
  int ghostX, ghostY;
  char ghostDirection;
  char possibleDirections[] = {'N', 'S', 'W', 'E'};

  // ghost constructor
  Ghost(int x, int y, char dir) {
    ghostX = x;
    ghostY = y;
    ghostDirection = dir;
  }

  // renders the ghost
  void render() {
    // draw ghost
    fill(red);
    rect(ghostX*blockHeight + blockHeight*0.1, ghostY*blockHeight + blockHeight*0.1, blockHeight-blockHeight*0.2, blockHeight-blockHeight*0.2, 2);
  }

  // changes ghost parameters
  void update() {
    // ghost movement
    if (ghostDirection == 'N') {
      if (playingField[ghostY-1][ghostX] != 1) ghostY -= 1;
      else ghostDirection = possibleDirections[int(random(4))];
    } else if (ghostDirection == 'S') {
      if (playingField[ghostY+1][ghostX] != 1) ghostY += 1;
      else ghostDirection = possibleDirections[int(random(4))];
    } else if (ghostDirection == 'W') {
      if (playingField[ghostY][ghostX-1] != 1) ghostX -= 1;
      else ghostDirection = possibleDirections[int(random(4))];
    } else if (ghostDirection == 'N') {
      if (playingField[ghostY][ghostX+1] != 1) ghostX += 1;
      else ghostDirection = possibleDirections[int(random(4))];
    }
  }

  // returns ghost position
  int getX() {
    return ghostX;
  }

  int getY() {
    return ghostY;
  }
}
