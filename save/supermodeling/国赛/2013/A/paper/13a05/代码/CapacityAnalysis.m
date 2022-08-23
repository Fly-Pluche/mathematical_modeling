function LL=CapacityAnalysis(Capacity)
dt=1;                                   %ģ�ⵥλ����
alph=4.8;                                 %�Ŷӱ�׼�����������Ŷӳ��ȵĻ������ m/pcu
beta=1.5;                               %��ɢģ�����ϵ��
RightFlow=180/3600;                     %������ת�䳵����
Xiaoqu1=75/3600;
Xiaoqu2=167/3600;
L=240;                    	           %��������·�ھ���

v=10;                                  %��������ƽ������
TTotal=826;                             %��ģ��ʱ��
delay=26;
     function StraightFlow=StraightFlow(t)
        StraightFlow=0.0002*t+0.2387;
    end

   function dStraightFlow=dStraightFlow(t)
        tmod=mod(t,60);
        if (tmod>30)
            dStraightFlow=0;
        end
        if (tmod<=2)
            dStraightFlow=StraightFlow(t)*60/72*3*beta*dt;
        end
        if ((tmod>2)&&(tmod<=10))
            dStraightFlow=StraightFlow(t)*60/72*5*beta*dt;
        end
        if ((tmod>10)&&(tmod<=12))
            dStraightFlow=StraightFlow(t)*60/72*4*beta*dt;
        end
        if((tmod>12)&&(tmod<=30))
            dStraightFlow=StraightFlow(t)*60/72*1*beta*dt;
        end 
   end

   function dRightFlow=dRightFlow(t)
       dRightFlow=RightFlow*dt;
   end

    function dPCU=pcuIncrease(t,l)
            dPCU=-Capacity*dt+(dStraightFlow(t-(L-l)/v)+dRightFlow(t-(L-l)/v)+-Xiaoqu1*dt+Xiaoqu2*dt);
    end

T=-delay:dt:TTotal;
l(1)=0;
sum=0;
for i=1:(TTotal/dt+delay)
    tmp=l(i)+pcuIncrease(i*dt,l(i))*alph;
    sum=sum+dStraightFlow(i*dt-(L-l(i))/v)*dt;
    if (tmp<0)
        l(i+1)=0;
    else
        l(i+1)=tmp;
    end
end
sum=sum/TTotal;
%plot(T,l);
LL=l(TTotal/dt+delay+1);
end

