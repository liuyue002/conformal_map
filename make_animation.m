function fig=make_animation(f,fname)
close all;
%% original image
showorig=0;
showfig=1;

A = imread('sthughs_crop.jpg');
A = A(1:1:1000,1:1:1000,:); %1000x1000
%A = imread('peppers.png');
%A = A(100:2:300,100:2:300,:); %101x101
if showorig
    figorig=figure;
    imshow(A);
    title('Original Image','FontSize',14);
end
for layer = 1:3
    A(:,:,layer) = A(:,:,layer)';
end
[~,cm] = rgb2ind(A,256);

%% set up
id=@(x,y)(x+1i*y);
%f=@(x,y) (x+1i*y).^3;
%fname = 'z^3';
L=5;
domainpixel=1001;

giffile=[fname,'.gif'];
newIm=transform(A,id,L,1,domainpixel);
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
    imind = rgb2ind(frame2im(getframe(fig)),cm);
else
    imind = rgb2ind(newIm,cm);
end
imwrite(imind,cm,giffile,'gif', 'Loopcount',inf);

%% iterate
for t=0:0.01:1
    g = @(x,y) (1-t)*id(x,y) + t*f(x,y);
    newIm=transform(A,g,L,1,domainpixel);
    if showfig
        ims.CData=newIm;
        figtitle.String=['(1-t)z + t*',fname,', t=',num2str(t)];
        drawnow;
        imind = rgb2ind(frame2im(getframe(fig)),cm);
    else
        imind = rgb2ind(newIm,cm);
    end
    imwrite(imind,cm,giffile,'gif','WriteMode','append','DelayTime',0);
    fprintf('t=%f done\n',t);
end
end
