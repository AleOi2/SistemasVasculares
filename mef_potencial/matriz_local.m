% Função que calcula a matriz local de um elemento com 4 nós.
% Tem como entrada 4 vetores linha, da forma: no1 = [x y z] e condutividade[kxx kyy kzz].
% A função tem como saída a matriz local do elemento vetorizada (dimensão 1x16).
function ML = matriz_local(no1, no2, no3, no4, condutividade)


%%%%%%%% calculo do volume %%%%%%%%  
  V = [1 no1;1 no2;1 no3;1 no4];
  v = (1/6) * det(V);

  
%%%%%%%% Coeficientes dos polinomios de interpolacao %%%%%%%%

  %definicao dos betas
    
    beta1 = -det([1 no2(2) no2(3);
                  1 no3(2) no3(3);
                  1 no4(2) no4(3)]);
    beta2 = det([1 no1(2) no1(3);
                 1 no3(2) no3(3);
                 1 no4(2) no4(3)]);
    beta3 = -det([1 no1(2) no1(3);
                  1 no2(2) no2(3);
                  1 no4(2) no4(3)]);
    beta4 = det([1 no1(2) no1(3);
                 1 no2(2) no2(3);
                 1 no3(2) no3(3)]);

  %definicao dos gamas
    
    gama1 = det([1 no2(1) no2(3);
                 1 no3(1) no3(3);
                 1 no4(1) no4(3)]);
    gama2 = -det([1 no1(1) no1(3);
                  1 no3(1) no3(3);
                  1 no4(1) no4(3)]);
    gama3 = det([1 no1(1) no1(3);
                 1 no2(1) no2(3);
                 1 no4(1) no4(3)]);
    gama4 = -det([1 no1(1) no1(3);
                  1 no2(1) no2(3);
                  1 no3(1) no3(3)]);

  %definicao dos deltas
    
    delta1 = -det([1 no2(1) no2(2);
                   1 no3(1) no3(2);
                   1 no4(1) no4(2)]);
    delta2 = det([1 no1(1) no1(2);
                  1 no3(1) no3(2);
                  1 no4(1) no4(2)]);
    delta3 = -det([1 no1(1) no1(2);
                   1 no2(1) no2(2);
                   1 no4(1) no4(2)]);
    delta4 = det([1 no1(1) no1(2);
                  1 no2(1) no2(2);
                  1 no3(1) no3(2)]);

    
%%%%%%%% Montagem da Matriz B %%%%%%%%
   
   B1 = [beta1;gama1;delta1];
   B2 = [beta2;gama2;delta2];
   B3 = [beta3;gama3;delta3];
   B4 = [beta4;gama4;delta4];
   
   B = [B1 B2 B3 B4];
   
  

  %%%%%%%% Matriz D (Condutividade) %%%%%%%%
  D = [condutividade(1) 0 0;0 condutividade(2) 0;0 0 condutividade(3)];
  

%%%%%%%% Matriz local %%%%%%%%
  K = (B') * D * B /(36*v);
  % Vetorizacao
    ML = reshape(K, [1,16]);

 endfunction
