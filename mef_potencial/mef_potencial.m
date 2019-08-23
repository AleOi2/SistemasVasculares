clear all
format short e
#######################################################################
# 1) from a mesh file, it extracts coordinates and topology information
#######################################################################

str_aux="";
n_elem = 0
search_for_1 = "$Nodes";
search_for_2 = "$Elements";
mesh_file="dois_tetraedros_media.msh";


#leitura do arquivo .msh para extracao da matriz de coordenadas e topologia
fp = fopen(mesh_file, 'r');

while (! feof (fp) )
  text_line = fgetl (fp);
  if (strncmp(search_for_1,text_line,6))
      str_aux = fgetl (fp);
      n_nodes=str2num(str_aux);
      coords = zeros(n_nodes,4);
      for i=1:n_nodes
         text_line = fgetl (fp); 
         aux=sscanf(text_line,"%lf");
         coords(i,1)=aux(1);
         coords(i,2)=aux(2);
         coords(i,3)=aux(3);
         coords(i,4)=aux(4);
      end
  end
endwhile

coords
fclose(fp);

fp=fopen(mesh_file, 'r')
while (! feof (fp) )
  text_line = fgetl (fp);
  if (strncmp(search_for_2,text_line,6))
      str_aux = fgetl (fp);
      n_elem = str2num(str_aux);
      topo=zeros(n_elem,5);
      for i=1:n_elem
         text_line = fgetl (fp); 
         aux_topo=sscanf(text_line,"%lf");
         n_colunas=aux_topo(3);
         topo(i,1)=aux_topo(1);
         topo(i,2)=aux_topo(1+n_colunas+3);
         topo(i,3)=aux_topo(2+n_colunas+3);
         topo(i,4)=aux_topo(3+n_colunas+3);
         topo(i,5)=aux_topo(4+n_colunas+3);
      end
  end
endwhile
fclose(fp)
topo

#######################################################################
# 2) Calcula as matrizes locais
#######################################################################

ne=n_elem; % numero de elementos
n_local=4; % numero de nohs num tetraedro
n_nohs=n_nodes; % numero de nohs na matriz global

condutividade = [1 1 1];
nlk = zeros(ne,16);

# ********************************************************************        
# Monta cada uma das matrizes locais

for i=1:ne
    nlk(i,:) = matriz_local(coords(topo(i,2),2:4), coords(topo(i,3),2:4), coords(topo(i,4),2:4), coords(topo(i,5),2:4), condutividade);
end

#####################################################################
# 3) Le as condições de contorno
#####################################################################

## Condicoes de Dirichlet
  Delta = load("Dirichlet.dat");
# [n_do_elemento Condição;
#       ...]

## Condicoes de Neumann    
##   fopen (arquivo de Neumann.dat -> para montar matriz N (n_nohs x 1)
# condições de Neumann (nós, valores)
  N = load("Neumann.dat");

#####################################################################
# 4) Monta a matriz global
#####################################################################

# aloca memoria para K_global e vetor forcante b
K_global = zeros(n_nohs,n_nohs);          
b = zeros(1,n_nohs)

for n_elem=1:ne
   for i=1:n_local
      n_linha= topo(n_elem,i+1);

      for j=1:n_local
         n_coluna= topo(n_elem,j+1);
         n_aux=(i-1)*n_local+j; # é o índice da coluna da matriz local
         K_global(n_linha,n_coluna)= K_global(n_linha,n_coluna)+nlk(n_elem,n_aux);
      end
   end

end

########################################################################
# 5) Impoe as condicoes de contorno
########################################################################
# Impoe as condições de Neumann nos nós
n_newman=size(N);
for j = 1:n_newman(1)
    b = set_neumann(b, N(j,1), N(j,2));
endfor

# Checa se as matrizes foram transformadas corretamente


# Impoe as condições de Dirichlet nos nós
for i = 1:size(Delta)(1)
    [K_global,b] = set_dirichlet(K_global,b, Delta(i,1), Delta(i,2));
endfor


K_global
b

#######################################################################
# 6) Resolve o sistema de equacoes
#######################################################################

# *********************************************************************
# Resolve o sistema de equações e imprimir o resultado
T = inv(K_global)*b'

#######################################################################
# 7) Imprime um arquivo para visualizar o resultado
#######################################################################

fp1=fopen("potencial.pos","w"); 
fprintf(fp1,"View \"imagem\" {\n");
for i=1:ne 
  n1=topo(i,2);
  n2=topo(i,3);
  n3=topo(i,4);
  n4=topo(i,5);
  fprintf(fp1,"SS(%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g){%g,%g,%g,%g};\n",coords(n1,2),coords(n1,3),coords(n1,4),coords(n2,2),coords(n2,3),coords(n2,4),coords(n3,2),coords(n3,3),coords(n3,4),coords(n4,2),coords(n4,3),coords(n4,4),T(n1),T(n2),T(n3),T(n4));
end
fprintf(fp1,"};");


fclose(fp1);







