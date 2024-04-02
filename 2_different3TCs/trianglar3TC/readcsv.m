clc;
%% 创建文件夹
mkdir('220501/BoxPc');
%% 雷达数据读入1
load('220501/Cloudcsv_220501_pandar40P_1_2_1.mat');
pc_x=Cloudcsv_220501_pandar40P_1_2_1.Points_m_XYZ0;
pc_y=Cloudcsv_220501_pandar40P_1_2_1.Points_m_XYZ1;
pc_z=Cloudcsv_220501_pandar40P_1_2_1.Points_m_XYZ2;
pc_i=Cloudcsv_220501_pandar40P_1_2_1.intensity;
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
idx = pc_xyzi(:,1)<1.6;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,1)>2.2;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,2)<-5;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,2)>-4.2;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,3)<-0.3;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,3)>5;
pc_xyzi(idx,:) = [];
pc_xyz=pc_xyzi(:,1:3);
pc_i=pc_xyzi(:,4);
pc=pointCloud(pc_xyz,'Intensity',pc_i);
figure(2);pcshow(pc);
%% 保存
save('220501/BoxPc/BoxPc_1_2_1_pandar40P','pc');