
%clear all;
clc
global a; 
a= arduino('COM5', 'Uno'); 
%make "a" object of arduino 
interv = 200; 
%defining time 
init_time = 1; 
%initial time 
x=0; 
while (init_time< interv)
    b= readVoltage(a,'A0');
    %reading voltaes from pin A0, reads voltages not adc value
    %voltage = (ADC*5)/1024
    x=[x,b];
    plot(x)
    grid ON
    init_time= init_time+1;
    drawnow
end

