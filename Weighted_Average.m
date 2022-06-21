PopulationExcelName = fullfile(pwd,'/data/populations.csv');
DegreeFile = fullfile(pwd,'/Provincial.csv');



populationSize =readtable(PopulationExcelName,...
    'Range','A2:R16'); %last Column represents the population of the corresponding province/territory as of 2020. 

ResDeg.('Alberta') =table2array(readtable(DegreeFile,... 
'Range', 'C849:F880'));%Alberta 

ResDeg.('British_Columbia')= table2array(readtable(DegreeFile,... 
'Range', 'C2581:F2612'));%British_Columbia

ResDeg.('Manitoba') = table2array(readtable(DegreeFile,... 
'Range', 'C3430:F3461'));%Manitoba

ResDeg.('Northwest_Territories') = table2array(readtable(DegreeFile,... 
'Range', 'C4300:F4331'));%Northwest_Territories

ResDeg.('Nunavut') = table2array(readtable(DegreeFile,... 
'Range', 'C5149:F5180'));%Nunavut

ResDeg.('Ontario') = table2array(readtable(DegreeFile,... 
'Range', 'C6028:F6059'));%Ontario

ResDeg.('Quebec') = table2array(readtable(DegreeFile,... 
'Range', 'C6908:F6939'));%Quebec

ResDeg.('Saskatchewan') = table2array(readtable(DegreeFile,... 
'Range', 'C7817:F7848'));%Saskatchewan

ResDeg.('Yukon') = table2array(readtable(DegreeFile,... 
'Range', 'C8696:F8727'));%Yukon

ResDeg.('New_Brunswick')= table2array(readtable(DegreeFile,... 
'Range', 'C10454:F10485'));%New_Brunswick

ResDeg.('Nova_Scotia') = table2array(readtable(DegreeFile,... 
'Range', 'C11332:F11363'));%Nova_Scotia

ResDeg.('Newfoundland') = table2array(readtable(DegreeFile,... 
'Range', 'C12211:F12242'));%Newfoundland

ResDeg.('Prince_Edward_Island') = table2array(readtable(DegreeFile,... 
'Range', 'C13090:F13121'));%Prince_Edward_Island

ResDeg.('Atlantic_Bubble') = readtable(DegreeFile,... 
'Range', 'C1702:C1733');%Atlantic_Bubble
%ResDeg.Atlantic_Bubble = removevars(ResDeg.Atlantic_Bubble, 'ExtraVar1');
%ResDeg.Atlantic_Bubble = removevars(ResDeg.Atlantic_Bubble, 'ExtraVar2');
%ResDeg.('Atlantic_Bubble') = table2array(ResDeg.('Atlantic_Bubble')); 

ResDeg.('Canada') = readtable(DegreeFile,... 
'Range', 'C9575:C9606');%Atlantic_Bubble


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

Atlantic_Bubble_Deg = 0; 

l = length(ResDeg.('Prince_Edward_Island')(:,1));

%To calculate C1, C3, C2 degrees for Atlantic Bubble : 

for w = 2:4
  for j = 1:l
    Sum = 0;
  
      for i = 1:4
      
        Result = ResDeg.(nameList{i})(j,w).*populationList{i};
        Sum = Sum + Result;
      end %this for loop is taking each province as i proceeds and calculates the product of C1 by its population. 
 
  Atlantic_Bubble_Deg = round(Sum/T14);
  ResDeg.('Atlantic_Bubble')(j,w) =  array2table(Atlantic_Bubble_Deg);
   
  end 
end 


%Converting the data type : 
ResDeg.('Atlantic_Bubble') = table2array(ResDeg.('Atlantic_Bubble'));

% To calculate C1,C3,C2 scores for Canada: 
for w = 2:4
  for j = 1:l
    Sum = 0;
  
      for i = 1:14
      
        Result = ResDeg.(nameList{i})(j,w).*populationList{i};
        Sum=Sum + Result;
      end %this for loop is taking each province as i proceeds and calculates the product of C1 by its population. 
 
   Canada_Deg = round(Sum/T15);
   ResDeg.('Canada')(j,w) = array2table(Canada_Deg);
  end 

end 

