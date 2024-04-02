%% 生成真值
GT=[];GT_top=[];GT_left=[];GT_right=[];
for l=0:4
    %顶
    for k=0:5 
        point=[0.1*((k)+(4-l)),-0.1*(k),0.1*(4-l)]+[0.1 0.1 0];
%         if (l==0)&&(k==0||k==1||k==3||k==4||k==5)
%             continue;
%         end
        if (l==0)&&(k==4)
            continue;
        end
        for m=0:6
            for n=0:5   
                GT(end+1,:)=point+[-0.01*(n+1),-0.01*(m+1),0];
                GT_top(end+1,:)=point+[-0.01*(n+1),-0.01*(m+1),0];
            end
        end
    end
    %右
    for k=0:5
        point=[0.1*((k)+(4-l)),-0.1*(k),0.1*(4-l)]+[0.1 0 0];       
        if (l==0)&&((k==1||k==2||k==3||k==4||k==5))
            continue;
        end
        if (l==1)&&((k==2||k==3||k==4||k==5))
            continue;
        end
        if (l==2)&&((k==2||k==3||k==4||k==5))
            continue;
        end
        if (l==3)&&((k==3||k==4||k==5))
            continue;
        end
        if (l==4)&&((k==2||k==3||k==4||k==5))
            continue;
        end
        for m=0:6
            for n=0:5   
                GT(end+1,:)=point+[-0.01*(n+1),0,-0.01*(m+1)];
                GT_right(end+1,:)=point+[-0.01*(n+1),0,-0.01*(m+1)];
            end
        end
    end
    %左
    for k=0:5
        point=[0.1*((k)+(4-l)),-0.1*(k),0.1*(4-l)];
        if (k==0)
            continue;
        end
        if (k==1)&&((l==2)||(l==3)||(l==4))
              continue;
        end
        if (k==2)&&((l==3)||(l==4))
              continue;
        end
        if (k==3)&&((l==4))
              continue;
        end
       
  
%         if (l==4)
%               continue;
%         end
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
save('220501/BoardTruth/CameraBoardGroudTruth_5_6.mat','GT');