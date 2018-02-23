function idx = ellipse2d(xn,yn,x0,y0,rx,ry)  
%% ellipse2d - indices of 2D ellipse
%
%   INPUT:
%       xn,yn - image size
%       x0,y0 - elipsoid origin point
%       rx,ry - semi-axes are of lengths
%
%   OUTPUT:
%       idx   - indices
%
%   AUTHOR:
%       Boguslaw Obara

%% ellipse 2D
rx = round(rx);
ry = round(ry);
x1 = max(1,x0-rx); x2 = min(xn,x0+rx); 
y1 = max(1,y0-ry); y2 = min(yn,y0+ry); 
[xg,yg] = meshgrid(x1:x2,y1:y2);
idx1 = find( ( ((xg-x0)/rx).^2 + ((yg-y0)/ry).^2 ) <= 1);
idx = sub2ind([xn,yn],xg(idx1),yg(idx1));

end