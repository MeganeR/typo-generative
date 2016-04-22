int nb = 70; // variable qui stocke le nb de part.

float[] x = new float[nb];
float[] y = new float[nb];
float[] vx = new float[nb];
float[] vy = new float[nb];


PFont font;

void setup() {
 size(1003, 709);
 font = createFont("MNS_TRIAL.ttf", 100);
 textFont(font);
 background(255);

 for (int i = 0; i < nb; i = i + 1) {
  x[i] = random(0, 1003);
  y[i] = random(0, 709);
  vx[i] = random(-2, 2);
  vy[i] = random(-2, 2);
 }
}

void draw() {
 for (int i = 0; i < nb; i = i + 1) {
  x[i] = x[i] + vx[i];
  y[i] = y[i] + vy[i];
  if (x[i] > 1003) {
   vx[i] = -vx[i];
  }
  if (x[i] < 0) {
   vx[i] = -vx[i];
  }

  if (y[i] > 709) {
   vy[i] = -vy[i];
  }
  if (y[i] < 0) {
   vy[i] = -vy[i];
  }

  ellipse(x[i], y[i], 10, 10);
 }

 stroke(0, 20);
 for (int i = 0; i < nb; i = i + 1) {
  for (int j = i + 1; j < nb; j = j + 1) {
   if (dist(x[i], y[i], x[j], y[j]) < 300) {
    line(x[i], y[i], x[j], y[j]);
   }
  }
 }
 text("a b c d e f g h i", 180, 200);
 text("j k l m n o p q s", 180, 400);
 text("s t u v w x y z ", 180, 600);

}

void keyPressed() {
 if (key == 's') {
  saveFrame("TypoGenerative_Megane Richard_L2Design");
 }
}