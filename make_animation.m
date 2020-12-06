function fig=make_animation(f,fname)
%% original image
% A = imread('sthughs_crop.jpg');
% A = A(1:1:1001,1:1:1001,:); %1001x1001
A = imread('peppers.png');
A = A(100:2:300,100:2:300,:); %101x101
% figure;
% imshow(A);
% title('Original Image','FontSize',14)
for layer = 1:3
    A(:,:,layer) = A(:,:,layer)';
end

%%
id=@(x,y)(x+1i*y);
%f=@(x,y) (x+1i*y).^3;
%fname = 'z^3';
L=5;
fig=figure('Visible','off');
giffile=[fname,'.gif'];
newIm=transform(A,id,L);
ims=imshow(newIm);
axis on;
%set(gca,'ydir','normal');
xTicksLoc = 0:(size(A,1)-1):2*L*(size(A,1)-1);
xticks(xTicksLoc);
xticklabels(num2cell(-L:1:L));
yticks(xTicksLoc);
yticklabels(num2cell(L:-1:-L));
figtitle=title(['(1-t)z + t*',fname,', t=0'],'FontSize',14);

frame = getframe(fig);im = frame2im(frame);[imind,cm] = rgb2ind(im,256);
imwrite(imind,cm,giffile,'gif', 'Loopcount',inf);

for t=0:0.01:1
    g = @(x,y) (1-t)*id(x,y) + t*f(x,y);
    newIm=transform(A,g,L);
    ims.CData=newIm;
    figtitle.String=['(1-t)z + t*',fname,', t=',num2str(t)];
    
    frame = getframe(fig);im = frame2im(frame);[imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,giffile,'gif','WriteMode','append','DelayTime',0);
    fprintf('t=%f done\n',t);
end
end