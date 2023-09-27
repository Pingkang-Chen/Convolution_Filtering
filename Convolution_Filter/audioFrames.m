% this is for mono signals only!

% x is the input signal, N is the sub-window size in samples

function xFrames = audioFrames(x, N, overlapFactor)

    % calculate the hop in samples
    hop = N / overlapFactor;

    % calculate how many frames we'll have based on the length of x and the
    % hop. we'll overestimate (round up) how many frames there will be
    numFrames = ceil(length(x) / hop);

    % make the xFrames array with N rows and numFrames columns
    xFrames = zeros(N, numFrames);

    % make a for loop that will grab the correct range of samlpes from x
    % and store them in the correct column of xFrames
    for frame = 1 : numFrames

        % determine the beginning and ending sample of sub-window number frame
        startSamp = (frame - 1) * hop + 1;
        endSamp = startSamp + N - 1;
%         endSamp = frame * N;
        
        % need a conditional statement here to check that the start and end
        % indices are in bounds
        if endSamp > length(x)
            % in this case, we have an incomplete final frame  and we
            % should zero pad it before storing it in xFrames
            xFrames(:, frame) = zeroPad(x(startSamp : end), N);
            % we can also break out of this for loop early if we're on the
            % final frame. remember, we overestimated the total number of
            % frames to be on the safe side.
            break;
        else
            % store the correct range of samples from x in column frame of
            % xFrames
            xFrames(:, frame) = x(startSamp : endSamp);
        end

    end


end

function y = zeroPad(x, desiredLength)

    % check the length of x
    signalLength = length(x);

    % calculate the difference in lengths between x and desired length
    zpLength = abs(desiredLength - signalLength);

    % create an array of zeros (this is the "pad")
    zp = zeros(zpLength, 1);

    % append the zero pad array to x
    y = [x; zp];

end
