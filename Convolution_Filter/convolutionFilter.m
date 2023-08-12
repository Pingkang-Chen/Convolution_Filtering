function [z,x,Fs]= convolutionFilter(inputfileName,kernelfileName, N, overlap)

% excerpt the first 4096 samples long's segment as the filter kernel, whcih
% is through 1~ N.  
  [k, Fs] = audioread(kernelfileName, [1, N]); 

% make the kernel a mono signal
  k = k(:,1);

% apply hann window before all the FFT algorithm, in order to get more 
% realistic results and reduce spectral leakage
  hw = hann(N);   

% get the FFT results of the filter kernel
   K = fft(k .* hw);  

% load an input signal
   [x, Fs] = audioread(inputfileName);
 
% make the input sigal a mono signal as well
   x = x(:,1);

% break the input signal into subframes, make sure N is as long as the
% kernel "k" 
   xFrames = audioFrames(x, N, overlap);

% take the FFT result of all windowed subframes, or say,get the FFT result 
% of xFrames by adding each subframe's FFT 
   XFrames = fft(xFrames .* hw);

% multiply the FFT of xFrames by the FFT of filter kernel to get the
% frequency domain, which is the step of convolution
   ZFrames = K .* XFrames; 
   
% get the output signal by using IFFT and real function from its frequency 
% spectrum back to the time domain, which will be the audio samples with 
% all the real results  
   zFrames = real(ifft(ZFrames));  
   
% since we have got this new filtered value, we need to apply hann window 
% to it
   zFrames = zFrames .* hw; 

% use overlap-add method to construct the filtered output signal 
   z = frameAssembler(zFrames, overlap); 

% normalize the output signal
   z = z/max(abs(z));  

% make sure the new filtered output signal and the input signal 
% are the same magnitude
  z = z * max(abs(x));  
  
end
































  
 

  






   
   


   
   
 
   

   
  

   





  






    
   

   



   





      
    