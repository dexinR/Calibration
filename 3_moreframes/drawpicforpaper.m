load('220211/Cloudcsv_220211_pandar40P_1_2_1.mat');
pc_x=Cloudcsv_220211_pandar40P_1_2_1.Points_m_XYZ0;
pc_y=Cloudcsv_220211_pandar40P_1_2_1.Points_m_XYZ1;
pc_z=Cloudcsv_220211_pandar40P_1_2_1.Points_m_XYZ2;
pc_i=Cloudcsv_220211_pandar40P_1_2_1.intensity;
pc_xyz=[pc_x pc_y pc_z];
ptCloud=pointCloud(pc_xyz,'Intensity',pc_i);
figure(1);pcshow(ptCloud);

figure(26);pcshow(ptCloud);
pc_xyz=reshape(ptCloud.Location,[],3);
pc_i=reshape(ptCloud.Intensity,[],1);
pc_i=single(pc_i);
pc_xyzi=cat(2,pc_xyz,pc_i);
%% 绘图
idx = pc_xyzi(:,1)<-1;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,1)>4;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,2)<-10;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,2)>-2;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,3)<-2;
pc_xyzi(idx,:) = [];
idx = pc_xyzi(:,3)>15;
pc_xyzi(idx,:) = [];
pc_xyz=pc_xyzi(:,1:3);
pc=pointCloud(pc_xyz);
figure(2);pcshow(pc);
%%

Pccmatrix=zeros(length(pc_xyz),3);
for i=1:length(pc_xyz)
    if pc_xyz(i,3)<-0.75+0.01*pc_xyz(i,2)
        Pccmatrix(i,1:3)=[1,0,0];
    else
        Pccmatrix(i,1:3)=[0,0,1];
    end
end

pci=pointCloud(pc_xyz,'Color',Pccmatrix);
figure(27);pcshow(pci);
