%% 总体匹配
load('220211/cameraParams.mat');
BoardTruthPath = './220211/BoardTruth/'; % 标定板模拟真值库路径
BoardTruthDir = dir([BoardTruthPath '*.mat']); % 遍历所有mat格式文件
GTlidar_mix=[];Pc_point_mix=[];
GTlidar_points=[];GTlidar_num=zeros(length(BoardTruthDir),1);
for i = 1:length(BoardTruthDir) 
    load([BoardTruthPath BoardTruthDir(i).name]); %读取标定板模拟真值进入GT
    % %GT改雷达坐标系
    GTpc=pointCloud(GT);figure(21);pcshow(GTpc);
    GTlidartrans=pctransform(GTpc,tform_box2pc(i));
    GTlidar=double(GTlidartrans.Location);
    GTlidar_num(i)=size(GTlidar,1);
    GTlidar_mix=[GTlidar_mix;GTlidar];
    GTlidar_points=[GTlidar_points;GTlidar];
    Pc_point_mix=[Pc_point_mix;double(BoxPc(i).Location)];
end
GTpc_mix=pointCloud(GTlidar_mix);
figure(21);pcshow(GTpc_mix);
view(0,0);
[worldOrientation,worldLocation] = estimateWorldCameraPose(imagePoints_sort(1:length(imagePoints_sort),:)/10,GTlidar_mix(1:length(imagePoints_sort),:),cameraParams_s);
[R,t] = cameraPoseToExtrinsics(worldOrientation,worldLocation);
tform_lidar2camera_mix=rigid3d(R,t);

pc_mix=pointCloud(Pc_point_mix);
figure(22);pcshow(pc_mix);
view(0,0);
pctrans1 = pctransform(pc_mix,tform_lidar2camera_mix);
figure(23);pcshow(pctrans1);
view(0,0);