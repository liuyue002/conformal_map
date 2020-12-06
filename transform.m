function newIm = transform (A, f, L)

% original image represent x, y in [0,1]
%f=@(x,y) cos(x+1i*y);
dx=1/(size(A,1)-1);
nx=2*L/dx+1;
x=-L:dx:L;
y=-L:dx:L;
[X,Y]=meshgrid(x,y);
newIm = zeros(nx,nx,3,'uint8');

transf = f(X,Y);
R = min(round(mod(real(transf),1)*(1/dx))+1,(1/dx)+1);
I = min(round(mod(imag(transf),1)*(1/dx))+1,(1/dx)+1);

for layer = 1:3
    ind = sub2ind(size(A),R,I,layer*ones(size(R)));
    newIm(:,:,layer) = A(ind);
end
end