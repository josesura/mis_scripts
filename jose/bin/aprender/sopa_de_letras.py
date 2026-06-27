import random
def crear_sopa_de_letras(palabras, tamano=15):

  # Crear una matriz vacía
  sopa = [[' ' for _ in range(tamano)] for _ in range(tamano)]

  # Función para colocar una palabra en la sopa
  def colocar_palabra(palabra):
    direcciones = [
                  (1, 0),   # Horizontal derecha
                  (-1, 0),  # Horizontal izquierda
                  (0, 1),   # Vertical abajo
                  (0, -1),  # Vertical arriba
                  (1, 1),   # Diagonal abajo-derecha
                  (1, -1),  # Diagonal arriba-derecha
                  (-1, 1),  # Diagonal abajo-izquierda
                  (-1, -1)  # Diagonal arriba-izquierda
                ]
    for _ in range(100):  # Intentar 100 veces colocar la palabra
      x, y = random.randint(0, tamano-1), random.randint(0, tamano-1)
      dx, dy = random.choice(direcciones)
      if all(0 <= x + i*dx < tamano and 0 <= y + i*dy < tamano and (sopa[x + i*dx][y + i*dy] == ' ' or sopa[x + i*dx][y + i*dy] == palabra[i]) for i in range(len(palabra))):
        for i in range(len(palabra)):
          sopa[x + i*dx][y + i*dy] = palabra[i]
          return True
        return False

      # Colocar cada palabra en la sopa
      for palabra in palabras:
               colocar_palabra(palabra)
      # Rellenar los espacios vacíos con letras aleatorias
      for i in range(tamano):
        for j in range(tamano):
          if sopa[i][j] == ' ':
            sopa[i][j] = random.choice('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
      return sopa

def imprimir_sopa_de_letras(sopa):
  for fila in sopa:
    print(' '.join(fila))
    
# Palabras a incluir en la sopa de letras
palabras = ["PERRO", "GATO", "PÁJARO", "PEZ", "TIGRE"]

# Crear la sopa de letrassopa =
sopa=crear_sopa_de_letras(palabras)

# Imprimir la sopa de letras
imprimir_sopa_de_letras(sopa)
