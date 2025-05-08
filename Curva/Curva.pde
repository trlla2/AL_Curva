// Una curva de grado 3 (cúbica)
// Paramétrica y polinómica
// Voy a utilizar una clase

// Variables y objetos
curva mi_primera_curva;

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
  void calcular_coefs(){
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
// El Setup crea la curva
void setup(){
  PVector p[];
  // Ventana
  size(800,600);
  // Inventarnos 1 curva
  // Invertarnos sus puntos de control
  p = new PVector[4];
  p[0] = new PVector(200,200); // Este es el punto de ctrl P0
  p[1] = new PVector(300,300); // Y este es el P1
  p[2] = new PVector(400,200); // El P2
  p[3] = new PVector(500,300); // P3
  // Llamamos al constructor de la curva
  mi_primera_curva = new curva(p);
  // Calculamos sus coeficientes
  mi_primera_curva.calcular_coefs();
}

// El draw pinta la curva
void draw(){
  background(0);
  mi_primera_curva.pintar_curva();
}
