% abalone_sup.m
% Author: Sean Devonport
% Script that tests many nets to check which is best suited for data set.
%%
clc;clear;close all;
%% Import and encode data
data=fopen('abalone.data');

D=textscan(data,'%c,%f,%f,%f,%f,%f,%f,%f,%f');

D1=[];
for i=1:size(D{1},1)
    if D{1}(i) == 'M'
        D1=[D1; 2];
    elseif D{1}(i) == 'F'
        D1=[D1; 1];
    else
        D1=[D1;0];
    end
end
p=[D1 D{2} D{3} D{4} D{5} D{6} D{7} D{8}]';
t=D{9}';

[r,q]=size(p);
close all
s1=150;
s2=80;
s3=20;

%create the net
net=newff(p,t,[s1,s2,s3]);

%display(net)

%training
net.trainFcn='trainscg';

%maxit
net.trainParam.epochs=100;

%set the number of epochs that the error on the validation set
%increases
net.trainParam.max_fail=20;
%         net.trainParam.mc = 0.1;
%         net.trainParam.lr = 1;
%We can also set using:
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

%initiate
net=init(net);

%train
[net,netstruct]=train(net,ptrain,ttrain);

%name the net and structure
net.userdata='abalone';
abanet=net;
abastruct=netstruct;
%network architecture
%layer sizes
S=[100:5:150];

%matrix to store the assessments
A=zeros(size(S,1),3);

for j=1:size(S,2)
    for i=1:size(S,2)
%         for k=1:size(S,2)
            close all
            s1=S(i);
            s2=S(j);
%             s3=S(k);

            %create the net
            net=newff(p,t,[s1,s2]);

            %display(net)

            %training
            net.trainFcn='trainscg';

            %maxit
            net.trainParam.epochs=100;

            %set the number of epochs that the error on the validation set
            %increases
            net.trainParam.max_fail=20;
    %         net.trainParam.mc = 0.1;
    %         net.trainParam.lr = 1;
            %We can also set using:
            [ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
            [ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

            %initiate
            net=init(net);

            %train
            [net,netstruct]=train(net,ptrain,ttrain);

            %name the net and structure
            net.userdata='abalone';
            abanet=net;
            abastruct=netstruct;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%
            q1=size(ptrain,2);
            %using our own hand-made net:
            q2=size(ptest,2);
            %simulate
            atrain=sim(abanet,ptrain); %train
            atest=sim(abanet,ptest);   %test
            a=sim(abanet,p);           %all

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %assessing the degree of fit
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Ar(i+1,1)=s1;
%             Ar(1,j+1)=s2;
%             Ar2(i+1,1)=s1;
%             Ar2(1,j+1)=s2;

            %train
            r2=rsq(ttrain,atrain);
            [R,PV]=corrcoef(ttrain,atrain);

            fprintf('Training:\n\n')
            fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
            disp('----------------------------------------------------------------------')

            figure
            plot(ttrain,ttrain,ttrain,atrain,'*')
            title(sprintf('training: With %g samples s1=s2=%g\n',q,s1))
            %------------------------------------------------------------------
            % test:
            r2=rsq(ttest,atest);
            [R,PV]=corrcoef(ttest,atest);

            Ar(i+1,j+1)=R(1,2);
            Ar2(i+1,j+1)=r2;

            fprintf('Testing:\n\n')
            fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
            disp('----------------------------------------------------------------------')

            figure
            plot(ttest,ttest,ttest,atest,'*')
            title(sprintf('Testing: With %g samples s1=s2=%g\n',q,s1))
            %-------------------------------------------------
%         end
    end
end
% disp('s1xs2 r2 r')
% fprintf('Corr coef on test set')
% Ar
% fprintf('R^2 value on test set')
% Ar2
