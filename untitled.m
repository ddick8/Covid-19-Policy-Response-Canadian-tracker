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

%NEW 
dates = cell2mat(rawData(2:end,3));

%create restriction and date matrix
resMat = rawData(2:end,1:6);

%find prov names
%option stable avoids sorting the data
nameList = unique(names,'stable');

%DateList = cellfun(@(x) num2str(x), dates, 'UniformOutput',0);

%NEW: selects all the dates for which the data is available. 
dateList = unique(dates);

%Create resDeg data structure
%strcmpi(names,nameList{i}) creates a logic array
len = length(dateList);

%struggling to find a proper name for the resDeg data structure. 
for i = 1:len
   resDeg.('data for' + dateList(i,1))=resMat(isequal(dates,dateList(i,1)),:);
end


