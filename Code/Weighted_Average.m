clear

%% Load Data 

PopulationExcelName = fullfile(pwd,'../Data/populations.csv');

DegreeFile = fullfile(pwd,'../Data/Provincial_Data.csv');

population = readtable(PopulationExcelName,...
    'Range','A2:R16'); 

%% Convert numberical data to an array type. 

populationSize = table2array(population(1:end,2:end));

%% Read all data and create names cell vector

rawData = readtable(DegreeFile,'PreserveVariableNames',true);

names = table2array(rawData(1:end,2));

%find provices/territories names
%option stable avoids sorting the data
nameList = unique(names,'stable');

%% Create restriction and date matrix

resMat = rawData(1:end,3:6);

%% Set starting and end dates for calculating the scores: 
startDate = 20200101; 
endDate = 20220530;

%% Create resDeg data structure which contains all the scores for provinces/territories 

len = size(nameList);
for i = 1:len
   resDeg.(nameList{i})=table2array(resMat(strcmpi(names,nameList{i}),:));
   %select the data for a specific starting and ending date: 
   resDeg.(nameList{i}) = resDeg.(nameList{i})(resDeg.(nameList{i})(:,1) >= startDate & resDeg.(nameList{i})(:,1) <= endDate,:);
end


%% Calculate C1, C3, C2 degrees for Atlantic Bubble : 

%Atlantic Bubble population saved as ALB_pop: 
ALB_pop = populationSize(14,17);

l = length(resDeg.('ALB')(:,1));

for w = 2:4
  for j = 1:l
    Sum = 0;
    
      for i = 1:4
          Result = resDeg.(nameList{i})(j,w).*populationSize(i,17);
          Sum = Sum + Result;
      end 
 
    Atlantic_Bubble_Deg = round(Sum/ALB_pop);
  
    resDeg.('ALB')(j,w) =  Atlantic_Bubble_Deg;
  end
end 



%% Calculate C1,C3,C2 scores for Canada: 

%Canada population saved as CA_pop: 
CA_pop = populationSize(15,17);

for w = 2:4
  for j = 1:l
     Sum = 0;
      for i = 1:13
          Result = resDeg.(nameList{i})(j,w).*populationSize(i,17);
          Sum=Sum + Result;
      end  
    Canada_Deg = round(Sum/CA_pop);
   
    resDeg.('CA')(j,w) = Canada_Deg;
  end 
end 


