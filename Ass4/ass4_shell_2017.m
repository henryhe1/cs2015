%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ass1_2017()
close all
% Program to perform seasonal climate analysys on London
% Ontario weather data from 1942 to 2013.

% 2013-1940+1 years of data, 12 months in a year,
% max of 31 days in a month, 32 for LAST (contains
% number of days for which data items are stored per month)
% Basically this is the number of days per month, with February
% having 29 days for leap years: leaprear(year) return true
% true if year is a leap year and false otherwise.

% 7 elements per day:
% 1 - 001 - max daily temperature degrees C to 0.1C
% 2 - 002 - min daily temperature degrees C to 0.1C
% 3 - 003 - ave daily temperature degrees C to 0.1C
% 4 - 010 - total rainfall 0.1mm
% 5 - 011 - total snowfall 0.1cm
% 6 - 012 - total precipitation 0.1mm
% 7 - 013 - snow on the ground 1cm
element_desc{1}='max daily temperature (0.1C)';
element_desc{2}='min daily temperature (0.1C)';
element_desc{3}='ave daily temperature (0.1C)';
element_desc{4}='total rainfall (0.1mm)';
element_desc{5}='total snowfall (0.1cm)';
element_desc{6}='total precipitation (0.1mm)';
element_desc{7}='ground snow (1.0cm)';

% true for all 4 seasons 
num_seasons=4;
first_day_of_season=22;
last_day_of_season=21;

seasonal_desc{1}='Winter Dec 22nd-March 21st';
seasonal_desc{2}='Spring March 22st-June 21st';
seasonal_desc{3}='Summer June 22st-Sept 21st';
seasonal_desc{4}='Fall Sept 22nd-Dec 21st';

season_name{1}='Winter';
season_name{2}='Spring';
season_name{3}='Summer';
season_name{4}='Fall';

winter=1;
spring=2;
summer=3;
fall=4;

days_in_month(1)=31; % january
days_in_month(2)=28; % february (or 29 for leap years)
days_in_month(3)=31; % march
days_in_month(4)=30; % april
days_in_month(5)=31; % may
days_in_month(6)=30; % june
days_in_month(7)=31; % july
days_in_month(8)=31; % august
days_in_month(9)=30; % september
days_in_month(10)=31; % october
days_in_month(11)=30; % november
days_in_month(12)=31; % december
month_name={'January'; 'February'; 'March'; 'April'; 'May'; 'June';
            'July'; 'August'; 'September'; 'October'; 'November'; 'December'};

% variable with the month positional numbers
january=  1;
february= 2;
march=    3;
april=    4;
may=      5;
june=     6;
july=     7;
august=   8;
september=9;
october= 10;
november=11;
december=12;

% element colours for plotting
plot_color{1}='red';
plot_color{2}='green';
plot_color{3}='blue';
plot_color{4}='magenta';
plot_color{5}='cyan';
plot_color{6}='yellow';

% Set the default line width to 2.0 for all plotting
set(0,'defaultlinelinewidth',2.0)

base_year=1940;
year_index_1941=1941-base_year; % 1
year_index_1942=1942-base_year; % 2
year_index_2013=2013-base_year; % 73
num_of_years=2013-1941+1; % 73
num_of_months=12;
num_of_elements=7;
num_of_data_items=31+1; % maximum number of data items per month
LAST=32; % the last data item at index 32 is the number of data_items read

% climate data available on the course webpage
load london_weather_1941_2013.mat 'climate';

fprintf('Number of single numbers in climate:%d\n',....
        size(climate,1)*size(climate,2)*size(climate,3)*size(climate,4));
fprintf('Size of climate:\n');
fprintf('%d by %d by %d by %d\n',size(climate,1),...
         size(climate,2),size(climate,3),size(climate,4));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 1: Compute mean temperature, mean snowfall, 
% mean snow of the ground, mean rainfall and mean precipitation 
% for the 12 nonths for years 1942 to 2013 and display as
% appropriately labeled/titled surf graphs.
%
% Task 2: Compute Pearson's correlation coefficients for
% temperature versus precipitation, temperature versus snowfall,
% temperature versus snow on the ground, precipitation versus
% snowfall, rainfall versus snowfall and snow on the ground
% versus snowfall, for the 12 months from 1942 to 2013 and 
% display the results as a surf graphs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temperature=3;
rainfall=4;
snowfall=5;
precipitation=6;
snow_on_ground=7;

% Six correlation graphs are required:
% 1. temperature versus precipitation
% 2. temperature versus snowfall
% 3. temperature versus snow on the ground
% 4. preciptitation versus snowfall
% 5. rainfall versus snowfall
% 6. snow on the ground versus snowfall
% We have to collect the appropriate data in two 1D arrays
% that we use to compute the correlation coefficients, which
% we save in a 2D array

for year=year_index_1942:year_index_2013
    for month=1:12

    % last day potentially different for each month
    last_day=climate(year,month,temperature,32);

    % read 1:last_day elements of data, temperatures for each day of the
    % month
    temperature_data(1:last_day) = squeeze(climate(year,month,temperature,1:last_day));
    rainfall_data(1:last_day) = squeeze(climate(year,month,rainfall,1:last_day));
    snowfall_data(1:last_day) = squeeze(climate(year,month,snowfall,1:last_day));
    precipitation_data(1:last_day) = squeeze(climate(year,month,precipitation,1:last_day));
    snowground_data(1:last_day) = squeeze(climate(year,month,snow_on_ground,1:last_day));
    
    
    % copy only non-nan corresponding data to same variable    
%     temperature_data = temperature_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall) & ~isnan(snowfall) & ~isnan(precipitation) ...
%         & ~isnan(snow_on_ground)); 
%     rainfall_data = rainfall_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     snowfall_data = snowfall_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     precipitation_data = precipitation_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     snowground_data = snowground_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     


%     % copy only non-nan corresponding data to same variable    
%     temperature_data = temperature_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     rainfall_data = rainfall_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     snowfall_data = snowfall_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     precipitation_data = precipitation_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));
%     snowground_data = snowground_data(~isnan(temperature_data) ...
%         & ~isnan(rainfall_data) & ~isnan(snowfall_data) & ~isnan(precipitation_data) ...
%         & ~isnan(snowground_data));



    temperature_data = temperature_data(~isnan(temperature_data));
    rainfall_data = rainfall_data(~isnan(rainfall_data));
    snowfall_data = snowfall_data(~isnan(snowfall_data));
    precipitation_data = precipitation_data(~isnan(precipitation_data));
    snowground_data = snowground_data(~isnan(snowground_data));

    %average the non-nan data and save 
    temp_monthly_mean_data(year-year_index_1942+1,month) = mean(temperature_data(:));
    rain_monthly_mean_data(year-year_index_1942+1,month) = mean(rainfall_data(:));
    snow_monthly_mean_data(year-year_index_1942+1,month) = mean(snowfall_data(:));
    precip_monthly_mean_data(year-year_index_1942+1,month) = mean(precipitation_data(:));
    snowground_monthly_mean_data(year-year_index_1942+1,month) = mean(snowground_data(:));
    
    
    
    
%     SETUP ARRAYS x1 TO x6 AND y1 to y6 
%     PREALLOCATE THE ARAYS AND ASSIGN VAUES

    



%     % position x data for all x and y arrays (even is no nan) 
%     % to keep all the arrays the same length
%     USE FIND TO COMPUTE THE COORDINATES OF CORRESPONDING NAN ARRAY
%     ELEMENTS AND RESET x1 TO x6 AND y1 to y6
% 
%     coords=find( YOUR CONDITION HERE )
% 
%     % compute and save all average data for each month
% 
%     COMPUTE MEAN DATA FOR each month 1:12 AND year 1942:2013 AND SAVE
% 
%     % compute and save all correlation data for each month
% 
%     COMPUTE PEARSON'S COLLELATION COEFFICIENT for (x1,y1), (x2,y2, (x3,y3),
%     (x4,y4), (x5,y5) AND (x6,y6) AND SAVE

    end % for year
end % for month

% display the mean and correlation data using surf
% compute X and Y to contain all the x and y coordinates need by surf


assignin('base', 'temp', temp_monthly_mean_data);
assignin('base', 'rain', rain_monthly_mean_data);
assignin('base', 'snow', snow_monthly_mean_data);
assignin('base', 'precip', precip_monthly_mean_data);
assignin('base', 'snowground', snowground_monthly_mean_data);


% USE meshgrid TO COMPUTE X AND Y
[X,Y]=meshgrid(1:12,year_index_1942+base_year:year_index_2013+base_year);

% DISPLAY FIVE MEAN SURFACE PLOTS
surf(X,Y,squeeze(temp_monthly_mean_data))
title('Mean Temperature', 'Color', 'red', 'FontSize', 20);
xlabel('Month', 'Color', 'red', 'FontSize', 15);
ylabel('Year', 'Color', 'red', 'FontSize', 15);
zlabel('Degrees Celsius', 'Color', 'red', 'FontSize', 15);
colorbar
shading interp
figure

surf(X,Y,squeeze(rain_monthly_mean_data))
title('Mean Rainfall', 'Color', 'red', 'FontSize', 20);
xlabel('Month', 'Color', 'red', 'FontSize', 15);
ylabel('Year', 'Color', 'red', 'FontSize', 15);
zlabel('Millimeters', 'Color', 'red', 'FontSize', 15);
colorbar
shading interp
figure

surf(X,Y,squeeze(snow_monthly_mean_data))
title('Mean Snowfall', 'Color', 'red', 'FontSize', 20);
xlabel('Month', 'Color', 'red', 'FontSize', 15);
ylabel('Year', 'Color', 'red', 'FontSize', 15);
zlabel('Centimeters', 'Color', 'red', 'FontSize', 15);
colorbar
shading interp
figure

surf(X,Y,squeeze(precip_monthly_mean_data));
title('Mean Precipitation', 'Color', 'red', 'FontSize', 20);
xlabel('Month', 'Color', 'red', 'FontSize', 15);
ylabel('Year', 'Color', 'red', 'FontSize', 15);
zlabel('Centimeters', 'Color', 'red', 'FontSize', 15);
colorbar
shading interp
figure

surf(X,Y,squeeze(snowground_monthly_mean_data));
title('Mean Snow on Ground', 'Color', 'red', 'FontSize', 20);
xlabel('Month', 'Color', 'red', 'FontSize', 15);
ylabel('Year', 'Color', 'red', 'FontSize', 15);
zlabel('Centimeters', 'Color', 'red', 'FontSize', 15);
colorbar
shading interp
figure


% 
% DISPLAY SIX PEARSON'S CORRELATION COEFFICIENT SURFACE PLOTS




surf(X,Y,r)



end % ass4_2017 function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r=pearson_correlation_coefficient(x,y)

% COMPUTE r FROM PEARSON'S CORRELATION COEFFICIENT

n = numel(x);

r = (n * sum(x.*y) - sum(x).*sum(y)) ./ ( sqrt( (n * sum(x.^2) - (sum(x)).^2) .* (n * sum(y.^2) - (sum(y)).^2)) + eps);

end % pearson_correlation_coefficient function
