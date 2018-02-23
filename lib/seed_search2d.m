function b = seed_search2d(im,s,t)
%% seed_search2d - finding seeds
%
%   INPUT:
%       im      - LoG of blob channel
%       s       - blob size
%       t       - lowest intensity bound
%
%   OUTPUT:
%       b      - detected blob positions
%
%   AUTHOR:
%       Boguslaw Obara

%% regional max
% cube is 10 times faster - matlab converts it into 1D line elements
% se = ones(2*ns+1);

% ellipse
s = round(s); 
[xg,yg] = meshgrid(-s(1):s(1),-s(2):s(2));
se = ( (xg/s(1)).^2 + (yg/s(2)).^2 ) <= 1;

immax = imdilate(im,se);

idx = find(im==immax);
idx(im(idx)<t) = [];

[xc,yc] = ind2sub(size(im),idx);
b = [xc yc];    

[~,idxs] = sort(im(idx),'descend');
b = b(idxs,:);    
b(:,3) = (1:size(b,1))';

end