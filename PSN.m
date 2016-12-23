% Demo to calculate PSNR of a gray scale image.
% http://en.wikipedia.org/wiki/PSNR

function PSN(img_1,img_2)

    format long g;
    format compact;
    fontSize = 20;
    %------ GET DEMO IMAGES ----------------------------------------------------------
    % Read in a standard MATLAB gray scale demo image.
    figure
    [rows, columns] = size(img_1);
    % Display the first image.
    subplot(2, 2, 1);
    imshow(img_1, []);
    title('Original Gray Scale Image', 'FontSize', fontSize);
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    % Get a second image by adding noise to the first image.
    %noisyImage = imnoise(grayImage, 'gaussian', 0, 0.003);

    % Display the second image.
    subplot(2, 2, 2);
    imshow(img_2, []);
    title('Rotated Gray Scale Image', 'FontSize', fontSize);
    %------ PSNR CALCULATION ----------------------------------------------------------
    % Now we have our two images and we can calculate the PSNR.
    % First, calculate the "square error" image.
    % Make sure they're cast to floating point so that we can get negative differences.
    % Otherwise two uint8's that should subtract to give a negative number
    % would get clipped to zero and not be negative.
    squaredErrorImage = (double(img_1) - double(img_2)) .^ 2;
    % Display the squared error image.
    subplot(2, 2, 3);
    imshow(squaredErrorImage, []);
    title('Squared Error Image', 'FontSize', fontSize);
    % Sum the Squared Image and divide by the number of elements
    % to get the Mean Squared Error.  It will be a scalar (a single number).
    mse = max(sum(sum(squaredErrorImage)) / (rows * columns));
    % Calculate PSNR (Peak Signal to Noise Ratio) from the MSE according to the formula.
    PSNR = 10 * log10( 256^2 / mse);
    % Alert user of the answer.
    message = sprintf('The mean square error is %.2f.\nThe PSNR = %.2f', mse, PSNR);
    msgbox(message);

end
