% Lab 2 Problem g

K=0.6;

nMax = 1000; %Number of iterations
nParam = 1000;

rArray = linspace(0.1,2.99,nParam);

xSS = zeros(nParam,300);

for iParam=1:nParam

    r = rArray(iParam);

    x = zeros(1,nMax); % Matrix to fill

    x(1) = 0.5; %initial starting population

for nt=2:nMax

    term2 = 1-(x(nt-1)/K);
    x(nt) = x(nt-1)+r*term2*x(nt-1);

end

if 0
    figure(1); clf; hold on; box on;
    plot(x(1:100), '-ok');
    ylabel('r values');
    xlabel('Population');

end

xSS(iParam,:) = x((end-size(xSS,2)+1):end);

end

save('xSS.mat', 'xSS');

figure(2); clf; hold on; box on;
plot(rArray,xSS, '.')
ylabel('Population');
xlabel('Growth Rate r');