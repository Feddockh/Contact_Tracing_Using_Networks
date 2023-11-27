function [path_loss] = compute_loss(a, b, f, n)

    % Compute the euclidean distance between the points
    d = sqrt((b(1) - a(1))^2 + (b(2) - a(2))^2);

    % Compute the path loss in the DB scale
    path_loss = 20*log10(f) + 10*n*log10(d) - 147.56;

end