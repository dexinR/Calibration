function Matout=fillp(Matin,Cr,P)
    if isempty(Matin)
        Matout=Matin;
        return;
    end
    Minx=min(P(1,:));Maxx=max(P(1,:));Miny=min(P(2,:));Maxy=max(P(2,:));
    for x=floor(Minx)+0.5:ceil(Maxx)-0.5
        for y=floor(Miny)+0.5:ceil(Maxy)+0.5
            s=0;
            for i=1:size(P,2)
                p=(P(:,i)'-[x,y]);
                q=P(:,rem(i,size(P,2))+1)-[x;y];
                s=s+acos(p*q/sqrt(eps+(p*p')*(q'*q)));
            end
            if abs(s-2*pi)<0.1
                Matin(1+ceil(x+0.5),1+ceil(y+0.5),1)=Cr(1);
                Matin(1+ceil(x+0.5),1+ceil(y+0.5),2)=Cr(2);
                Matin(1+ceil(x+0.5),1+ceil(y+0.5),3)=Cr(3);
            end
        end
    end
    Matout=Matin;
end