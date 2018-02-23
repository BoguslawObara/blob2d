function imlog = blob_filter2d(im,s)
%% blob_filter2d - enhances 2D blob-like structures
%
%   INPUT:
%       im      - image
%       s       - sigma = [sigmax sigmay]
%
%   OUTPUT:
%       imlog   - enhanced image
%
%   AUTHOR:
%       Boguslaw Obara
%
%   VERSION:
%       0.1 - 03/06/2010 first implementation

%% 2D LoG
h = fspecial('log',round(6*s(1)),round(s(1)));
%h = fspecial('log',round(3*s(1)),round(s(1)));

imlog = imfilter(imcomplement(im),h,'same','symmetric');
%imlog = imfilter(imcomplement(im),h,'same','replicate');

%% use only hills, valleys are removed
imlog(imlog<0) = 0;

%% normalize
imlog = (imlog-min(imlog(:)))/(max(imlog(:))-min(imlog(:)));    

end
