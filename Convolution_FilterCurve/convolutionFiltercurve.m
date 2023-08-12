function [z,x,Fs] = convolutionFiltercurve(inputfileName,kernelfileName, N, overlap)
   
% cut the first 4096 samples long's segment as the filter kernel,from 1~ N  
  [k, Fs] = audioread(kernelfileName, [1, N]); 
  
% make the kernel a mono signal
  k = k(:,1);

% apply hann window before all the FFT algorithm, in order to get more 
% realistic results and reduce spectral leakage
   hw = hann(N);   

% get the FFT result of the filter kernel
   K = fft(k .* hw);  

% load an input signal
   [x, Fs] = audioread(inputfileName);
 
% make the input signal a mono signal
   x = x(:,1);

 % break the input signal into subframes, make sure N is as long as the
 % kernel "k" 
  xFrames = audioFrames(x, N, overlap);

% take the FFT result of all windowed subframes, or say,get the FFT result 
% of xFrames by adding each subframe's FFT value 
   XFrames = fft(xFrames .* hw);

% get the kernel's magnitude spectrum which is also the absolute FFT 
% result's array of "K"
   kernelMagnitude = abs(K);

% normalize the kernelMagnitude array to get an array of numbers between 
% 0 to 1 by using the kernelMagnitude array to divide the maximum single
% value of the kernelManitudet array.Filnally, we can get an array of 
% proportion through 0 to 1, which consists of the filterCurve we want
 filterCurve = kernelMagnitude/max(kernelMagnitude); 

% multiply this filterCurve array by the XFrames FFT array to get the final
% filterd Frames' frequency spectrum(FFT),because at this moment, the 
% filterCure is a magnitudeScalar
 ZFrames = filterCurve .* XFrames;
   
% get the output signal by using IFFT and real function from its frequency 
% spectrum back to the time domain, which will be the audio samples with 
% all the real results  
   zFrames = real(ifft(ZFrames));   
   
% since we have got this new value, we need to apply hann window to it
  zFrames = zFrames .* hw;  

% use overlap-add method to construct the filtered output signal  
  z = frameAssembler(zFrames, overlap);  

% normalize the output signal
  z = z/max(abs(z));  

% make sure the new filtered output signal and the input signal 
% are the same magnitude
  z = z * max(abs(x));   
  
end
































  
 

  






   
   


   
   
 
   

   
  

   





  






    
   

   



   





      
    