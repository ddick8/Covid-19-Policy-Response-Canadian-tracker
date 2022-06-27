clear

%Load Data 

PopulationExcelName = fullfile(pwd,'/data/populations.csv');

DegreeFile = fullfile(pwd,'/Provincial_Data.csv');

population = readtable(PopulationExcelName,...
    'Range','A2:R16'); %last Column represents the population of the corresponding province/territory as of 2020.

%Convert numberical data to an array type. 
populationSize = table2array(population(1:end,2:end));

%read all data
rawData = readtable(DegreeFile);

%create names cell vector
%Using region codes to avoid spaces
names = table2array(rawData(1:end,2));

%create restriction and date matrix
resMat = rawData(1:end,3:6);

%find prov names
%option stable avoids sorting the data
nameList = unique(names,'stable');

%set the date for calculating the scores: 
startDate = 20200101; 
endDate = 20220530;

%Create resDeg data structure
%strcmpi(names,nameList{i}) creates a logic array
len = size(nameList);
for i = 1:len
   resDeg.(nameList{i})=table2array(resMat(strcmpi(names,nameList{i}),:));
   %select the data for a specific starting and ending date: 
   resDeg.(nameList{i}) = resDeg.(nameList{i})(resDeg.(nameList{i})(:,1) >= startDate & resDeg.(nameList{i})(:,1) <= endDate,:);
end



L_ALB = length(resDeg.ALB);
%resDeg.(nameList{14})(:,2:4) = zeros(L_ALB,3);


%To calculate C1, C3, C2 degrees for Atlantic Bubble : 
l = length(resDeg.('PE')(:,1));
ALB_pop = populationSize(14,17);

for w = 2:4
  for j = 1:l
    Sum = 0;
  
      for i = 1:4
      
        Result = resDeg.(nameList{i})(j,w).*populationSize(i,17);
        Sum = Sum + Result;
      end %this for loop is taking each province as i proceeds and calculates the product of C1 by its population. 
 
  Atlantic_Bubble_Deg = round(Sum/ALB_pop);
  resDeg.('ALB')(j,w) =  Atlantic_Bubble_Deg;
   
  end %this loop goes through all the rows of the same column. 
end % this loop goes through all three columns. 


CA_pop = populationSize(15,17);

% To calculate C1,C3,C2 scores for Canada: 
for w = 2:4
  for j = 1:l
    Sum = 0;
  
      for i = 1:14
      
        Result = resDeg.(nameList{i})(j,w).*populationSize(i,17);
        Sum=Sum + Result;
      end %this for loop is taking each province as i proceeds and calculates the product of C1 by its population. 
 
   Canada_Deg = round(Sum/CA_pop);
   resDeg.('CA')(j,w) = Canada_Deg;
  end 

end 


