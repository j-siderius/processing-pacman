/*

 Pacman lookalike
 Jannick Siderius
 20 november 2021
 gemaakt in 42 minuten
 
 */

// legenda: 0=nothing, 1=wall
int playingField[][] = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1}, 
  {1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1}, 
  {1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

// colors
color white = color(255, 255, 255);
color black = color(0, 0, 0);
color yellow = color(255, 255, 0);
color blue = color(33, 33, 222);
color red = color(255, 0, 0);

// objects
Player player;
Ghost ghost;

// game variables
boolean gameRun;
int gameSpeed = 5;
int _tickRate;
long prevMillis;
int maxScore;
int score;
int blockHeight = 20;


void setup() {
  // setup the windom and game variables
  size(400, 160);
  _tickRate = 1000/gameSpeed;
  prevMillis = 0;
  gameRun = true;
  score = 0;
  noStroke();

  // initialize the player
  player = new Player(18, 1, 'S');

  //initialize the ghost
  ghost = new Ghost(1, 5, 'N');

  // initialize the field
  for (int y = 0; y < 7; y++) {
    for (int x = 0; x < 20; x++) {
      if (playingField[y][x] == 0) {
        playingField[y][x] = 2;
        maxScore++;
      }
    }
  }
}


void draw() {
  clear();

  // draw the playing field
  for (int y = 0; y < 7; y++) {
    for (int x = 0; x < 20; x++) {
      if (playingField[y][x] == 0) { // nothing
        fill(black);
        rect(x*blockHeight, y*blockHeight, blockHeight, blockHeight);
      } else if (playingField[y][x] == 1) { // wall
        fill(blue);
        rect(x*blockHeight, y*blockHeight, blockHeight, blockHeight, 3);
      } else if (playingField[y][x] == 2) { // coin
        fill(black);
        rect(x*blockHeight, y*blockHeight, blockHeight, blockHeight);
        fill(white);
        circle(x*blockHeight + blockHeight/2, y*blockHeight + blockHeight/2, blockHeight*0.3);
      }
    }
  }

  // draw player
  player.render();

  // draw ghost
  ghost.render();

  // draw text
  fill(white);
  textSize(16);
  text("Score: " + score, 5, 155);
  text("Control: WASD", 283, 155);

  // check if player won
  if (score >= maxScore) {
    gameRun = false;
    fill(yellow);
    textSize(20);
    text("You won!", 150, 157);
  } else if (player.getX() == ghost.getX() && player.getY() == ghost.getY()) {
    gameRun = false;
    fill(red);
    textSize(20);
    text("You lost!", 150, 157);
  }

  // only move the player and ghost at fixed intervals
  if (millis() > prevMillis + _tickRate && gameRun) {
    prevMillis = millis();

    // update player movement
    player.update();

    // update ghost
    ghost.update();

    // check if player collected coins
    if (playingField[player.getY()][player.getX()] == 2) {
      score++;
      playingField[player.getY()][player.getX()] = 0;
    }
}


void keyPressed() {
  if (key == ESC) exit();

  // if a key is pressed, send it to the player controller
  player.changeDirection(key);
}
