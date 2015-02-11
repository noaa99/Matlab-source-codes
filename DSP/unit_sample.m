function [dn, n] = unit_sample(number_of_samples)
% function [dn, n] = unit_sample(number_of_samples)
% 
% Return a vector unit_sample dn, and the corresponding indexes n (0 start) 
%
% Chris Paige, Hyunjong Choi
% Revision date ? 1/6/15

 
% Input parameters:
%   number_of_samples - specifies the length of the unit sample vector.
 
%Obtain a vector of zeros of specified length. Set 1st index to 1
dn = zeros(1, number_of_samples);
dn(1) = 1;
 
%Obtain a vector of zeros of specified length. Increament by 1 for each
%index
n = zeros(1, number_of_samples);
for i = 0:number_of_samples-1 
    n(i+1) = i;
end
 
end
