import geomerative.*;
boolean TypoManager_isGeomerativeInit = false;
class TypoManager {
 // programme parent
 PApplet applet;

 // Variable qui va stocker notre fonte TTF
 RFont fonte;

 // Forme du texte
 RShape forme;

 // Liste des points & tangentes
 PVector[] listePoints;
 PVector[] listeTangentes;
 float[] listeTangentesAngle;

 // Liste des points par forme
 PVector[][] listePointsShape;

// Constructeur de la typoManager
 TypoManager(PApplet applet_, String fontName_, String texte, float segmentLength, float positionX, float positionY) {
  this.applet = applet_;
  if (TypoManager_isGeomerativeInit == false) {
   TypoManager_isGeomerativeInit = true;
   RG.init(applet);
  }
  
  //Déclaration de la font
  fonte = new RFont(fontName_, 200, RFont.CENTER);
  RCommand.setSegmentLength(segmentLength);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  //Transformation de la font en forme
  forme = fonte.toShape(texte);
  forme = RG.centerIn(forme, applet.g, 100);

  //Récupération des points de la forme
  RPoint[] points = forme.getPoints();
  
  //La taille du vecteur est égale la longueur du tableau de points de ma forme
  listePoints = new PVector[points.length];
  
   int ratioPolice = 5;
   int border = 75;
  
 
  for (int i = 0; i < points.length; i++) {
   // J'utilise la cardinalité x et y des point de la forme générée
   float x = (points[i].x + positionX) / ratioPolice + positionX + border;
   float y = (points[i].y + positionY) / ratioPolice + positionY + border;
   listePoints[i] = new PVector(x,y);
  }

  listeTangentes = new PVector[points.length];
  listeTangentesAngle = new float[points.length];
  for (int i = 0; i < listeTangentes.length; i++) {
   PVector A = listePoints[i];
   PVector B = listePoints[(i + 1) % listePoints.length];

   listeTangentes[i] = new PVector(B.x - A.x, B.y - A.y);
   listeTangentes[i].normalize();

   listeTangentesAngle[i] = atan2(listeTangentes[i].x, listeTangentes[i].y);
  }


  RPoint[][] pointsShape = forme.getPointsInPaths();
  RPoint p, t;

  listePointsShape = new PVector[pointsShape.length][];

  for (int i = 0; i < pointsShape.length; i++) {
   listePointsShape[i] = new PVector[pointsShape[i].length];
   for (int j = 0; j < pointsShape[i].length; j++) {
     // cf ligne 49
    float x = (pointsShape[i][j].x + positionX) / ratioPolice + positionX + border;
    float y = (pointsShape[i][j].y + positionY) / ratioPolice + positionY + border;
    listePointsShape[i][j] = new PVector(x, y);
   }
  }
 }

 // ------------------------------------------------------------------------------------------------
 int getNumPoints() {
  return listePoints.length;
 }

 // ------------------------------------------------------------------------------------------------
 PVector getPoint(int i) {
  return listePoints[i];
 }

 // ------------------------------------------------------------------------------------------------
 PVector getTangent(int i) {
  return listeTangentes[i];
 }

 // ------------------------------------------------------------------------------------------------
 float getAngleAtPoint(int i) {
  return listeTangentesAngle[i];
 }

 // ------------------------------------------------------------------------------------------------
 int shapesNb() {
  return listePointsShape.length;
 }

 // ------------------------------------------------------------------------------------------------
 PVector[] shape(int i) {
  if (i < shapesNb())
   return listePointsShape[i];
  return null;
 }

 // ------------------------------------------------------------------------------------------------
 void drawPoints() {
  for (int i = 0; i < listePoints.length; i++) {
   ellipse(listePoints[i].x, listePoints[i].y, 5, 5);
  }
 }

 // ------------------------------------------------------------------------------------------------
 void drawTangents(float l) {
  stroke(200, 0, 0);
  PVector P, T;
  for (int i = 0; i < listePoints.length; i++) {
   P = listePoints[i];
   T = listeTangentes[i];
   line(P.x, P.y, P.x + l * T.x, P.y + l * T.y);
  }
 }

 // ------------------------------------------------------------------------------------------------
 void drawShapes(color c) {
  PVector p;
  int i, j;
  for (i = 0; i < listePointsShape.length; i++) {
   fill(c);
   beginShape();
   for (j = 0; j < listePointsShape[i].length; j++) {
    p = listePointsShape[i][j];
    vertex(p.x, p.y);
   }

   vertex(listePointsShape[i][0].x, listePointsShape[i][0].y);

   endShape();
  }
 }
}