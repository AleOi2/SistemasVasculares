### Esta fun��o � respons�vel por, dados:
#     A: matriz global
#     b: vetor for�ante
#     node: �ndice do n� em que a condi��o de Dirichlet deve ser imposta
#     value: valor da condi��o de Dirichlet para este n�
#   impor a condi��o de Dirichlet na a matriz global "A" e no vetor for�ante "b"

# Delta = [3, 100] # node, value

# A = [25,     0,  0,   0, -25;
#       0, 38.33,  0,   0, -25;
#       0,     0,  1,   0,   0;
#       0,     0,  0,  25, -25;
#     -25,   -25,  0, -25, 100];

# b = b - (A(:,node)')*value;

function [A, b] = set_dirichlet (A, b, node, value)
  # checar se o valor de node � v�lido
  if node > length(A)
    printf ("Erro: Indice indicado para o n� excede os �ndices da matriz.")
  else
    # cria uma linha de zeros, com 1 no local de �ndice node
    z = zeros(1, length(A));
    z(node) = 1;
    # escalona o vetor b para zerar a coluna de �ndice node
    b = b - (A(:,node)')*value;
    # transforma a linha e a coluna em zeros, com 1 apenas no local [node, node]
    A(node,:) = z;
    A(:,node) = z';
    # o valor de �ndice node do vetor for�ante � value
    b(node) = value;
  endif
 endfunction