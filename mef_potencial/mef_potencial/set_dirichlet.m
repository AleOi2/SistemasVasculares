### Esta função é responsável por, dados:
#     A: matriz global
#     b: vetor forçante
#     node: índice do nó em que a condição de Dirichlet deve ser imposta
#     value: valor da condição de Dirichlet para este nó
#   impor a condição de Dirichlet na a matriz global "A" e no vetor forçante "b"

# Delta = [3, 100] # node, value

# A = [25,     0,  0,   0, -25;
#       0, 38.33,  0,   0, -25;
#       0,     0,  1,   0,   0;
#       0,     0,  0,  25, -25;
#     -25,   -25,  0, -25, 100];

# b = b - (A(:,node)')*value;

function [A, b] = set_dirichlet (A, b, node, value)
  # checar se o valor de node é válido
  if node > length(A)
    printf ("Erro: Indice indicado para o nó excede os índices da matriz.")
  else
    # cria uma linha de zeros, com 1 no local de índice node
    z = zeros(1, length(A));
    z(node) = 1;
    # escalona o vetor b para zerar a coluna de índice node
    b = b - (A(:,node)')*value;
    # transforma a linha e a coluna em zeros, com 1 apenas no local [node, node]
    A(node,:) = z;
    A(:,node) = z';
    # o valor de índice node do vetor forçante é value
    b(node) = value;
  endif
 endfunction