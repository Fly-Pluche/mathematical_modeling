function me=histogramofauto()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%histogramofauto������Ԫ���Զ���ģ��ʱ��ֲ�ֱ��ͼ%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = experiNagal(1000,1370,1500);
for i=1:10000
p = [p,experiNagal(1000,1370,1500)];
end
hist(p,50);
xlabel('����ʱ��(s)');
ylabel('Ƶ��');
me=mean(p);
end