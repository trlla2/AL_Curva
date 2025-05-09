// Una curva de grado 3 (cúbica)
// Paramétrica y polinómica
// Voy a utilizar una clase

// Variables y objetos
curva mi_primera_curva;
curva mi_segunda_curva;
curva mi_tercera_curva;
curva mi_quarta_curva;

boolean isBezier = false;

PVector PNJ;
int estado_PNJ = 1; // 1 p(u), 2 q(u), 3 w(u), 4 k(u)
float u_PNJ = 0.0f; // parametro u

// Clases
class curva{
  // Atributos
  PVector[] puntos_de_ctrl;
  PVector[] coefs;
  // Constructor
  curva(PVector[] p){
    // Reservamos memoria
    puntos_de_ctrl = new PVector[4];
    coefs = new PVector[4];
    // Inicializamos
    for(int i=0;i<4;i++){
      puntos_de_ctrl[i]=new PVector(0.0,0.0);
      coefs[i]=new PVector(0.0,0.0);
      // Copiamos los puntos recibidos
      puntos_de_ctrl[i]=p[i];
    }
  }
  // Metodos
  void calcular_coefs_inerpolacio(){
    // Utilizando la matriz de interpolacion
    // que son 4 ecuaciones ... calculamos las Cs
    //  equacion para cada posicion(x,y)
    //C0 = P0;
    coefs[0].x = puntos_de_ctrl[0].x;
    coefs[0].y = puntos_de_ctrl[0].y;
    //C1 = -5.5P0+0P1+4.5P2+P3
    coefs[1].x = -5.5*puntos_de_ctrl[0].x + 9.0 * puntos_de_ctrl[1].x -4.5* puntos_de_ctrl[2].x + puntos_de_ctrl[3].x;
    coefs[1].y = -5.5*puntos_de_ctrl[0].y + 9.0 * puntos_de_ctrl[1].y -4.5* puntos_de_ctrl[2].y + puntos_de_ctrl[3].y;
    //C2 =  9P0 -22.5P1 + 18P2 -4.5P3
    coefs[2].x = 9*puntos_de_ctrl[0].x - 22.5*puntos_de_ctrl[1].x + 18*puntos_de_ctrl[2].x -4.5*puntos_de_ctrl[3].x;
    coefs[2].y = 9*puntos_de_ctrl[0].y - 22.5*puntos_de_ctrl[1].y + 18*puntos_de_ctrl[2].y -4.5*puntos_de_ctrl[3].y;
    //C3 = -4.5P0+ 13.5P1 -13.5P2 +4.5P3
    coefs[3].x = -4.5*puntos_de_ctrl[0].x + 13.5*puntos_de_ctrl[1].x - 13.5*puntos_de_ctrl[2].x + 4.5*puntos_de_ctrl[3].x;
    coefs[3].y = -4.5*puntos_de_ctrl[0].y + 13.5*puntos_de_ctrl[1].y - 13.5*puntos_de_ctrl[2].y + 4.5*puntos_de_ctrl[3].y;

  }
  
  void calcular_coefs_bezier(){
    //C0 = P0;
    coefs[0].x = puntos_de_ctrl[0].x;
    coefs[0].y = puntos_de_ctrl[0].y;
    //C1 = -3P0+3P1
    coefs[1].x = -3*puntos_de_ctrl[0].x + 3 * puntos_de_ctrl[1].x;
    coefs[1].y = -3*puntos_de_ctrl[0].y + 3 * puntos_de_ctrl[1].y;
    //C2 =  3P0 -6P1 + 3P2 
    coefs[2].x = 3*puntos_de_ctrl[0].x - 6*puntos_de_ctrl[1].x + 3*puntos_de_ctrl[2].x;
    coefs[2].y = 3*puntos_de_ctrl[0].y - 6*puntos_de_ctrl[1].y + 3*puntos_de_ctrl[2].y;
    //C3 = -P0 + 3P1 -3P2 + P3
    coefs[3].x = -1*puntos_de_ctrl[0].x + 3*puntos_de_ctrl[1].x - 3*puntos_de_ctrl[2].x + puntos_de_ctrl[3].x;
    coefs[3].y = -1*puntos_de_ctrl[0].y + 3*puntos_de_ctrl[1].y - 3*puntos_de_ctrl[2].y + puntos_de_ctrl[3].y;
  }
  
  void pintar_puntos_control(){
    strokeWeight(15.0);
    stroke(255,0,0);
    for(int i =0; i<4;i++){
      point(puntos_de_ctrl[i].x,puntos_de_ctrl[i].y);
    }
  }
  
  void pintar_curva(){
    float x,y;
    // Pintara los puntos de control
    // Tambien pintara a la curva
    // Podemos emplear puntos para hacerlo
    // Caracteristicas de pintado
    strokeWeight(5); // 5 pixeles de grueso para los puntos
    stroke(255,255,0); // Curva de color amarillo
    for(float inc_u=0.0;inc_u<1.0;inc_u+=0.01){ // 100 vueltas
      // Calcular X
      x = coefs[0].x + coefs[1].x * inc_u +
      coefs[2].x * inc_u * inc_u +
      coefs[3].x * inc_u * inc_u * inc_u;
      // Calcular Y
      y = coefs[0].y + coefs[1].y * inc_u +
      coefs[2].y * inc_u * inc_u +
      coefs[3].y * inc_u * inc_u * inc_u;
      // Pintar un "puntito" en esa coord XYZ
      point(x,y);
    }
  }
}

// Funciones
//posicionar pnj
void calcula_nueva_posicion_pnj(){
  // segun el estado se mueve por una curva o otra
  // segun el parametro U cambiamos curva
  
  if(estado_PNJ == 1){ // p(u)
    PNJ.x = mi_primera_curva.coefs[0].x + mi_primera_curva.coefs[1].x * u_PNJ +
      mi_primera_curva.coefs[2].x * u_PNJ * u_PNJ +
      mi_primera_curva.coefs[3].x * u_PNJ * u_PNJ * u_PNJ;
    PNJ.y = mi_primera_curva.coefs[0].y + mi_primera_curva.coefs[1].y * u_PNJ +
      mi_primera_curva.coefs[2].y * u_PNJ * u_PNJ +
      mi_primera_curva.coefs[3].y * u_PNJ * u_PNJ * u_PNJ;
  }
  else if(estado_PNJ == 2){// q(u)
    PNJ.x = mi_segunda_curva.coefs[0].x + mi_segunda_curva.coefs[1].x * u_PNJ +
      mi_segunda_curva.coefs[2].x * u_PNJ * u_PNJ +
      mi_segunda_curva.coefs[3].x * u_PNJ * u_PNJ * u_PNJ;
    PNJ.y = mi_segunda_curva.coefs[0].y + mi_segunda_curva.coefs[1].y * u_PNJ +
      mi_segunda_curva.coefs[2].y * u_PNJ * u_PNJ +
      mi_segunda_curva.coefs[3].y * u_PNJ * u_PNJ * u_PNJ;
  }
  else if(estado_PNJ == 3){// w(u)
    PNJ.x = mi_tercera_curva.coefs[0].x + mi_tercera_curva.coefs[1].x * u_PNJ +
      mi_tercera_curva.coefs[2].x * u_PNJ * u_PNJ +
      mi_tercera_curva.coefs[3].x * u_PNJ * u_PNJ * u_PNJ;
    PNJ.y = mi_tercera_curva.coefs[0].y + mi_tercera_curva.coefs[1].y * u_PNJ +
      mi_tercera_curva.coefs[2].y * u_PNJ * u_PNJ +
      mi_tercera_curva.coefs[3].y * u_PNJ * u_PNJ * u_PNJ;
  }
  else {// k(u)
    PNJ.x = mi_quarta_curva.coefs[0].x + mi_quarta_curva.coefs[1].x * u_PNJ +
      mi_quarta_curva.coefs[2].x * u_PNJ * u_PNJ +
      mi_quarta_curva.coefs[3].x * u_PNJ * u_PNJ * u_PNJ;
    PNJ.y = mi_quarta_curva.coefs[0].y + mi_quarta_curva.coefs[1].y * u_PNJ +
      mi_quarta_curva.coefs[2].y * u_PNJ * u_PNJ +
      mi_quarta_curva.coefs[3].y * u_PNJ * u_PNJ * u_PNJ;
  }
  
  u_PNJ += 0.01;
  if(u_PNJ >= 1){
    estado_PNJ ++;
    u_PNJ = 0;
    if(estado_PNJ >= 5)// curvas{
      estado_PNJ = 1; // curva p
  }
}

// pintarlo
void pinta_pnj(){
  strokeWeight(35);
  stroke(0,255,0);
  point(PNJ.x,PNJ.y);
}

// El Setup crea la curva
void setup(){
  PVector p[], q[], w[], k[];

  // Ventana
  size(800,600);
  
  // Curva
  // Inventarnos 1 curva p ->(u)
  // Invertarnos sus puntos de control
  p = new PVector[4];
  p[0] = new PVector(200,100); // P0
  p[1] = new PVector(300,125); // P1
  p[2] = new PVector(400,50); // El P2
  p[3] = new PVector(500,150); // P3
  
  // Inventarnos 2 curva q -> (u)
  q = new PVector[4];
  q[0] = new PVector(500,150); //  P0 tiene que ser el mismo punto el ultimo de la curva anterior
  q[1] = new PVector(600,250); //  P1
  q[2] = new PVector(700,350); //  P2
  q[3] = new PVector(650,375); // P3
  
  // Inventarnos 3 curva w -> (u)
  w = new PVector[4];
  w[0] = new PVector(650,375); //  P0 tiene que ser el mismo punto el ultimo de la curva anterior
  w[1] = new PVector(375,250); //  P1
  w[2] = new PVector(375,300); //  P2
  w[3] = new PVector(275,300); // P3
  
  // Inventarnos 4 curva k -> (u)
  k = new PVector[4];
  k[0] = new PVector(275,300); //  P0 tiene que ser el mismo punto el ultimo de la curva anterior
  k[1] = new PVector(200,200); //  P1
  k[2] = new PVector(150,150); //  P2
  k[3] = new PVector(200,100); // P3 tiene que ser el mismo que el primer punto de la primera curva
  
  // Llamamos al constructor de la curva
  mi_primera_curva = new curva(p);
  mi_segunda_curva = new curva(q);
  mi_tercera_curva = new curva(w);
  mi_quarta_curva = new curva(k);
  // Calculamos sus coeficientes
  if(!isBezier){
    mi_primera_curva.calcular_coefs_inerpolacio();
    mi_segunda_curva.calcular_coefs_inerpolacio();
    mi_tercera_curva.calcular_coefs_inerpolacio();
    mi_quarta_curva.calcular_coefs_inerpolacio();
  }
  else{
    mi_primera_curva.calcular_coefs_bezier();
    mi_segunda_curva.calcular_coefs_bezier();
    mi_tercera_curva.calcular_coefs_bezier();
    mi_quarta_curva.calcular_coefs_bezier();
  }
  // ---------------- PNJ
  PNJ = new PVector(0.0,0.0);
  
}

// El draw pinta la curva
void draw(){
  background(0);
  // Curva
  mi_primera_curva.pintar_curva();
  mi_primera_curva.pintar_puntos_control();
  
  mi_segunda_curva.pintar_curva();
  mi_segunda_curva.pintar_puntos_control();
  
  mi_tercera_curva.pintar_curva();
  mi_tercera_curva.pintar_puntos_control();
  
  mi_quarta_curva.pintar_curva();
  mi_quarta_curva.pintar_puntos_control();
  
   // ---------------- PNJ
   calcula_nueva_posicion_pnj();
   pinta_pnj();
}
