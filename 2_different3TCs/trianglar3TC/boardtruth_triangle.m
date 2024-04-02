%% 生成真值
GT=[];GT_top=[];GT_left=[];GT_right=[];
for l=0:1
    %顶
    for k=0:l
        point=[0.1*((k)+(1-l)),-0.1*(k),0.1*(1-l)]+[0.1 0.1 0];
%          if ((l==0))
%             continue;
%          end
        for m=0:6
            for n=0:5   
                GT(end+1,:)=point+[-0.01*(n+1),-0.01*(m+1),0];
                GT_top(end+1,:)=point+[-0.01*(n+1),-0.01*(m+1),0];
            end
        end
    end
    %右
    for k=0:l
        point=[0.1*((k)+(1-l)),-0.1*(k),0.1*(1-l)]+[0.1 0 0];
%         if (((l==1)&&(k==0)))
%             continue;
%          end
        for m=0:6
            for n=0:5   
                GT(end+1,:)=point+[-0.01*(n+1),0,-0.01*(m+1)];
                GT_right(end+1,:)=point+[-0.01*(n+1),0,-0.01*(m+1)];
            end
        end
    end
    %左
    for k=0:l
        point=[0.1*((k)+(1-l)),-0.1*(k),0.1*(1-l)];
        for m=0:6
            for n=0:5   
                GT(end+1,:)=point+[0,0.01*(n+1),-0.01*(m+1)];
                GT_left(end+1,:)=point+[0,0.01*(n+1),-0.01*(m+1)];
            end
        end
    end
end


board_xyz=GT;   
Pcboard=pointCloud(board_xyz);
figure(2);pcshow(Pcboard);
save('220501/BoardTruth/CameraBoardGroudTruth_1_2.mat','GT');