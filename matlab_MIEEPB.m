%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Field Dimensions - x and y maximum (in meters)
% % multi chain pegasis with mobile sink %%%%%%%%%%
xm=100;
ym=100;
sink.x=0*xm;
sink.y=0*ym;
node_number=100;
datanum=2000; %data packets=2kbits
Eo=0.5;
%Eelec=Etx=Erx
ETX=50*10^(-9);
ERX=50*10^(-9);
%Transmit Amplifier types
Efs=10*10^(-12);
Emp=0.0013*10^(-12);
%Data Aggregation Energy
 
EDA=5*10^(-9);
%Data Aggregation
DA=0.6;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datanum1=DA*datanum;%%%%%%%%%%%%%%%%%%
rmax=2500;
do=sqrt(Efs/Emp);
E1=0.75;
%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%
%%Initialed the node positions
for ii=1:1:node_number%nodes area wise distribution
    if(ii<26)
        S3(ii).xd=rand*50;
        S3(ii).yd=rand*50;
        plot(S3(ii).xd,S3(ii).yd,'go')
        xlabel('x-axes(m)','FontSize',8);
        ylabel('y-axes(m)','FontSize',8);
        hold on
        S3(ii).E=Eo;
        S3(ii).Q=0;
    end
    if(ii>25 && ii<51)
        S3(ii).xd=rand*50;
        S3(ii).yd=50+rand*50;
        plot(S3(ii).xd,S3(ii).yd,'m*')
        hold on
        S3(ii).E=Eo;
        S3(ii).Q=0;
    end
    if(ii>50 && ii<76)
        S3(ii).xd=50+rand*50;
        S3(ii).yd=50+rand*50;
        plot(S3(ii).xd,S3(ii).yd,'r.')
        hold on
        S3(ii).E=Eo;
        S3(ii).Q=0;
    end
    if(ii>75)
        S3(ii).xd=50+rand*50;
        S3(ii).yd=rand*50;
        hold on
        plot(S3(ii).xd,S3(ii).yd,'b+')
        S3(ii).E=Eo;
        S3(ii).Q=0;
    end%%%%%%%
end

flag_first_dead1=0;     %%Flag for first dead node in the 1st quarter
flag_first_dead2=0;
flag_first_dead3=0;
flag_first_dead4=0;
flag_all_dead1=0;       %%Flag for all nodes dead for 1st quarter
flag_all_dead2=0;
flag_all_dead3=0;
flag_all_dead4=0;
dead1=0;        %Counts number of dead nodes in the 1st quarter
dead2=0;
dead3=0;
dead4=0;
first_dead1=0;      %stores value of round number when 1st node of 1st quarter dies
first_dead2=0;
first_dead3=0;
first_dead4=0;
all_dead1=0;        %stores value of round number when all nodes of 1st quarter die
all_dead2=0;
all_dead3=0;
all_dead4=0;
alive1=25;
alive2=25;
alive3=25;
alive4=25;
% % % counter for bit transmitted to Base Station
packets_TO_BS1=0;
temp_L_node1=0;
temp_L_node2=0;
temp_L_node3=0;
temp_L_node4=0;
% figure(1);
x=0;
ym=50;% % this variable controls the speed of sink%%
for ii=1:node_number
    S3(ii).parent=0;        %%Initializing all nodes parents and children to zero
    S3(ii).children=zeros(1,100);
end
RENERGY1=zeros(1,rmax+1);
for r3=0:rmax     
    %r3
    for ii=1:node_number
        S3(ii).parent=0;
        S3(ii).children=zeros(1,100);
    end
    for ii=1:node_number
        RENERGY1(r3+1) =RENERGY1(r3+1)+S3(ii).E;
    end
    A1=zeros(25,25);
    B1=zeros(50,50);
    C1=zeros(75,75);
    D1=zeros(100,100);
    for ii=1:1:25%flags for the calculation of first ,tenth, half and all nodes ..
        if (S3(ii).E<=0 && dead1<25)    %%If energy less than zero 
            dead1=dead1+1;  %%increment no of dead nodes
            if (dead1==1)   %%if its the first dead node
                if(flag_first_dead1==0) %%if the flag for first dead node is zero
                    first_dead1=r3+1;   %%store the round value
                    flag_first_dead1=1; %%increment flag for first dead node
                end
            end
            if(dead1==25)
                if(flag_all_dead1==0)
                    all_dead1=r3+1;
                    flag_all_dead1=1;
                end
            end
        end
    end
    for ii=26:1:50%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(ii).E<=0 && dead2<25)
            dead2=dead2+1;
            if (dead2==1)
                if(flag_first_dead2==0)
                    first_dead2=r3+1;
                    flag_first_dead2=1;
                end
            end
            if(dead2==25)
                if(flag_all_dead2==0)
                    all_dead2=r3+1;
                    flag_all_dead2=1;
                end
            end
        end
    end
    for ii=51:1:75%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(ii).E<=0 && dead3<25)
            dead3=dead3+1;
            if (dead3==1)
                if(flag_first_dead3==0)
                    first_dead3=r3+1;
                    flag_first_dead3=1;
                end
            end
            if(dead3==25)
                if(flag_all_dead3==0)
                    all_dead3=r3+1;
                    flag_all_dead3=1;
                end
            end
        end
    end
    for ii=76:1:100%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(ii).E<=0 && dead4 <25)
            dead4=dead4+1;
            if (dead4==1)
                if(flag_first_dead4==0)
                    first_dead4=r3+1;
                    flag_first_dead4=1;
                end
            end
            if(dead4==25)
                if(flag_all_dead4==0)
                    all_dead4=r3+1;
                    flag_all_dead4=1;
                end
            end
        end
    end
    STATISTICS3(r3+1).ALIVE1=alive1-dead1;
    STATISTICS3(r3+1).Et1=0;%total energy of nodes in a round
    STATISTICS3(r3+1).ALIVE2=alive2-dead2;
    STATISTICS3(r3+1).Et2=0;%total energy of nodes in a round
    STATISTICS3(r3+1).ALIVE3=alive3-dead3;
    STATISTICS3(r3+1).Et3=0;%total energy of nodes in a round
    STATISTICS3(r3+1).ALIVE4=alive4-dead4;
    STATISTICS3(r3+1).Et4=0;%total energy of nodes in a round
    STATISTICS3(r3+1).DEAD5=dead1+dead2+dead3+dead4;
    STATISTICS3(r3+1).ALIVE5=(STATISTICS3(r3+1).ALIVE1+STATISTICS3(r3+1).ALIVE2+STATISTICS3(r3+1).ALIVE3+STATISTICS3(r3+1).ALIVE4);
    
    for ii=1:1:25
        if (S3(ii).E>0)
            STATISTICS3(r3+1).Et1=STATISTICS3(r3+1).Et1 + S3(ii).E;
        end
    end
    if (STATISTICS3(r3+1).ALIVE1>0)
        STATISTICS3(r3+1).Eavg1=STATISTICS3(r3+1).Et1/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg1=0;
    end
    for ii=26:1:50
        if (S3(ii).E>0)
            STATISTICS3(r3+1).Et2=STATISTICS3(r3+1).Et2 + S3(ii).E;
        end
    end
    if (STATISTICS3(r3+1).ALIVE2>0)
        STATISTICS3(r3+1).Eavg2=STATISTICS3(r3+1).Et2/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg2=0;
    end
    for ii=51:1:75
        if (S3(ii).E>0)
            STATISTICS3(r3+1).Et3=STATISTICS3(r3+1).Et3 + S3(ii).E;
        end
    end
    if (STATISTICS3(r3+1).ALIVE3>0)
        STATISTICS3(r3+1).Eavg3=STATISTICS3(r3+1).Et3/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg3=0;
    end
    for ii=76:1:100
        if (S3(ii).E>0)
            STATISTICS3(r3+1).Et4=STATISTICS3(r3+1).Et4 + S3(ii).E;
        end
    end
    if (STATISTICS3(r3+1).ALIVE4>0)
        STATISTICS3(r3+1).Eavg4=STATISTICS3(r3+1).Et4/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg4=0;
    end
    STATISTICS3(r3+1).Eavg5=(STATISTICS3(r3+1).Eavg1+STATISTICS3(r3+1).Eavg2+STATISTICS3(r3+1).Eavg3+STATISTICS3(r3+1).Eavg4)/4;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%allignment of alive nodes for the
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%formation of chains%%%%%%%%%%%%%%%%%%%%%%%%
    A=zeros(1,STATISTICS3(r3+1).ALIVE1);
    for ii=1:1:25
        if S3(ii).E>0
            A(1)=ii;
            break;
        end
    end
     
    for ii=2:STATISTICS3(r3+1).ALIVE1
        for j=(A(ii-1)+1):25,
            if S3(j).E>0
                A(ii)=j;
                break;
            end
        end
    end
    B=zeros(1,STATISTICS3(r3+1).ALIVE2);
    for ii=26:1:50
        if S3(ii).E>0
            B(1)=ii;
            break;
        end
    end
     
    for ii=2:(STATISTICS3(r3+1).ALIVE2)
        for j=(B(ii-1)+1):50,
            if S3(j).E>0
                B(ii)=j;
                break;
            end
        end
    end
    C=zeros(1,STATISTICS3(r3+1).ALLIVE3);
    for ii=51:1:75
        if S3(ii).E>0
            C(1)=ii;
            break;
        end
    end
    
    B=zeros(1,STATISTICS3(r3+1).ALIVE2);
    for ii=26:1:50
        if S3(ii).E>0
            B(1)=ii;
            break;
        end
    end
     
    for ii=2:(STATISTICS3(r3+1).ALIVE2)
        for j=(B(ii-1)+1):50,
            if S3(j).E>0
                B(ii)=j;
                break;
            end
        end
    end
    C=zeros(1,STATISTICS3(r3+1).ALIVE3);
    for ii=51:1:75
        if S3(ii).E>0
            C(1)=ii;
            break;
        end
    end
     
    for ii=2:(STATISTICS3(r3+1).ALIVE3)
        for j=(C(ii-1)+1):75,
            if S3(j).E>0
                C(ii)=j;
                break;
            end
        end
    end
    D=zeros(1,STATISTICS3(r3+1).ALIVE4);
    for ii=76:1:100
        if S3(ii).E>0
            D(1)=ii;
            break;
        end
    end
     
    for ii=2:(STATISTICS3(r3+1).ALIVE4)
        for j=(D(ii-1)+1):100,
            if S3(j).E>0
                D(ii)=j;
                break;
            end
        end
    end
    hold off;
    
    %figure(1);%%%%%%%%%%%%%%%%%movement of sink for region 1 chain formation%%%%%%%%%%
    x=x+33;
    sink.x=x;
    sink.y=25;
    %plot(sink.x,sink.y,'ko')
    hold on;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    distance1=zeros(1,STATISTICS3(r3+1).ALIVE1);
    max_distance1=0;
    max_node1=0;
    distance2=zeros(1,STATISTICS3(r3+1).ALIVE2);
    max_distance2=0;
    max_node2=0;
    distance3=zeros(1,STATISTICS3(r3+1).ALIVE3);
    max_distance3=0;
    max_node3=0;
    distance4=zeros(1,STATISTICS3(r3+1).ALIVE4);
    max_distance4=0;
    max_node4=0;
    
    for ii=1:STATISTICS3(r3+1).ALIVE1%%%calculating sink distance from all nodes and finding farthest node
        S3(A(ii)).distance1=sqrt((S3(A(ii)).xd - sink.x)^2+(S3(A(ii)).yd - sink.y)^2);
        if max_distance1<S3(A(ii)).distance1
            max_distance1=S3(A(ii)).distance1;
            max_node1=(A(ii));
        end
    end
    
    for ii= 1:STATISTICS3(r3+1).ALIVE2%%%calculating sink distance from all nodes and finding farthest node 
        S3(B(ii)).distance2= sqrt((S3(B(ii)).xd - sink.x)^2+(S3(B(ii)).yd - sink.y)^2);
        if max_distance2<S3(B(ii)).distance2
            max_distance2= S3(B(ii)).distance2;
            max_node2= (B(ii));
        end
    end
    
    for ii = 1:STATISTICS3(r3+1).ALIVE3
        S3(C(ii)).distance3= sqrt((S3(C(ii)).xd - sink.x)^2+(S3(C(ii)).yd - sink.y)^2);
        if max_distance3<S3(C(ii)).distance3
            max_distance3= S3(C(ii)).distance3;
            max_node3= (C(ii));
        end
    end
    
   
    for ii = 1: STATISTICS3(r3+1).ALIVE4
        S3(D(ii)).distance4= sqrt((S3(D(ii)).xd-sink.x)^2+(S3(D(ii)).yd-sink.y)^2);
        if max_distance4<S3(D(ii)).distance4
            max_distance4= S3(D(ii)).distance4;
            max_node4= (D(ii));
        end
    end
    %chain of 1
    connect_distance1= zeros(1,STATISTICS3(r3+1).ALIVE1);
    connect_node1= zeros(1,STATISTICS3(r3+1).ALIVE1);
    connect_node1(1)= max_node1;
    connect_distance1(1)= 0;
    
    % chain formation between the alive in each round
    for ii= 2:STATISTICS3(r3+1).ALIVE1
        temp_node1=0;
        temp_min_distance1=inf;
        
        for j = 1:STATISTICS3(r3+1).ALIVE1
            b1 = 0;
            for k= 1:(ii-1)
                if A(j)== connect_node1(k);
                    b1 = 1;
                    break;
                end
            end
            if b1 == 0% nearest any not connected
                distance1= sqrt((S3(connect_node1(ii-1)).xd-S3(A(j)).xd)^2 + (S3(connect_node1(ii-1)).yd- S3(A(j)).yd)^2);
                if temp_min_distance1 > distance1
                    temp_min_distance1 = distance1;
                    temp_node1 = A(j);
                end
            end
        end
        
        connect_distance1(ii)=temp_min_distance1;
        connect_node1(ii)=temp_node1;
        A1(connect_node1(ii),connect_node1(ii-1))=1;%if calculated minimum distance is less than threshold
        A1(connect_node1(ii-1),connect_node1(ii))=1;
        
        plot([S3(connect_node1(ii-1)).xd S3(connect_node1(ii)).xd],[S3(connect_node1(ii-1)).yd S3(connect_node1(ii)).yd],'-+');
        hold on;
    end
    if STATISTICS3(r3+1).ALIVE1 == 1
        A1(connect_node1(1),connect_node1(1)) = 1;
    end
    %         %energy calculation for nodes in region 1
    Q_max=0;
    L_node1(r3+1)=temp_L_node1;%temorary leader node
    
    for ii=1:STATISTICS3(r3+1).ALIVE1%%chain leader selection
        distance_to_bs1(A(ii))=sqrt((S3(A(ii)).xd-sink.x)^2+(S3(A(ii)).yd-sink.y)^2);%%
        S3(A(ii)).Q=S3(A(ii)).E/distance_to_bs1(A(ii));%%ratio between the energy and distance of each node to BS1
        if  Q_max<S3(A(ii)).Q 
            Q_max=S3(A(ii)).Q;
            L_node1(r3+1)=A(ii);    %finding most optimal leader with highest weight
        end
        temp_L_node1= L_node1(r3+1);
        k1= zeros(1,25);
        k1(1)= temp_L_node1;    %placing the in each round at start of chain array
        f1= zeros(1,(25+1));
        for j0= 1:25
            if A1(k1(1),j0) == 1
                f1(2)= f1(2)+1;
                k1(f1(2)+1)= j0;
                S3(k1(1)).children(f1(2))= j0;
            end
        end
        for j1= 2:(25+1)
            if f1(j1)~= 0
                for t1= 1:f1(j1)
                    t= sum(f1(1:(j1-1)))+t1+1;
                    S3(k1(t)).parent= k1(j1-1);
                end
            end
        end
        for j2= 1:25
            if A1(k1(t),j2) == 1
                if S3(k1(t)).parent ~= j2
                    f1(t+1)= f1(t+1)+1;
                    k1(sum(f1(1:t))+1+f1(t+1))= j2;
                    S3(k1(t)).children(f1(t+1))= j2;
                end
            end
        end
    end
        %%%%%%%%%%%%%%%%%%%
    distance_send1= zeros(1,100);
    distance_send2= zeros(1,100);
    child_count1= zeros(1,100);%%counter for all child nodes
    
    for ii= 1:25
        if S3(ii).E>=0%%%%%selection of secondary leader node in region 1
            if S3(ii).parent~=0
                distance_send1(ii)=sqrt((S3(ii).xd-S3(S3(ii).parent).xd)^2+(S3(ii).yd-S3(S3(ii).parent).yd)^2);
                distance_send2(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);
                if distance_send1(ii)>distance_send2(ii),
                   distance_send1(ii)=distance_send2(ii);
                    S3(ii).parent=0;
                    if f1(find(k1>(ii-1)&k1<(ii+1)))==1,
                        f1(find(k1>(ii-1)&k1<(ii+1)))=0;
                    else
                        f1(find(k1>(ii-1)&k1<(ii+1)))=1;
                    end
                end
            else
                distance_send1(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for ii=1:25
        x = 0;
        for i = 1 : length(k1)
            if k1(i) > (ii-1) && k1(i) > (ii+1)
                x = i;
            end
        end
        if x == 0
            x = 1;
        else
            x = x+1;
        end
        child_count1(ii)=f1(x);
       % end
    end
    for ii=1:STATISTICS3(r3+1).ALIVE1%%energy calculation on the basis of child nodes of each node
        if child_count1(A(ii))==0                     %if only 1 child node
            if  distance_send1(A(ii))>do
                S3(A(ii)).E=S3(A(ii)).E-(ETX*datanum+datanum*Emp*((distance_send1(A(ii)))^4));
            else
                S3(A(ii)).E=S3(A(ii)).E-(ETX*datanum+datanum*Efs*((distance_send1(A(ii)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(A(ii))>do
                S3(A(ii)).E=S3(A(ii)).E-((child_count1(A(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(A(ii)))^4)));
            else
                S3(A(ii)).E=S3(A(ii)).E-((child_count1(A(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(A(ii)))^2)));
            end
        end
    end
    for ii=1:STATISTICS3(r3+1).ALIVE1%any node having child consumes ERX equal to childs
                S3(A(ii)).E=S3(A(ii)).E-(child_count1(A(ii))*ERX*datanum);
    end
    if (x==66)%%%movement of sink for the chain formation in region 2%%%%
        x=0;
    end
    if (x==33)
        ym=75;
    end
    sink.x=x;
    sink.y=ym;
    
    %     %     for nodes 26.....
    connect_distance2=zeros(1,STATISTICS3(r3+1).ALIVE2);%
    connect_node2=zeros(1,STATISTICS3(r3+1).ALIVE2);%
    connect_node2(1)=max_node2;
    connect_distance2(1)=0;
    
    for ii=2:STATISTICS3(r3+1).ALIVE2%%%%chain formation between the alive nodes in each round
        temp_node2=0;
        temp_min_distance2=inf;
        for j=1:STATISTICS3(r3+1).ALIVE2
            b2=0;
            for k=1:(ii-1)
                if B(j)==connect_node2(k)
                    b2=1;
                    break
                end
            end
            if b2==0%%finding the nearest node for any node not connected in chain
                distance2=sqrt((S3(connect_node2(ii-1)).xd - S3(B(j)).xd)^2 + (S3(connect_node2(ii-1)).yd - S3(B(j)).yd)^2);
                if temp_min_distance2>distance2
                    temp_min_distance2=distance2;
                    temp_node2=B(j);
                end
            end
        end
    connect_distance2(ii)=temp_min_distance2;
    connect_node2(ii)=temp_node2;
        B1(connect_node2(ii),connect_node2(ii-1))=1;%if calculated minimum distance is less than threshold
        B1(connect_node2(ii-1),connect_node2(ii))=1;
        plot([S3(connect_node2(ii-1)).xd S3(connect_node2(ii)).xd],[S3(connect_node2(ii-1)).yd S3(connect_node2(ii)).yd],'-+');
        hold on;
    end
    if STATISTICS3(r3+1).ALIVE2 == 1
        B1(connect_node2(1),connect_node2(1))=1;
    end
    %     %     %energy calculation for nodes in region 2
    Q_max2=0;
    L_node2(r3+1)=temp_L_node2;%temorary leader node
    for ii=1:STATISTICS3(r3+1).ALIVE2%%chain leader selection
        distance_to_bs2(B(ii))=sqrt((S3(B(ii)).xd-sink.x)^2+(S3(B(ii)).yd-sink.y)^2);%%
        S3(B(ii)).Q=S3(B(ii)).E/distance_to_bs2(B(ii));%%ratio between the energy and distance of each node to BS
        if  Q_max2<S3(B(ii)).Q 
            Q_max2=S3(B(ii)).Q;
            L_node2(r3+1)=B(ii);    %finding most optimal leader with highest weight
        end
        temp_L_node2= L_node2(r3+1);
        k2= zeros(1,25);
        k2(1)= temp_L_node2;    %placing the in each round at start of chain array
        f2= zeros(1,(25+1));
        for j0= 26:50
            if B1(k2(1),j0) == 1
                f2(2)= f2(2)+1;
                k2(f2(2)+1)= j0;
                S3(k2(1)).children(f2(2))= j0;
            end
        end
        %k2
        for j1= 2:(25+1)
            if f2(j1)~= 0
                for t2= 1:f2(j1)
                    t= sum(f2(1:(j1-1)))+t2+1;
                    S3(k2(t)).parent= k2(j1-1);
                end
            end
        end
        %t
        for j2= 26:50
            if B1(k2(t),j2) == 1
                if S3(k2(t)).parent ~= j2
                    f2(t+1)= f2(t+1)+1;
                    k2(sum(f2(1:t))+1+f2(t+1))= j2;
                    S3(k2(t)).children(f2(t+1))= j2;
                end
            end
        end
    end
        %%%%%%%%%%%%%%%%%%%
    distance_send1= zeros(1,100);
    distance_send2= zeros(1,100);
    child_count2= zeros(1,100);%%counter for all child nodes
    
    for ii= 26:50
        if S3(ii).E>=0%%%%%selection of secondary leader node in region 1
            if S3(ii).parent~=0
                distance_send1(ii)=sqrt((S3(ii).xd-S3(S3(ii).parent).xd)^2+(S3(ii).yd-S3(S3(ii).parent).yd)^2);
                distance_send2(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);
                if distance_send1(ii)>distance_send2(ii),
                   distance_send1(ii)=distance_send2(ii);
                    S3(ii).parent=0;
                    if f2(find(k2>(ii-1)&k2<(ii+1)))==1,
                        f2(find(k2>(ii-1)&k2<(ii+1)))=0;
                    else
                        f2(find(k2>(ii-1)&k2<(ii+1)))=1;
                    end
                end
            else
                distance_send1(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for ii=26:50
        x = 0;
        for i = 1 : length(k2)
            if k2(i) > (ii-1) && k2(i) > (ii+1)
                x = i;
            end
        end
        if x == 0
            x = 1;
        else
            x = x+1;
        end
        child_count1(ii)=f2(x);
        %end
    end
    for ii=1:STATISTICS3(r3+1).ALIVE2%%energy calculation on the basis of child nodes of each node
        if child_count1(B(ii))==0                     %if only 1 child node
            if  distance_send1(B(ii))>do
                S3(B(ii)).E=S3(B(ii)).E-(ETX*datanum+datanum*Emp*((distance_send1(B(ii)))^4));
            else
                S3(B(ii)).E=S3(B(ii)).E-(ETX*datanum+datanum*Efs*((distance_send1(B(ii)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(B(ii))>do
                S3(B(ii)).E=S3(B(ii)).E-((child_count1(B(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(B(ii)))^4)));
            else
                S3(B(ii)).E=S3(B(ii)).E-((child_count1(B(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(B(ii)))^2)));
            end
        end
    end
    for ii=1:STATISTICS3(r3+1).ALLIVE2%any node having child consumes ERX equal to childs
        S3(B(ii)).E=S3(B(ii)).E-(child_count1(B(ii))*ERX*datanum);
    end
    
    x=x+33;%%%%movement of sink in region 3 for chain formation
    hold on
%     figure(1)
    sink.x=x;
%     plot(sink.x,sink.y,'ro');
    hold on
     
    %     %    chain formation for nodes 51.....
    connect_distance3=zeros(1,STATISTICS3(r3+1).ALIVE3);%
    connect_node3=zeros(1,STATISTICS3(r3+1).ALIVE3);%
    connect_node3(1)=max_node3;
    connect_distance3(1)=0;
    for ii=2:STATISTICS3(r3+1).ALIVE3%%%%chain formation between the alive nodes in each round
        temp_node3=0;
        temp_min_distance3=inf;
        for j=1:STATISTICS3(r3+1).ALIVE3
            b3=0;
            for k=1:(ii-1)
                if C(j)==connect_node3(k)
                    b3=1;
                    break
                end
            end
            if b3==0%%finding the nearest node for any node not connected in chain
                distance3=sqrt((S3(connect_node3(ii-1)).xd - S3(C(j)).xd)^2 + (S3(connect_node3(ii-1)).yd - S3(C(j)).yd)^2);
                if temp_min_distance3>distance3
                    temp_min_distance3=distance3;
                    temp_node3=C(j);
                end
            end
        end
    
        connect_distance3(ii)=temp_min_distance3;
        connect_node3(ii)=temp_node3;
            C1(connect_node3(ii),connect_node3(ii-1))=1;%if calculated minimum distance is less than threshold
            C1(connect_node3(ii-1),connect_node3(ii))=1;
            plot([S3(connect_node3(ii-1)).xd S3(connect_node3(ii)).xd],[S3(connect_node3(ii-1)).yd S3(connect_node3(ii)).yd],'-o');
            hold on;
    end
    if STATISTICS3(r3+1).ALIVE3 == 1
        C1(connect_node3(1),connect_node3(1)) = 1;
    end
    Q_max3=0;
    L_node3(r3+1)=temp_L_node3;%temorary leader node
    for ii=1:STATISTICS3(r3+1).ALIVE3%%chain leader selection
        distance_to_bs3(C(ii))=sqrt((S3(C(ii)).xd-sink.x)^2+(S3(C(ii)).yd-sink.y)^2);%%
        S3(C(ii)).Q=S3(C(ii)).E/distance_to_bs3(C(ii));%%ratio between the energy and distance of each node to BS
        if  Q_max3<S3(C(ii)).Q
            Q_max3=S3(C(ii)).Q;
            L_node3(r3+1)=C(ii);    %finding most optimal leader with highest weight
        end
            temp_L_node3= L_node3(r3+1); 
            k3= zeros(1,25);
            k3(1)= temp_L_node3;    %placing the in each round at start of chain array
            f3=zeros(1,(25+1));
            for j0= 51:75
                if C1(k3(1),j0) == 1
                    f3(2)= f3(2)+1;
                    k3(f3(2)+1)= j0;
                    S3(k3(1)).children(f3(2))= j0;
                end
            end
            for j1= 2:(25+1)
                if f3(j1)~= 0
                    for t1= 1:f3(j1)
                        t= sum(f3(1:(j1-1)))+t1+1;
                        S3(k3(t)).parent= k3(j1-1);
                    end
                end
            end
            for j2= 51:75
                if C1(k3(t),j2) == 1
                    if S3(k3(t)).parent ~= j2
                        f3(t+1)= f3(t+1)+1;
                        k3(sum(f3(1:t))+1+f3(t+1)) = j2;
                        S3(k3(t)).children(f3(t+1))= j2;
                    end
                end
            end
    end
    distance_send1= zeros(1,100);
    distance_send2= zeros(1,100);
    
    for ii= 51:75 
        if S3(ii).E >= 0
            if S3(ii).parent~=0%%%%%secondary leader selection in region 3
                distance_send1(ii)=sqrt((S3(ii).xd-S3(S3(ii).parent).xd)^2+(S3(ii).yd-S3(S3(ii).parent).yd)^2);
                distance_send2(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);
                if distance_send1(ii)>distance_send2(ii),
                    distance_send1(ii)=distance_send2(ii);
                    S3(ii).parent=0;
                    if f3(find(k3>(ii-1)&k3<(ii+1)))==1,
                        f3(find(k3>(ii-1)&k3<(ii+1)))=0;
                    else
                        f3(find(k3>(ii-1)&k3<(ii+1)))=1;
                    end
                end
            else
                distance_send1(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for ii=51:75
        x = 0;
        for i = 1 : length(k3)
            if k3(i) > (ii-1) && k3(i) > (ii+1)
                x = i;
            end
        end
        if x == 0
            x = 1;
        else
            x = x+1;
        end
        child_count1(ii)=f3(x);
        %end
    end
    
    for ii=1:STATISTICS3(r3+1).ALIVE3%%energy calculation on the basis of child nodes of each node
        if child_count1(C(ii))==0                     %if only 1 child node
            if  distance_send1(C(ii))>do
                S3(C(ii)).E=S3(C(ii)).E-(ETX*datanum+datanum*Emp*((distance_send1(C(ii)))^4));
            else
                S3(C(ii)).E=S3(C(ii)).E-(ETX*datanum+datanum*Efs*((distance_send1(C(ii)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(C(ii))>do
                S3(C(ii)).E=S3(C(ii)).E-((child_count1(C(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(C(ii)))^4)));
            else
                S3(C(ii)).E=S3(C(ii)).E-((child_count1(C(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(C(ii)))^2)));
            end
        end
    end
    
    for ii=1:STATISTICS3(r3+1).ALIVE3%any node having child consumes ERX equal to childs
        S3(C(ii)).E=S3(C(ii)).E-(child_count1(C(ii))*ERX*datanum);
    end
    if x==66,%%%%%%%movement of sink for the chain formation in region 4
    ym=25;
    end
    hold on
    % figure(1)
    sink.x=x;
    sink.y=ym;
    % plot(sink.x,sink.y,'ro');
    hold on
    
    %     %   chain formation  for nodes  76....
    connect_distance4=zeros(1,STATISTICS3(r3+1).ALIVE4);%
    connect_node4=zeros(1,STATISTICS3(r3+1).ALIVE4);%
    connect_node4(1)=max_node4;
    connect_distance4(1)=0;
    
    for ii=2:STATISTICS3(r3+1).ALIVE4%%%%chain formation between the alive nodes in each round
        temp_node4=0;
        temp_min_distance4=inf;
        for j=1:STATISTICS3(r3+1).ALIVE4
            b4=0;
            for k=1:(ii-1)
                if D(j)==connect_node4(k)
                    b4=1;
                    break
                end
            end
            if b4==0%%finding the nearest node for any node not connected in chain
                distance4=sqrt((S3(connect_node4(ii-1)).xd - S3(D(j)).xd)^2 + (S3(connect_node4(ii-1)).yd - S3(D(j)).yd)^2);
                if temp_min_distance4>distance4
                    temp_min_distance4=distance4;
                    temp_node4=D(j);
                end
            end
        end
        connect_distance4(ii)=temp_min_distance4;
        connect_node4(ii)=temp_node4;
        D1(connect_node4(ii),connect_node4(ii-1))=1;%if calculated minimum distance is less than threshold
        D1(connect_node4(ii-1),connect_node4(ii))=1;
        plot([S3(connect_node4(ii-1)).xd S3(connect_node4(ii)).xd],[S3(connect_node4(ii-1)).yd S3(connect_node4(ii)).yd],'-o');
        hold on;
    end
    if STATISTICS3(r3+1).ALIVE4 == 1
        D1(connect_node4(1),connect_node4(1)) = 1;
    end
    %energy calculation for nodes 4
    Q_max3=0;
    L_node4(r3+1)=temp_L_node4;%temorary leader node
    for ii=1:STATISTICS3(r3+1).ALIVE4%%chain leader selection
        distance_to_bs1(D(ii))=sqrt((S3(D(ii)).xd-sink.x)^2+(S3(D(ii)).yd-sink.y)^2);%%
        S3(D(ii)).Q=S3(D(ii)).E/distance_to_bs1(D(ii));%%ratio between the energy and distance of each node to BS
        if  Q_max3<S3(D(ii)).Q
            Q_max3=S3(D(ii)).Q;
            L_node4(r3+1)=D(ii);    %finding most optimal leader with highest weight 
        end
        
        temp_L_node4= L_node4(r3+1); 
            k4= zeros(1,25);
            k4(1)= temp_L_node4;    %placing the in each round at start of chain array
            f4=zeros(1,(25+1));
            for j0= 76:100
                if D1(k4(1),j0) == 1
                    f4(2)= f4(2)+1;
                    k4(f4(2)+1)= j0;
                    S3(k4(1)).children(f4(2))= j0;
                end
                %k4
            end    
            
        for j1= 2:(25+1)
            if f4(j1)~= 0
                for t1= 1:f4(j1)
                    t= sum(f4(1:(j1-1)))+t1+1;
                    S3(k4(t)).parent= k4(j1-1);
                end
            end
        end
%         k4
%         t
        for j2= 76:100
            
            if D1(k4(t),j2) == 1
                if S3(k4(t)).parent ~= j2
                    f4(t+1)= f4(t+1)+1;
                    k4(sum(f4(1:t))+1+f4(t+1)) = j2;
                    S3(k4(t)).children(f4(t+1))= j2;
                end
            end
        end
    end
    distance_send1= zeros(1,100);
    distance_send2= zeros(1,100);
    
    for ii= 76:100 
        if S3(ii).E >= 0
            if S3(ii).parent~=0%%%%%secondary leader selection in region 3
                distance_send1(ii)=sqrt((S3(ii).xd-S3(S3(ii).parent).xd)^2+(S3(ii).yd-S3(S3(ii).parent).yd)^2);
                distance_send2(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);
                if distance_send1(ii)>distance_send2(ii),
                    distance_send1(ii)=distance_send2(ii);
                    S3(ii).parent=0;
                    if f4(find(k4>(ii-1)&k4<(ii+1)))==1,
                        f4(find(k4>(ii-1)&k4<(ii+1)))=0;
                    else
                        f4(find(k4>(ii-1)&k4<(ii+1)))=1;
                    end
                end
            else
                distance_send1(ii)=sqrt((S3(ii).xd-sink.x)^2+(S3(ii).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for ii=76:100
        x = 0;
        for i = 1 : length(k4)
            if k4(i) > (ii-1) && k4(i) > (ii+1)
                x = i;
            end
        end
        if x == 0
            x = 1;
        else
            x = x+1;
        end
        child_count1(ii)=f4(x);
        %end
    end
    
    for ii=1:STATISTICS3(r3+1).ALIVE4%%energy calculation on the basis of child nodes of each node
        if child_count1(D(ii))==0                     %if only 1 child node
            if  distance_send1(D(ii))>do
                S3(D(ii)).E=S3(D(ii)).E-(ETX*datanum+datanum*Emp*((distance_send1(D(ii)))^4));
            else
                S3(D(ii)).E=S3(D(ii)).E-(ETX*datanum+datanum*Efs*((distance_send1(D(ii)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(D(ii))>do
                S3(D(ii)).E=S3(D(ii)).E-((child_count1(D(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(D(ii)))^4)));
            else
                S3(D(ii)).E=S3(D(ii)).E-((child_count1(D(ii))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(D(ii)))^2)));
            end
        end
    end
    
    for ii=1:STATISTICS3(r3+1).ALIVE4%any node having child consumes ERX equal to childs
        S3(D(ii)).E=S3(D(ii)).E-(child_count1(D(ii))*ERX*datanum);
    end
    if (x==66)
        x=0;
    end
    
end

r3=0:rmax;
figure(2);
%plot(r3,RENERGY1-25,'-g'); % to remove excess residual energy 
legend('4 chains with Mobile sink at center of 4 chains');
xlabel('Number of Round');
ylabel('Residual Energy');
% title('Heterogeneous nodes');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   STATISTICS    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  first_dead1/first_dead2/first_dead3/first_dead4 :stores value of round number when 1st node of selected quarter dies
%all_dead1/all_dead2/all_dead3/all-dead4:stores value of round number when all nodes of selected quarter die
% data_num: size of the packet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reference: Mohsin Raza Jafri-Maximizing the Lifetime of Multi-chain PEGASIS using Sink Mobility
%ComSense (Communication over sensors) Research Group.
%COMSATS Institute of Information Technology,Islamabad,Pakistan.