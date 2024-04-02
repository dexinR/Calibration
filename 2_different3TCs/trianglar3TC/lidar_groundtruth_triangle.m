%% 生成真值
GT=[];GTcmatrix = [];
x=9;
for n=0:1
    for m=0:1-n
        %核心点
        corepoint=[(m+n)*0.1,m*-0.1,n*0.1];
%        GT(end+1,:)=corepoint;
        %核心线
        for i=0:x
            linepoint=corepoint+[0.1*i/x,0,-0.1];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            linepoint=corepoint+[0.1*i/x,0.1,0];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            linepoint=corepoint+[0.1*i/x,0,0];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            
            linepoint=corepoint+[0,0.1*i/x,0];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            linepoint=corepoint+[0,0.1*i/x,-0.1];

            linepoint=corepoint+[0,0.1,-0.1*i/x];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            
        end
        %核心面
        for i=1:x-1
            for j=1:x-1
                facepoint=corepoint+[0.1*i/x,0.1*j/x,0];%1号面：顶面
                GT(end+1,:)=facepoint;GTcmatrix(end+1,:)=[1 0 0];
                facepoint=corepoint+[0.1*i/x,0,-0.1*j/x];%2号面：右侧面
                GT(end+1,:)=facepoint;GTcmatrix(end+1,:)=[0 1 0];
                facepoint=corepoint+[0,0.1*i/x,-0.1*j/x];%3号面：左侧面
                GT(end+1,:)=facepoint;GTcmatrix(end+1,:)=[0 0 1];
                if ((n==1)&&((m==0))||((n==0)&&(m==1)))
                    facepoint=corepoint+[0.1,0,0]+[0.1*i/x,0.1*j/x,0];%1号面：顶面
                    GT(end+1,:)=facepoint;GTcmatrix(end+1,:)=[1 0 0];
                end
                if ((m==0)&&((n==1))||((n==0)&&(m==1)))
                    facepoint=corepoint+[0.1,0,0]+[0.1*i/x,0,-0.1*j/x];%2号面：右侧面
                    GT(end+1,:)=facepoint;GTcmatrix(end+1,:)=[1 0 0];
                end
            end
        end
        
    end
end

%辅助线
%顶部辅助线
for m=0:1
        for i=0:x
            linepoint=[0.2,-0.1*m+0.1*i/x,0.1-0.1*m];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            linepoint=[0,0.1*i/x,-0.1];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];  
        end
end
%右部辅助线
for n=0:1
        for i=0:x
            linepoint=[0.2,0-0.1*n,0.1-0.1*n-0.1*i/x];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];
            linepoint=[0,0.1*i/x,-0.1];
            GT(end+1,:)=linepoint;GTcmatrix(end+1,:)=[1 1 1];  
        end
end
plane_xyz=GT;
plane=pointCloud(plane_xyz);
figure(1);pcshow(plane);
save('LidarGroundTruth_triangle.mat','GT','GTcmatrix');