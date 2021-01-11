addpath('..');
f=@(x,y) cos(x+1i*y);
fname = 'cos(z)';
transform_image(f,fname);
f=@(x,y) sin(x+1i*y);
fname = 'sin(z)';
transform_image(f,fname);
f=@(x,y) log(x+1i*y);
fname = 'log(z)';
transform_image(f,fname);
f=@(x,y) exp(x+1i*y);
fname = 'exp(z)';
transform_image(f,fname);
f=@(x,y) (x+1i*y).^2;
fname = 'z^2';
transform_image(f,fname);
f=@(x,y) (x+1i*y).^3;
fname = 'z^3';
transform_image(f,fname);
f=@(x,y) (x+1i*y).^4;
fname = 'z^4';
transform_image(f,fname);
f=@(x,y) 1./(x+1i*y);
fname = 'z^{-1}';
transform_image(f,fname);
f=@(x,y) 1./((x+1i*y).^2-1);
fname = '(z^2-1)^{-1}';
transform_image(f,fname);

f=@(x,y) x-1i*y;
fname = 'z_comp';
transform_image(f,fname);
f=@(x,y) tan(x+1i*y);
fname = 'tan(z)';
transform_image(f,fname);
f=@(x,y) exp(-x-1i*y);
fname = 'exp(-z)';
transform_image(f,fname);
f=@(x,y) exp(1./(x+1i*y));
fname = 'exp(z^{-1})';
transform_image(f,fname);
f=@(x,y) 1./(x+1i*y) +(x+1i*y);
fname = 'exp(z+z^{-1})';
transform_image(f,fname);

f=@(x,y) 1./(exp(1./(x+1i*y))+2);
fname = '(exp(z^{-1})+2)^{-1}';
transform_image(f,fname);

f=@(x,y) 1./(x+1i*y+1i);
fname = '1÷(z+i)';
transform_image(f,fname);
f=@(x,y) (x+1i*y - 1i)./(x+1i*y + 1i);
fname = '(z-i)÷(z+i)';
transform_image(f,fname);
f=@(x,y) ((x+1i*y).^2 -1)./((x+1i*y).^2 + 1);
fname = '(z^2-1)÷(z^2+1)';
transform_image(f,fname);