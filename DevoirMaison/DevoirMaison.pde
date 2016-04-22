
// Je crée une class comme vous en prenant pour base la votre
class MaTypoManager extends TypoManager {
  
 // J'ai modifié votre classe car je ne suis pas parvenu à modifier la création du tableau que vous effectuer dans votre constructor
 // J'ai rajouté la positionX et positionY qui me permettront de placer ma lettre sur une grille
 MaTypoManager(PApplet applet, String typo, String letter, int taille, float positionX, float positionY) {
  // Je lance votre constructeur
  super(applet, typo, letter, taille, positionX, positionY);
 }

 // Je modifie la fonction drawPoints de votre classe
 void drawPoints() {
  float[] x = new float[listePoints.length];
  float[] y = new float[listePoints.length];
  float[] diam = new float[listePoints.length];
  for (int i = 0; i < listePoints.length; i++) {
   x[i] = listePoints[i].x;
   y[i] = listePoints[i].y;
   diam[i] = 20;
  }
  for (int i = 0; i < listePoints.length; i++) {
   // Cela me permet d'activer l'effet qu'une fois sur 6 car sinon ça fait trop compact
   if (i % 6 == 0) {
    x[i] = x[i] + random(-11, 11);
    y[i] = y[i] + random(-11, 11);
    diam[i] = diam[i] - 0.6;
    if (diam[i] > 0) {
     line(listePoints[i].x, listePoints[i].y, x[i], y[i]);
    }
   }
  }
 }
}

// J'initialise un tableau avec les 26 lettres de l'alphabet
String[] alphab = {
 "a",
 "b",
 "c",
 "d",
 "e",
 "f",
 "g",
 "h",
 "i",
 "j",
 "k",
 "l",
 "m",
 "n",
 "o",
 "p",
 "q",
 "r",
 "s",
 "t",
 "u",
 "v",
 "w",
 "x",
 "y",
 "z"
};

// J'initialise un tableau de mon object dans lequel je vais lettre l'alphabet
MaTypoManager[] typoManagers = new MaTypoManager[alphab.length];

void setup() {
 size(1003, 709);
 // Je met une couleur de fond
 background(6, 139, 87);
 // J'initialise un compteur pour parcourir mon alphabet
 int counter = 0;
 
 // J'initiale mes variables d'espacement
 float espacementHauteur = 150;
 float espacementLargeur = 120;
 
 // Je parcours la hauteur de ma fenetre
 for (int heightSize = 0; heightSize < height; heightSize++) {
  //Je parcours la largeur de ma fenetre
  for (int widthSize = 0; widthSize < width; widthSize++) {
   // Si les valeurs acutelles de largeur et hauteur sont un multiple de leurs espacements et qu'il y a encore des lettres a creer 
   // J'applique aussi une marge à gauche pour qu'il n'affiche pas des lettre en bordure de page car un multiple peux être très près de la bordure
   if (heightSize % espacementHauteur == 0 && widthSize % espacementLargeur == 0 && counter < 26 && widthSize < width - 200) {
    println("create: " + alphab[counter] + " x " + widthSize + " y " + heightSize);
    // Je créer un object MaTypoManager qu'il est une simple copie du votre avec un comportement modifié pour la fonction drawPoint
    typoManagers[counter] = new MaTypoManager(this, "BebasNeue Bold.ttf", alphab[counter], 5, widthSize, heightSize);
    counter++;
   }
  }
 }



}

// J'initialise une variable pour arreter le loop du draw
int i = 0;

void draw() {
 stroke(random(3));
 fill(6, 139, 87);

 //Je parcours la liste de mon objet pour dessiner les points avec ma méthode qui modifie le comportement de votre objet TypoManager.
 for (int j = 0; j < typoManagers.length; j++) {
   //Dans le but de stopper le loop
  if (i < 300) {
   typoManagers[j].drawPoints();
  }
  i++;
 }
}

void keyPressed() {
 if (key == 's') {
  saveFrame("TypoGenerative_Megane Richard_L2Design.");
 }
}
 