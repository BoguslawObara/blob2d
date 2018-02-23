function dt = mask_descriptor2d(im,imlog,b,s)
%% mask_descriptor2d - table with descriptor measures
%
%   INPUT:
%       im      - blob channel
%       imlog   - LoG of blob channel
%       b       - detected blob positions
%       s       - blob size
%
%   OUTPUT:
%       dt      - descriptor values
%
%   AUTHOR:
%       Boguslaw Obara

%% setup
[xn,yn] = size(im);
dt = zeros(size(b,1),5);

%% loop
for i=1:size(b,1)
    idx = ellipse2d(xn,yn,b(i,1),b(i,2),s(1),s(2));     
    v = im(idx);    
    vlog = imlog(idx);    
    m = mean(double(v(:)));
    mlog = mean(double(vlog(:)));
    su = sum(double(v(:)));    
    dt(i,1) = m;
    dt(i,2) = mlog;
    dt(i,3) = su;  
end

end