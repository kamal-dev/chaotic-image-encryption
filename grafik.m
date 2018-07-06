
function grafik(x,y)
    randIndex = randperm(numel(x));  
    randIndex = randIndex(1:2000);   
    xRand = x(randIndex);            
    yRand = y(randIndex); 
    xRand = xRand * 256;
    yRand = yRand * 256;  
    scatter(xRand,yRand,'.');
end