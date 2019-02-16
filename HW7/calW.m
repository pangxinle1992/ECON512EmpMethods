%%this function takes in sales dummy of two players and value function, and calculate the
%%continuation vlaue under each sales cases

function [W0,W1,W2]=calW(V)

global L prob00 prob10 prob01;


VV=reshape(V', [1,L*L]);
VV=repmat(VV, L*L, 1);

W0=reshape(sum(VV.*prob00,2),[L,L]);
W1=reshape(sum(VV.*prob10,2),[L,L]);
W2=reshape(sum(VV.*prob01,2),[L,L]);

end