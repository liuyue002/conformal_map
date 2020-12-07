function newIm = transform (A, f, L, imgsize, domainpixel)
%Transform the image with a complex function
% A: original image, must be square
% f: the complex map (x,y) -> f(x+iy)
% L: domain size [-L,L]^2
% imgsize: the original image tiles [0,imgsize]^2, periodically
% domainpixel: how many pixels the whole transformed image have

Asize = size(A,1);
nx=domainpixel;
dx=2*L/(nx-1);
x=-L:dx:L;
y=-L:dx:L;
[X,Y]=meshgrid(x,y);
newIm = zeros(nx,nx,3,'uint8');

transf = f(X,Y);
R = min(round(mod(real(transf),imgsize)*(Asize/imgsize))+1,Asize);
I = min(round(mod(imag(transf),imgsize)*(Asize/imgsize))+1,Asize);

for layer = 1:3
    ind = sub2ind(size(A),R,I,layer*ones(size(R)));
    newIm(:,:,layer) = A(ind);
end
end