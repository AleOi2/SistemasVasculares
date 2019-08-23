### Esta função é responsável por, dados:
#     b: vetor forçante
#     node: índice do nó em que a condição de Dirichlet deve ser imposta
#     value: valor da condição de Dirichlet para este nó
#   impor a condição de Neumann no vetor forçante "b"
 function [b] = set_neumann (b, node, value)
  # checa se o valor de node é válido
  if (node > length(b))
    printf ("Erro: Indice indicado para o nó excede os índices da matriz.")
  else
    # troca o valor de b no índice node para "value"
    b(node) = value;
  endif
 endfunction