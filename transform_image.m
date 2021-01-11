function fig=transform_image(f,fname)
%Transform an image with a complex function, shown as an animation
%strictly speaking this is actually the transformation under the inverse of f
% f: a function handle for the complex function
% fname: name of the function to be used for file names and title

close all;
%% options
showfig=1; % whether to add axis and title
L=5; % the domain is [-L,L]^2
%the image is placed at [0,tilesize]^2, and tiles the plane periodically
tilesize=1; % recommend: 1 or L
domainpixel=1001; % width/height of the tiled image in pixels

% the image to be used need to be cropped to a square
A = imread('sthughs_crop.jpg'); 
A = A(1:1:1000,1:1:1000,:);
%A = imread('peppers.png'); 
%A = A(100:2:300,100:2:300,:); 

%% original image
% figorig=figure;
% imshow(A);
% title('Original Image','FontSize',14);
for layer = 1:3
    A(:,:,layer) = A(:,:,layer)';
end
[~,cm] = rgb2ind(A,256);

%% set up
id=@(x,y)(x+1i*y);
giffile=[fname,'.gif'];

Asize = size(A,1);
nx=domainpixel;
dx=2*L/(nx-1);
x=-L:dx:L;
y=-L:dx:L;
[X,Y]=meshgrid(x,y);
Y=flip(Y,1);
newIm = zeros(nx,nx,3,'uint8');

if showfig
    fig=figure('visible','off','color','w');%'visible','off','Position',[400,55,1027,905],
    %figure(fig);
    ims=imshow(newIm);
    axis on;
    %set(gca,'ydir','normal');
    xTicksLoc = 0:domainpixel/10:domainpixel;
    xticks(xTicksLoc);
    xticklabels(num2cell(-L:2*L/10:L));
    yticks(xTicksLoc);
    yticklabels(num2cell(L:-2*L/10:-L));
    figtitle=title(['(1-t)z + t*',fname,', t=0'],'FontSize',14);
end

%% iterate
for t=0:0.01:1
    g = @(x,y) (1-t)*id(x,y) + t*f(x,y);
    transf = g(X,Y);
    R = min(round(mod(real(transf),tilesize)*(Asize/tilesize))+1,Asize);
    I = Asize+1 - min(round(mod(imag(transf),tilesize)*(Asize/tilesize))+1,Asize);
    for layer = 1:3
        ind = sub2ind(size(A),R,I,layer*ones(size(R)));
        newIm(:,:,layer) = A(ind);
    end
    if showfig
        ims.CData=newIm;
        figtitle.String=['(1-t)z + t*',fname,', t=',num2str(t)];
        drawnow;
        imind = rgb2ind(frame2im(getframe(fig)),cm);
    else
        imind = rgb2ind(newIm,cm);
    end
    if t==0
        imwrite(imind,cm,giffile,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,giffile,'gif','WriteMode','append','DelayTime',0);
    end
    fprintf('t=%f done\n',t);
end
% pause on the final image
imwrite(imind,cm,giffile,'gif','WriteMode','append','DelayTime',5);
end
