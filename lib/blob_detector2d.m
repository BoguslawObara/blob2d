function b = blob_detector2d(im,s,t)
%%  blob_detector2d - 2D blob detector
%   
%   REFERENCE:
%       B. Obara and A. Jabeen and N. Fernandez and P. P. Laissue,
%       A novel method for quantified, superresolved, three-dimensional 
%       colocalisation of isotropic, fluorescent particles,
%       Histochemistry and Cell Biology, 139, 3, 391-402, 2013 
%
%   INPUT:
%       imn     - image
%       s       - blob size[pixels] = 
%                   ns[microns]*[1/resolutionx 1/resolutiony]
%       t       - lowest intensity bound,
%
%   OUTPUT:
%       b      - detected blob positions
%                   b(:,1) -> x
%                   b(:,2) -> y
%                   b(:,3) -> average intensity of blob volumes
%                   b(:,4) -> average LoG intensity of blob volumes
%
%   AUTHOR:
%       Boguslaw Obara
%
%   VERSION:
%       0.1 - 30/06/2009 first implementation
%       0.2 - 04/06/2010 LoG + revision
%       0.3 - 24/09/2010 speed up

%% LoG
imlog = blob_filter2d(im,s);

%% finding seeds
b = seed_search2d(imlog,s,t);

%% filtering
dt = mask_descriptor2d(im,imlog,b,s);
b = stat_descriptor2d(im,b,dt,s*1.2); %1.2

%% average intensity values          
b(:,4) = dt(b(:,3),1);
b(:,5) = dt(b(:,3),2);
b(:,3) = []; % remove indices

end