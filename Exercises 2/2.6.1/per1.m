%per1.m
%Author: Sean Devonport - g12d0625
%A script that implements the multiple neuron perceptron

%% User input
%user input for P and T matrices:
col = [0 0; 0 0]; %variables for dimensions of P and T [Pm Tm;Pr Ts]
checkm = false;
while(checkm==false)
    P=input('P is the matrix of patterns and is rxm:\n');
    T=input('T is the matrix of targets and is sxm:\n');
    col = [size(P,2) size(T,2); size(P,1) size(T,1)];
    if(col(1) == col(3))
        checkm = true;
    else
        fprintf('Please try again, wrong dimensions\n');
    end

end
%% Construct and Train:

%initiate weight matrices and bias randomly.
W=rand(col(4),col(2)); %initiate weight matrix with dimensions sxr
b=rand(col(4),1); %initiiate bias sx1

Pa=[P;ones(1,col(1))];
Wa = [W b];

A= hardlim(Wa*Pa); %calculate initial activations

E = T - A;%initial Error matrix
WW = W; %weight matrix to be modified.

iter = 0; %set up counter for iterations.
iterplot = []; %array for SSE vs iter plot
sumplot = []; %array for SSE vs iter plot

%% Train perceptron

while(sum(sum(E.^2)) ~= 0 && iter < 50)
    hold on;
    sumplot = [sumplot sum(sum(E.^2))]; %collect sum of errors reuslts for ploting
    iterplot = [iterplot iter]; %collect amount of iterations for plot
    plot(iterplot,sumplot); %plot SSE vs iterations
    xlabel('iterations');
    ylabel('SSE');

    dWa=E*Pa';
    WW = WW + dWa(:,1:3); %modify weight matrix
    b = b + dWa(:,4); %modify bias
    Wa = [WW b];
    Na=Wa*Pa; %calculate batch vector.

    A=hardlim(Na);  %calculate activations (as batch)
    
    iter = iter + 1; %halting counter.

    E = T-A; %Calculate new errors.
end

if (iter ~= 50)   
    %% Display results:

    fprintf('Iterations: ');
    display(iter);
    fprintf('Final weight: ');
    display(W);
    fprintf('bias: ');
    display(b);

    rep = 1;
    while (rep == true)
        classify = input('Classify another point? 1=yes, 0=no\n');
        if(classify)
            pcheck = 1;
           while(pcheck)
                p = input('Please input new point\n p= ');
                if(length(p) ~= col(2))
                    fprintf('Please enter correct dimension for p\n');
                else                   
                    pcheck = 0;
                end
           end
           a = hardlim(W*p' + b);
           display(a);
        end
        rep = input('repeat? 1=yes, 0=no\n');


    end
    hold off;
else
    %% Search Failed:
    fprintf('Search failed\n'); %if search is over 50 iterations.
end