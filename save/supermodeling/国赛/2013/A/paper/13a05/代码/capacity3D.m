function Z=capacity3D(inflow)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%capacity3D���ڻ��Ŷӳ�����ʱ�䡢�¹��ֳ������Ĺ�ϵ%%%
%%%%%%%%%%�̶�����������С����������Ƶ���ݼ�%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[cap,t]=meshgrid(300:10:1000,1:500);
    
    for i=300:10:1000
        mat = zeros(1,500);
        parfor j=1:50
            [count,temp]=automata(500,i/3600,inflow);
            mat = mat+temp;
        end
        mat = mat/50;
        for j=1:500
            y(j)=f(j,inflow,180+92,i);
        end
        for j=1:14
            h(j)=0; %������ģ��
        end
        for x=1:500-14
            h(x+14)=y(x);
        end
        for j=1:500;
        Z(j,(i-300)/10+1)=mat(1,j);%�Զ���ģ��
        end
    end
    surf(cap,t,Z);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%���㲻����ģ���µ�����ֵ�����������Ƚ�%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function fixvalue=f(time,inflow,fixin,cap)
        remainder = mod(time,60);
        round = (time-remainder)/60;
        increase = max((inflow*2+fixin-cap)/3600,0);
        decrease = (cap-fixin)/3600;
        fixvalue = round*max((increase-decrease)*30,0);
        if(remainder<30)
            fixvalue = fixvalue+increase*remainder;
        else
            fixvalue = max(fixvalue+increase*30-decrease*mod(remainder,30),0);
        end
    end
   
end