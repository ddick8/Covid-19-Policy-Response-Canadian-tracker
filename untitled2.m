%Load Data 

PopulationExcelName = fullfile(pwd,'/data/populations.csv');

DegreeFile = fullfile(pwd,'/Provincial_Data.csv');

population = readtable(PopulationExcelName,...
    'Range','A2:R16'); %last Column represents the population of the corresponding province/territory as of 2020.

%Convert numberical data to an array type. 
populationSize = table2array(population(1:end,2:end));

%read all data
rawData = readcell(DegreeFile);

%create names cell vector
%Using region codes to avoid spaces
names = rawData(2:end,2);


%create restriction and date matrix
resMat = cell2mat(rawData(2:end,3:6));

%find prov names
%option stable avoids sorting the data
nameList = unique(names,'stable');

%specify the dates for which the data is being calculated.

startTime = "20200110";
endTime = "20200130"; 

%Create resDeg data structure
%strcmpi(names,nameList{i}) creates a logic array
len = length(nameList);
for i = 1:len
   resDeg.(nameList{i}) = resMat(strcmpi(names,nameList{i}),:);
   
   
   idx = isbetween(resDeg.(nameList{1})(:,1),startTime,endTime);
   
   resDeg.(nameList{i}) = resDeg.(nameList{i})(idx,:);
   
end


firstColumnIndex = data{:, 1} == 3;

secondColumnIndex = data{:, 2} == 5;

thirdColumnValues = data{firstColumnIndex & secondColumnIndex, 3};