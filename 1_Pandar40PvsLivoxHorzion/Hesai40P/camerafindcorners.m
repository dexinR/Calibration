%% 相机找点1
imgPath = './220501/Picture/'; % 图片库路径
imgDir = dir([imgPath '*.bmp']); % 遍历所有bmp格式文件
imagePoints_sort=[];imagePoints_num=zeros(length(imgDir),1);
for i = 1:length(imgDir)
    I= imread([imgPath imgDir(i).name]); %读取每张图片
    imagePoints_notsort=[];
    [imagePoints,boardSize] = detectCheckerboardPoints(I);
    while((isequal(boardSize,[7 8]))&&(~isequal(imagePoints,[])))
        PointsNum=(boardSize(1)-1)*(boardSize(2)-1);
        p1=imagePoints(1,:);p2=imagePoints(PointsNum,:); 
        if (p1(1,2)>p2(1,2))
            imagePoints=flip(imagePoints);
            p1=imagePoints(1,:);p2=imagePoints(PointsNum,:);
        end
        p3=imagePoints(boardSize(1)-1,:);p4=imagePoints(PointsNum-boardSize(1)+2,:);
        I=fillp(I,[0,0,0],flip([p1;p3;p2;p4]'));
        figure(13);
        imshow(I);
        imagePoints_notsort=cat(3,imagePoints_notsort,imagePoints);
        [imagePoints,boardSize] = detectCheckerboardPoints(I);
    end
   
    imagePoints_sort_i=Pointsort(imagePoints_notsort);
    %显示
 
    figure(14);
    J = insertText(I,imagePoints_sort_i,1:size(imagePoints_sort_i,1));
    J = insertMarker(J,imagePoints_sort_i,'o','Color','red','Size',1);
    imshow(J);%set (gcf,'Position',[0,0,4096,3000]);
    title(sprintf('Detected a 7 x 8 Checkerboard'));
    %保存
    imagePoints_sort=[imagePoints_sort;imagePoints_sort_i];
    imagePoints_num(i)=size(imagePoints_sort_i,1);
end