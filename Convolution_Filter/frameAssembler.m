function x = frameAssembler(xFrames,overlap)

    % get N based on number of rows in xFrames

    [N,numFrames] = size(xFrames);

    % calculate hop in samples based on N and overlap

    hop = N / overlap;

    % make an empty array x to hold the final signal

    x = zeros(numFrames*hop + N,1);

    % run a loop where we mix in each frame of xFrames to the appropriate
    % spot in x

    for frame = 1 : numFrames
        
        startSamp = (frame-1)*hop + 1;
        endSamp = startSamp + N - 1;

        x(startSamp : endSamp) = x(startSamp : endSamp) + xFrames(:,frame);

    end

end