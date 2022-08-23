%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%Nagel-Schreckenbergģ�͵ĸĽ���ʽ%%%%%%%%%%%%%%%%
%%%%����step��Ҳ����ʱ�䣬�������������̬����������ȱ仯%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [count,queue]=lengthplot(step,pa,in)
    %road_length = 48;  
    road_length = 16;                        %��·�ܳ���
    road = zeros(3,road_length);             %�����ٶȾ����г�����������ֵ����0��Ϊ�����ٶȣ��޳�����������ֵС��0
    %estate_in = 92;
    right_in = 180-75;
    pa = pa/3600;
    queuemax = 0;
    count = 0;
    for i=2:3
        road(i,1) = 7;                       %�¹�λ�ã���������������Ϊ����ͨ
    end
    
    road_next = road;                        %�½�����λ�þ���
    for t=1:step
       time(t)=t;                            %ʱ�䣬�������Ŷӳ���-ʱ��ͼ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%�ж��Ƿ�ͨ���¹ʽ���%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%��һ������ǰλ�õĳ�����0.4�ĸ���1s��ͨ���¹ʽ���%%%%%%%%%
%%%%%%%%%%%�ڵڶ�������ǰλ�õĳ���0.1�Ļ���ĵ���һ����%%%%%%%%%%
%%%%%%%%%%%�ڵ���������ǰλ�õĳ���0.1�Ļ���ĵ���������%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       pass = rand(1);

       if(pass<pa)
           road_next(1,2)=0;
           if(rand(1)>0.9)&&(road_next(2,2)>0)
               road_next(1,2)=1;            %�ĵ����ٶ�Ϊ1��������ͬ
               road_next(2,2)=0;
           elseif (rand(1)>0.8)&&(road_next(3,2)>0)&&(road_next(2,2)==0)
               road_next(2,2)=1;
               road_next(3,2)=0;
           end
       end
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%�����ļ��������%%%%%%%%%%%%%%%%%%%%%%%%%
%%����ײ����������ǰ��˾��ѡ�������j-k(������)����ĳ���̶�ֵ2%%%
%%%%%����ڵ�·һ��Ҫ������ף�˾������ٳ���¹ʻ��߼�������%%%%%%
%%%�����һ��·��û�����������ˣ�˾��ѡ�����ͨ����ֱ���ٶȴﵽ4%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for j=3:road_length 
           for i=1:3
           if(road_next(i,j)>0)
           if(j-road_next(i,j)<2)           %��������㹻ͨ�����ϰ��µ��¹ʽ��
              note = true;                  %note�鿴�Ƿ��ײ����������
              for  k=j-1:-1:2 
                  if(road_next(i,k)>0)
                     road_next(i,j)=0; 
                     if(rand(1)>0.9)
                     road_next(i,k+1)=j-k;  %���ٵ�(j-k)*5 m/s�ĳ���
                      else
                     road_next(i,k+1)=min(j-k,1);    
                      end
                     note = false;
                     break;
                  end
              end
              if ((note)&&(i==1))           %����ǵ�һ�������Գ��ȥ���������
                  pass = rand(1);
                  if(pass>0.5)
                  road_next(i,j)=0;
                  else
                  road_next(i,j)=0;
                  road_next(i,2)=1;   
                  end
              elseif ((note)&&(i>1))        %����ǵڶ���������ֻ�ܵ�����Ķ��ף��ȴ��ĵ�
                  road_next(i,j)=0;
                  road_next(i,2)=1;
              end
           else
               note = true;                 %note�鿴�Ƿ��ײ����������
               for k=j-1:-1:j-road_next(i,j)
                   if road_next(i,k)>0
                       road_next(i,j)=0;
                       road_next(i,k+1)=j-k;
                       note = false;
                       break;
                   end
               end
               if(note)                    %δײ������������ѡ����٣����ٵ�4�򲻱�
                   if(road_next(i,j)<4)
                       road_next(i,j-road_next(i,j)) = road_next(i,j)+1;
                   else
                       road_next(i,j-road_next(i,j)) = road_next(i,j);
                   end
                   road_next(i,j)=0;
               end
           end
           end
           end
       end
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%����������ĵ�%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%����ͨ���ٶȲ�ͬ������ԭ��˾����ѡ�����ĸĵ�%%%%%%%%
%%���иĵ��ĸ��ʷֱ���P(1,2)=.1,P(2,1)=.3,P(2,3)=.1,P(3,2)=.2%%%
%%%%%%%%%%%%%%%����P(i,j)ָ��i�����ĵ�j�����ĸ���%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for j=3:road_length                
           if (road_next(1,j)>0)&&(road_next(2,j)==0)&&(road_next(1,j-1)||road_next(1,j-2)||road_next(1,max(j-3,1)))  %һ��������
               temp = rand(1);
               if(temp>0.9)
                   road_next(2,j)=1;
                   road_next(1,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(2,k)>0)
                       road_next(2,k)=min(road_next(2,k),1);
                   end
               end
           end
           
           if (road_next(2,j)>0)&&(road_next(1,j)==0)&&(road_next(2,j-1)||road_next(2,j-2)||road_next(2,max(j-3,1)))  %������һ��
               temp = rand(1);
               if(temp>0.85)
                   road_next(1,j)=1;
                   road_next(2,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(1,k)>0)
                       road_next(1,k)=min(road_next(1,k),1);
                   end
               end
           end
           
           if (road_next(2,j)>0)&&(road_next(3,j)==0)&&(road_next(2,j-1)||road_next(2,j-2)||road_next(2,max(j-3,1)))  %����������
               temp = rand(1);
               if(temp>0.9)
                   road_next(3,j)=1;
                   road_next(2,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(3,k)>0)
                       road_next(3,k)=min(road_next(3,k),3);
                   end
               end
           end
           
           if (road_next(3,j)>0)&&(road_next(2,j)==0)&&(road_next(3,j-1)||road_next(3,j-2)||road_next(3,max(j-3,1)))  %����������
               temp = rand(1);
               if(temp>0.85)
                   road_next(2,j)=1;
                   road_next(3,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(2,k)>0)
                       road_next(2,k)=min(road_next(2,k),2);
                   end
               end
           end
           
       end
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%������������٣�����˾����ӵ��%%%%%%%%%%%%%%%%%%
%%��ʻ�У��������ܴ��ڸ���ԭ����٣����ﳵ��ÿ����ܼ�1��Ҳ���ܼ�1%%
%%%%%����˾�����������ֳ���ѡ�����У���Ӧ�����ڳ������������仯%%%%
%%%%%%%%%%ӵ�µĳ����к��Ѹı������ٶȣ�������ٻ������1%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for j=3:road_length                          %�������ģ��
           for i=1:3
               temp=rand(1);
               if(temp>0.8)&&(temp<0.85)&&(road_next(i,j)>0)&&(road_next(i,j)<4)
                   road_next(i,j) = road_next(i,j)+1;
               elseif(temp>0.8)&&(road_next(i,j)>1)&&(road_next(i,j)<=4)
                   road_next(i,j) = road_next(i,j)-1;
               end
           end
           
           for i=1:3                              %����˾��
           if (j<=8)&&(road_next(i,j)>0)
              road_next(i,j)=2;
           end
           end
           
           for i=1:3                             %ӵ�³����޷�ǰ��
           if (road_next(i,j-1)>0)&&(road_next(i,j)>0)
               temp = rand(1);
                road_next(i,j)=min(road_next(i,j-1),2*(temp>0.85)+1*(temp<=0.85));
           end
           end
       end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%������������%%%%%%%%%%%%%%%%%%%%%%%%%%     
%%%%%%%%�ٶ���������������һ���������30s�ڴ���0��30sС��0%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          
          sflow = in/3600;
          %sflow = in/3600;
          v0 = 2;
         for i=1:3 
           if (road_next(i,road_length)==0)&(mod(t,60)<10)
               temp = rand(1);
               if(temp<(right_in*(i==1)/3600+sflow./3.*2)*2.1)
              road_next(i,road_length-1)=v0;
              count = count+1;
               end
           elseif (road_next(i,road_length)==0)&(mod(t,60)<20)&(mod(t,60)>=10)
               temp = rand(1);
               if(temp<(right_in*(i==1)/3600+sflow./3.*2)*0.45)
              road_next(i,road_length)=v0;
              count = count+1;
               end
           elseif (road_next(i,road_length)==0)&(mod(t,60)<30)&(mod(t,60)>=20)
               temp = rand(1);
               if(temp<(right_in*(i==1)/3600+sflow./3.*2)*0.45)
              road_next(i,road_length)=v0;
              count = count+1;
               end
           end
         end  
       if(road_next(1,road_length)==0)&(mod(t,60)>=30)
               temp = rand(1);
               if(temp<right_in/3600)
              road_next(1,road_length)=v0;
              count = count+1;
               end
       end
            
       
       
       %temp = rand(1);
       %if(road_next(1,20)==0)&(temp<estate_in/3600)
       %    road_next(1,20) = 2;
       %end
    
       road = road_next;
       
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%��������ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       %imagesc(road_next);
       %title(['t=',num2str(t)]);
       %drawnow
       %pause(0.001)
       %f=getframe;
       %f=frame2im(f);
       %[X,map]=rgb2ind(f,256);
       %if t==1
       %     imwrite(X,map,'ex_imwrite.gif','DelayTime',0.1);
       %else
       %     imwrite(X,map,'ex_imwrite.gif','WriteMode','Append','DelayTime',0.1);
       %end
       
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%�����Ŷӳ���-ʱ���ϵͼ%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for i=1:3
          length(i)=0;
        for j=2:road_length 
           if(road_next(i,j)>0)
            length(i) = length(i)+1;
           else
            break;
           end
        end
       end
       queue(t)=4*sum(length);
    
    %plot(time,queue)
    %ylabel('�Ŷ���������(m)')
    %xlabel('�¹ʳ���ʱ��(s)')
end