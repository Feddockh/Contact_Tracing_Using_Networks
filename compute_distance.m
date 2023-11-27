function [distance] = compute_distance(f, n, path_loss)

    % Compute the distance using the path loss, n, and the frequency
    distance = 10^((path_loss - 20*log10(f) + 147.56)/(10*n));

end