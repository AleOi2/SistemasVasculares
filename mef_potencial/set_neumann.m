### Esta fun��o � respons�vel por, dados:
#     b: vetor for�ante
#     node: �ndice do n� em que a condi��o de Dirichlet deve ser imposta
#     value: valor da condi��o de Dirichlet para este n�
#   impor a condi��o de Neumann no vetor for�ante "b"
 function [b] = set_neumann (b, node, value)
  # checa se o valor de node � v�lido
  if (node > length(b))
    printf ("Erro: Indice indicado para o n� excede os �ndices da matriz.")
  else
    # troca o valor de b no �ndice node para "value"
    b(node) = value;
  endif
 endfunction