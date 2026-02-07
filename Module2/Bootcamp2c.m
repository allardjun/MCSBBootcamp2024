r = 2.5; %Growth rate per Capita
K = 0.6; %Carrying Capacity

nMax = 100; %Number of months to simulate
x = zeros(1,nMax); % Matrix to fill
x(1) = 0.2; %initial starting population

for n=2:nMax

    term2 = 1-(x(n-1)/K);
    x(n) = x(n-1)+r*term2*x(n-1);

end

figure(1); 
plot(x,'-ok');
ylabel('Population')
xlabel('Time')