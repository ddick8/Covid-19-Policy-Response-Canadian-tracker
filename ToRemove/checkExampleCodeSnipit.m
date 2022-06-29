
%pwd returns the current directory.
PopulationExcelName = fullfile(pwd,'/data/populations.csv');
DegreeFile = fullfile(pwd,'/Provincial.csv');


populationSize =readtable(PopulationExcelName,...
    'Range','A2:R16'); %last Column represents the population of the corresponding province/territory as of 2020.

%% Example Code

%read all data
rawData = readcell(DegreeFile)

%create names cell vector
%Using region codes to avoid spaces
names = rawData(2:end,2)

%create restriction and date matrix
resMat = cell2mat(rawData(2:end,3:6))

%find prov names
nameList = unique(names)

%Create resDeg data structure
%strcmpi(names,nameList{i}) creates a logic array
len = length(nameList)
for i = 1:len
   resDeg.(nameList{i})=resMat(strcmpi(names,nameList{i}),:)
end

%% Original Code

ResDeg.('Alberta') =table2array(readtable(DegreeFile,... 
'Range', 'C81:F82'));%Alberta 

ResDeg.('British_Columbia')= table2array(readtable(DegreeFile,... 
'Range', 'C1655:F1656'));%British_Columbia

ResDeg.('Manitoba') = table2array(readtable(DegreeFile,... 
'Range', 'C2505:F2506'));%Manitoba

ResDeg.('Northwest_Territories') = table2array(readtable(DegreeFile,... 
'Range', 'C3376:F3377'));%Northwest_Territories

ResDeg.('Nunavut') = table2array(readtable(DegreeFile,... 
'Range', 'C4591:F4592'));%Nunavut

ResDeg.('Ontario') = table2array(readtable(DegreeFile,... 
'Range', 'C5471:F5472'));%Ontario

ResDeg.('Quebec') = table2array(readtable(DegreeFile,... 
'Range', 'C5986:F5987'));%Quebec

ResDeg.('Saskatchewan') = table2array(readtable(DegreeFile,... 
'Range', 'C6867:F6868'));%Saskatchewan

ResDeg.('Yukon') = table2array(readtable(DegreeFile,... 
'Range', 'C7777:F7778'));%Yukon

ResDeg.('New_Brunswick')= table2array(readtable(DegreeFile,... 
'Range', 'C9505:F9506'));%New_Brunswick

ResDeg.('Nova_Scotia') = table2array(readtable(DegreeFile,... 
'Range', 'C10738:F10739'));%Nova_Scotia

ResDeg.('Newfoundland') = table2array(readtable(DegreeFile,... 
'Range', 'C11264:F11265'));%Newfoundland

ResDeg.('Prince_Edward_Island') = table2array(readtable(DegreeFile,... 
'Range', 'C12144:F12145'));%Prince_Edward_Island

ResDeg.('Atlantic_Bubble') = readtable(DegreeFile,... 
'Range', 'C936:F937');%Atlantic_Bubble
ResDeg.Atlantic_Bubble = removevars(ResDeg.Atlantic_Bubble, 'ExtraVar1');
ResDeg.Atlantic_Bubble = removevars(ResDeg.Atlantic_Bubble, 'ExtraVar2');
ResDeg.('Atlantic_Bubble') = table2array(ResDeg.('Atlantic_Bubble')); 


T1 = table2array(populationSize(1,18));
T2 = table2array(populationSize(2,18));
T3 = table2array(populationSize(3,18));
T4 = table2array(populationSize(4,18));
T5 = table2array(populationSize(5,18));
T6 = table2array(populationSize(6,18));
T7 = table2array(populationSize(7,18));
T8 = table2array(populationSize(8,18));
T9 = table2array(populationSize(9,18));
T10 = table2array(populationSize(10,18));
T11 = table2array(populationSize(11,18));
T12 = table2array(populationSize(12,18));
T13 = table2array(populationSize(13,18));
T14 = table2array(populationSize(14,18));
T15 = table2array(populationSize(15,18));
populationList = {T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14}; 

nameList={'Newfoundland', 'Prince_Edward_Island', 'Nova_Scotia','New_Brunswick','Quebec','Ontario','Manitoba','Saskatchewan','Alberta','British_Columbia','Yukon','Northwest_Territories','Nunavut', 'Atlantic_Bubble'};

Canada_Deg = 0 ;
array = zeros(length(ResDeg.('Prince_Edward_Island')(:,1)),3);


% To calculate the scores for C1: 
for j = 1:length(ResDeg.('Prince_Edward_Island')(:,1))
 Sum = 0;
  
    for i = 1:14
      
      Result = ResDeg.(nameList{i})(j,2).*populationList{i};
      Sum=Sum + Result;
   end %this for loop is taking each province as i proceeds and calculates the product of C1 by its population. 
 
 Canada_Deg = round(Sum/T15);
 array(j,1) = Canada_Deg;


end 

% To calculate the scores for C3: 
for j = 1:length(ResDeg.('Prince_Edward_Island')(:,1))
 Sum = 0;
  
    for i = 1:14
      
      Result = ResDeg.(nameList{i})(j,3).*populationList{i};
      Sum=Sum + Result;
   end %this for loop is taking degree of C3 for each province as i proceeds and multiplies it by the province/territory's population. 
 
 Canada_Deg = round(Sum/T15);
 array(j,2) = Canada_Deg;


end 

% To calculate the scores for C2: 
for j = 1:length(ResDeg.('Prince_Edward_Island')(:,1))
 Sum = 0;
  
    for i = 1:14
      
      Result = ResDeg.(nameList{i})(j,4).*populationList{i};
      Sum=Sum + Result;
   end %this for loop is taking degree of C3 for each province as i proceeds and multiplies it by the province/territory's population. 
 
 Canada_Deg = round(Sum/T15);
 array(j,3) = Canada_Deg;


end 

