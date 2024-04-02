clc;
%% 创建文件夹
mkdir('220211/BoxPc');
%% 雷达数据读入1
load('220211/Cloudcsv_220211_pandar40P_1_2_1.mat');
pc_x=Cloudcsv_220211_pandar40P_1_2_1.Points_m_XYZ0;
pc_y=Cloudcsv_220211_pandar40P_1_2_1.Points_m_XYZ1;
pc_z=Cloudcsv_220211_pandar40P_1_2_1.Points_m_XYZ2;
pc_i=Cloudcsv_220211_pandar40P_1_2_1.intensity;
pc_xyz=[pc_x pc_y pc_z];
ptCloud=pointCloud(pc_xyz,'Intensity',pc_i);
figure(1);pcshow(ptCloud);
%% 预处理
pc_xyz=reshape(ptCloud.Location,[],3);
pc_i=reshape(ptCloud.Intensity,[],1); 
pc_i=single(pc_i);
pc_xyzi=cat(2,pc_xyz,pc_i);
pc=pointCloud(pc_xyz,'Intensity',pc_i);
figure(1);pcshow(pc);
%% 带通滤波
idx = pc_xyzi(:,1)<0.5;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,1)>1;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,2)<-3;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,2)>-2;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,3)<-0.24;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,3)>10;
pc_xyzi(idx,:) = [];
pc_xyz=pc_xyzi(:,1:3);
pc_i=pc_xyzi(:,4);
pc=pointCloud(pc_xyz,'Intensity',pc_i);
figure(2);pcshow(pc);

%% Ransac 去除地平面
% maxDistance=0.02;
% referenceVector = [0,0,1];
% maxAngularDistance = 30;
% [model,inlierIndices,outlierIndices] = pcfitplane(pc1,maxDistance,referenceVector,maxAngularDistance);
% 
% remainPtCloud = select(pc1,outlierIndices);
% figure(3);pcshow(remainPtCloud);
% pc1=remainPtCloud;
%% 采样
% xyzpoint=pc.Location;
% xyz=xyzpoint(1:100:size(xyzpoint),:);
% pc=pointCloud(xyz);
% figure(3);pcshow(pc);
%% 保存
save('220428/BoxPc/BoxPc_1_2_1_heisai','pc');