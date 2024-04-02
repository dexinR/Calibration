function [T_final,err,data_mid]=rdxicp(P,Q,T_final)
% 读取源点云数据P
% ShowData(P,Q);
data_target=P';
data_source=Q';


tic
iteration=0;
Rf=T_final(1:3,1:3);
Tf=T_final(1:3,4);
data_target=Rf*data_target+Tf*ones(1,size(data_target,2));    %初次更新点集（代表粗配准结果）
err=1;
while(err>0.000001)
    iteration=iteration+1;    %迭代次数
    disp(['迭代次数ieration=',num2str(iteration)]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %利用欧式距离找出对应点集
    k=size(data_target,2);
    for i = 1:k
        data_q1(1,:) = data_source(1,:) - data_target(1,i);    % 两个点集中的点x坐标之差
        data_q1(2,:) = data_source(2,:) - data_target(2,i);    % 两个点集中的点y坐标之差
        data_q1(3,:) = data_source(3,:) - data_target(3,i);    % 两个点集中的点z坐标之差
        distance = data_q1(1,:).^2 + data_q1(2,:).^2 + data_q1(3,:).^2;  % 欧氏距离
        [min_dis, min_index] = min(distance);   % 找到距离最小的那个点
        data_mid(:,i) = data_source(:,min_index);   % 将那个点保存为对应点
        error(i) = min_dis;     % 保存距离差值
    end
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %去中心化
    data_target_mean=mean(data_target,2);
    data_mid_mean=mean(data_mid,2);
    data_target_c=data_target-data_target_mean*ones(1,size(data_target,2));
    data_mid_c=data_mid-data_mid_mean*ones(1,size(data_mid,2));
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SVD分解
    W=zeros(3,3);
    for j=1:size(data_target_c,2)
        W=W+data_mid_c(:,j)*data_target_c(:,j)';
    end
    [U,S,V]=svd(W);
    Rf=U*V';
    Tf=data_mid_mean-Rf*data_target_mean;
    err=mean(error);
    T_t=[Rf,Tf];
    T_t=[T_t;0,0,0,1];
    T_final=T_t*T_final;   %更新旋转矩阵
%     disp(['误差err=',num2str(err)]);
%     disp('旋转矩阵T=');
%     disp(T_final);
     
    data_target=Rf*data_target+Tf*ones(1,size(data_target,2));    %更新点集
    %ShowData(data_target',Q);
    if iteration>=200
        break
    end
end
toc