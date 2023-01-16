
x= imread('C:\Windows\System32\dataecg1500\test\0.jpg');
y= imresize3(x,0.5);
load netTransfer; 
labelIdx = predict(netTransfer,x);
b= labelIdx();
M = max(b);
if b(1)== M
     fprintf('The obtained ECG signal rhythm is an ARR' );
elseif b(2) == M
     fprintf('The obtained ECG signal rhythm is an CHF');
elseif b(3) == M
     fprintf('The obtained ECG signal rhythm is an NSR');

end     
