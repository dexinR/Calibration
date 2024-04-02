%% 相机匹配误差
load('220501/cameraParams.mat');
intrinsic = cameraParams.IntrinsicMatrix;
intrinsic = intrinsic';
intrinsic=cat(2,intrinsic,[0;0;0]);
cali=intrinsic*(tform_lidar2camera_mix.T).';

figure(24);
imgPath = './220501/Picture/'; % 图像库路径
imgDir = dir([imgPath '*.bmp']); % 遍历所有jpg格式文件
idx_start=0;
for i = 1:length(imgDir) % 遍历结构体就可以一一处理图片了
    img_frame = imread([imgPath imgDir(i).name]); %读取每张图片
    img_frame_undis=undistortImage(img_frame,cameraParams);
    figure();
    imshow(img_frame_undis,'border','tight','InitialMagnification','fit');
    hold on;
    board_img=project(GTlidar_points(idx_start+1:idx_start+GTlidar_num(i),:),cali);
    for n=1:size(board_img,1)
        err(n+idx_start)=norm(board_img(n,:)-imagePoints_sort(n+idx_start,:));
        plot(board_img(n,1),board_img(n,2),'o','LineWidth',1,'MarkerSize',1,'Color',[1 0 0]);
    end
    hold off;
    idx_start=idx_start+GTlidar_num(i);
end
avrerr=sum(err)/size(GTlidar_mix,1);
%% plot
load('220501/Cloudcsv_220501_pandar40P_1_2_1.mat');
pc_x=Cloudcsv_220501_pandar40P_1_2_1.Points_m_XYZ0;
pc_y=Cloudcsv_220501_pandar40P_1_2_1.Points_m_XYZ1;
pc_z=Cloudcsv_220501_pandar40P_1_2_1.Points_m_XYZ2;
pc_i=Cloudcsv_220501_pandar40P_1_2_1.intensity;
pc_xyz=[pc_x pc_y pc_z];
ptCloud=pointCloud(pc_xyz,'Intensity',pc_i);

figure(26);pcshow(ptCloud);
pc_xyz=reshape(ptCloud.Location,[],3);
pc_i=reshape(ptCloud.Intensity,[],1);
pc_i=single(pc_i);
pc_xyzi=cat(2,pc_xyz,pc_i);

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
idx = pc_xyzi(:,3)>10;
pc_xyzi(idx,:) = [];
pc_xyz=pc_xyzi(:,1:3);
pc_i=pc_xyzi(:,4);

pci=pointCloud(pc_xyz,'Intensity',pc_i);
figure(27);pcshow(pci);

Pccmatrix=zeros(length(pc_xyz),3);
for i=1:length(pc_xyz)
    if pc_xyz(i,3)<-0.9-0.071*pc_xyz(i,2)
        Pccmatrix(i,1:3)=[1,0,0];
    else
        Pccmatrix(i,1:3)=[0,0,1];
    end
end

pci=pointCloud(pc_xyz,'Color',Pccmatrix);
figure(27);pcshow(pci);

%%
img_frame = imread("220501/Picture/1_2_1.bmp");
%img_frame = imresize(img_frame,0.25);
load('220501/cameraParams.mat');
img_frame = undistortImage(img_frame,cameraParams);
intrinsic = cameraParams.IntrinsicMatrix;
intrinsic = intrinsic';
intrinsic=cat(2,intrinsic,[0;0;0]);
% intrinsic=intrinsic*4;
% intrinsic(3,3)=1;
cali=intrinsic*(tform_lidar2camera_mix.T).';
figure(28);
imshow(img_frame,'border','tight','InitialMagnification','fit');

hold on;
lidar_img = project(pci.Location(:,1:3),cali);
for k=1:size(lidar_img,1)
    if ((lidar_img(k,1)<0)||(lidar_img(k,2)<0)||(lidar_img(k,1)>2448)||(lidar_img(k,2)>2050))
        continue;
    end
    plot(lidar_img(k,1),lidar_img(k,2),'o','LineWidth',1,'MarkerSize',1,'Color',Pccmatrix(k,1:3));
end

hold off;
%savefig("1.fig");