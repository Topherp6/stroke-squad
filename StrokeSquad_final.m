%% BME3053C Final Project: Stroke Squad

% Group Members: Ansley Grashof, Ashley Naidel, Chris Palles
% Course: BME 3053C Computer Applications for BME
% Term: Spring 2021
% J. Crayton Pruitt Family Dept of Biomedical Engineering
% University of Florida
% Emails: agrashof@ufl.edu, ashleynaidel@ufl.edu, cpalles@ufl.edu

%% Intro to our code
waitfor(msgbox({'Normal images should be in a folder titled "Normal Images".' 'Images used in this example are PNG, but others can be used.',...
    'Thank you for using our code.'},'Notes'));
pause(2);
%% Step1: Call Directory and Input Images
waitfor(msgbox({'In this first part of the code, we upload normal images of brain scans',...
    'to use as a baseline to establish a threshold value.'},'Step 1'));

starting_directory=cd;

addpath('Normal Images');
addpath('Test Images');

cd(starting_directory)
pause(2);
%% You can see the output of the uploaded 3 normal brain images:
choice = questdlg('Do you want to see the normal images?', ...
	'Show Normal Images?', ...
	'yes','no','yes');
pause(2);
%% Step2: Thresholding the normal images
waitfor(msgbox({'Because we know infarctions show up as lighter in color on a scan',...
    '(closer to 255 on a color scale), we choose to pick a threshold value of',...
    '170. We will now analyze each of the normal brain images to see how many',...
    'pixels are thresholded to establish a baseline.'},'Step 2'));
pause(2);
waitfor(msgbox({'Please select each normal image individually for these next steps.'},'Step 2'));
pause(2);
filename1=uigetfile({'*.*';'*.jpg';'*.png';'*.tiff'},'Select Image(s)');
normalone=imread(filename1);
pause(2);
filename2=uigetfile({'*.*';'*.jpg';'*.png';'*.tiff'},'Select Image(s)');
normaltwo=imread(filename2);
pause(2);
filename3=uigetfile({'*.*';'*.jpg';'*.png';'*.tiff'},'Select Image(s)');
normalthree=imread(filename3);
pause(2);
%Handle response
switch choice
    case 'yes'
        figure;imshow(normalone);
        pause(2);
        figure,imshow(normaltwo);
        pause(2);
        figure,imshow(normalthree);
    case 'no'
end

% First normal image:
wait = waitbar(0,'Processing data. Please wait.','WindowStyle','modal');
pause(2);
[h,w,~] = size(normalone);
binary = false(h,w);
thresh1 = 0;
for ii = 1:1:h
    for jj = 1:1:w
        if normalone(ii, jj, 1) > 170
            binary(ii, jj) = 1;
            if binary(ii, jj) == 1
                thresh1 = thresh1+1;
            end
        end
    end
end
pause(2);

% Second normal image:
waitbar(.33); 
[h,w,~] = size(normaltwo);
binary = false(h,w);
thresh2 = 0;
for ii = 1:1:h
    for jj = 1:1:w
        if normaltwo(ii, jj, 1) > 170
            binary(ii, jj) = 1;
            if binary(ii, jj) == 1
                thresh2 = thresh2+1;
            end
        end
    end
end
pause(2);

% Third normal image:
waitbar(.67);
[h,w,~] = size(normalthree);
binary = false(h,w);
thresh3 = 0;
for ii = 1:1:h
    for jj = 1:1:w
        if normalthree(ii, jj, 1) > 170
            binary(ii, jj) = 1;
            if binary(ii, jj) == 1
                thresh3 = thresh3+1;
            end
        end
    end
end
waitbar(1);
close(wait);


%% Step3: Determine upper end for the number of thresholded pixels:
threshs = [thresh1 thresh2 thresh3];
maxval =  max(threshs);
pause(2);

waitfor(msgbox({'The determined upper limit of thresholded pixels = maxval = 1715.',...
    'To give us some wiggle room, we can round this up to 1800 to use',...
    'as the determining value.'},'Step 3'));
pause(2);
%% Step4: Uploading test image
waitfor(msgbox({'Please select the image of a brain scan that may or may',...
    'not have a cerebral infarction present.'},'Step 4'));
pause(2);
filename=uigetfile({'*.*';'*.jpg';'*.png';'*.tiff'},'Select Image(s)');
image=imread(filename);

% You can see the output of what the user uploaded:
pause(2);
choice2 = questdlg('Do you want to see the image?', ...
	'Show Test Image?', ...
	'yes','no','yes');
pause(2);
% Handle response
switch choice
    case 'yes'
        imshow(image);
    case 'no'
end

%% Step5: Thresholding test image 
pause(2);
waitfor(msgbox({'Now the test image will be thresholded.'},'Step 5'));
wait = waitbar(0,'Processing data. Please wait.','WindowStyle','modal');
pause(2);

[h,w,c] = size(image);
binary = false(h,w);
waitbar(.33);
pause(2);

threshold = 0;
waitbar(.67);
pause(2);

for ii = 1:1:h
    for jj = 1:1:w
        if image(ii, jj, 1) > 170
            binary(ii, jj) = 1;
            if binary(ii, jj) == 1
                threshold = threshold+1;
            end
        end
    end
end
waitbar(1);
pause(.5);
close(wait);
pause(2);
%% Step6: Determining presence of a cerebral infarction in test image
waitfor(msgbox({'Depending on the thresholded values of the test image, this program',...
    'will display "Healthy" or "Cerebral Infarction Present".'},'Step 6'));
pause(2);
if threshold > 1800
        waitfor(msgbox({'Cerebral Infarction Present'},'Diagnosis'));
else
    waitfor(msgbox({'Healthy'},'Diagnosis'));
end