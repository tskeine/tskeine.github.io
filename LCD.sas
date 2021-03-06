/* To import the Excel data file into SAS Studio */

FILENAME REFFILE '/home/u49979723/sasuser.v94/Complete LCD.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=MYLIB.LCD;
	GETNAMES=YES;
RUN;

/* To determine correlation between the variables*/

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=MYLIB.LCD pearson nosimple noprob 
		plots(maxpoints=none)=matrix(nvar=7 nwith=7);
	var DailyCoolingDegreeDays DailyHeatingDegreeDays NormalsCoolingDegreeDay 
		NormalsHeatingDegreeDay;
	with DailyAverageDewPointTemperature DailyAverageDryBulbTemperature 
		DailyAverageWetBulbTemperature HourlyDewPointTemperature 
		HourlyDryBulbTemperature HourlyWetBulbTemperature MonthlyMeanTemperature;
run;

/* To generate linear regression models for Daily Cooling Degree Days*/

ods noproctitle;
ods graphics / imagemap=on;

proc reg data=MYLIB.LCD alpha=0.05 plots(only)=(diagnostics residuals fitplot 
		observedbypredicted);
	model DailyCoolingDegreeDays=DailyAverageDewPointTemperature /;
run;

proc reg data=MYLIB.LCD alpha=0.05 plots(only)=(diagnostics residuals fitplot 
		observedbypredicted);
	model DailyCoolingDegreeDays=DailyAverageDryBulbTemperature /;
run;

proc reg data=MYLIB.LCD alpha=0.05 plots(only)=(diagnostics residuals fitplot 
		observedbypredicted);
	model DailyCoolingDegreeDays=DailyAverageWetBulbTemperature /;
run;

/* To generate linear regression models for Daily Heating Degree Days*/

proc reg data=MYLIB.LCD alpha=0.05 plots(only)=(diagnostics residuals fitplot 
		observedbypredicted);
	model DailyHeatingDegreeDays=DailyAverageDewPointTemperature /;
run;

proc reg data=MYLIB.LCD alpha=0.05 plots(only)=(diagnostics residuals fitplot 
		observedbypredicted);
	model DailyHeatingDegreeDays=DailyAverageDryBulbTemperature /;
run;

proc reg data=MYLIB.LCD alpha=0.05 plots(only)=(diagnostics residuals fitplot 
		observedbypredicted);
	model DailyHeatingDegreeDays=DailyAverageWetBulbTemperature /;
run;