%% clear
clc; clear all; close all;

%% path
addpath('./lib')

%% load image
im = imread ('./im/arabidopsis.png');

%% normalize
im = double(im); im = (im-min(im(:)))/(max(im(:))-min(im(:)));

%% blob detection
rx = 0.1387; % pixel/micron resolution for x
ry = 0.1387; % pixel/micron resolution for y
s = 1.5; % blob size in microns
s = [s/rx s/ry]; % blob size in pixels for x and y
t = 0.20; % threshold level

b = blob_detector2d(im,s,t);

%% plot
figure; 
imagesc(im); colormap gray; colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

%% plot
bp = round(b(:,1:2));
bp(bp<1) = 1;
bp(bp>size(im,1),1) = size(im,1);
bp(bp>size(im,2),2) = size(im,2);
immask = false(size(im));
immask(sub2ind(size(immask),bp(:,1),bp(:,2))) = 1;

se = strel('disk',3);
immask = imdilate(immask,se);

imr = im; img = im; imb = im;
imr(immask) = 1; img(immask) = 0; imb(immask) = 0;
imrgb = zeros(size(im,1),size(im,2),3);
imrgb(:,:,1) = imr; imrgb(:,:,2) = img; imrgb(:,:,3) = img;

figure; 
imagesc(imrgb); colormap gray; colormap jet; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;