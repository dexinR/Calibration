%% 雷达匹配
PcPath = './220501/BoxPc/'; % 点云库路径
PcDir = dir([PcPath '*.mat']); % 遍历所有mat格式文件
tform_pc2box=[];
tform_box2pc=[];
BoxPc=[];
for i = 1:length(PcDir) % 遍历结构体就可以一一处理点云了
    load([PcPath PcDir(i).name]); %读取点云进入pc
    %转存
    
    %step1.展示
    load('LidarGroundTruth_5_6.mat');
    Boxtruth=pointCloud(GT);
    figure(3);pcshow(pc);hold on; pcshow(Boxtruth);hold off;
    %step2.初始化变化矩阵
    err=zeros(12,1);
    T=zeros(4,4,12);
    for idx=1:12
        StartRotationMatrix = [cos(idx*pi/6) sin(idx*pi/6) 0 0; -sin(idx*pi/6) cos(idx*pi/6) 0 0; 0 0 1 0;0 0 0 1];
        tforms=affine3d(StartRotationMatrix);
        %step3.正一遍匹配icp
        tform_pc2box_idx = pcregistericp(pc,Boxtruth,'InitialTransform',tforms);
        pctrans = pctransform(pc,tform_pc2box_idx);
        xyz=Boxtruth.Location;
        cmatrix = ones(size(Boxtruth.Location)).*[1 0 0];
        ptCloudXYZRGB = pointCloud(xyz,'Color',cmatrix);
        figure(4);pcshow(pctrans);hold on; pcshow(ptCloudXYZRGB);hold off;
        %step4.反一遍匹配icp
        [T(:,:,idx),err(idx),~]=rdxicp(GT,pc.Location,inv(tform_pc2box_idx.T'));
    end
    [~,idx]=min(err);
    BoxPc=[BoxPc;pc];
    tform_box2pc=[tform_box2pc;affine3d(T(:,:,idx)')];
    tform_pc2box=[tform_pc2box;affine3d(inv(T(:,:,idx))')];
    pctrans = pctransform(Boxtruth,tform_box2pc(i));
    xyz=pctrans.Location;
    cmatrix = ones(size(pctrans.Location)).*[1 0 0];
    ptCloudXYZRGB = pointCloud(xyz,'Color',cmatrix);
    figure(5);pcshow(ptCloudXYZRGB);hold on; pcshow(pc);hold off;
    %step5.保存tform_pc2box并展示
    pctrans = pctransform(BoxPc(i),tform_pc2box(i));
    xyz=pctrans.Location;
    cmatrix = ones(size(pctrans.Location)).*[1 0 0];
    ptCloudXYZRGB = pointCloud(xyz,'Color',cmatrix);
    figure(6);pcshow(ptCloudXYZRGB);hold on; pcshow(Boxtruth);hold off;
    grid on;
end

