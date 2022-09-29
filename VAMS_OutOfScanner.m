%mood questions


%% environment
%clean up
addpath(genpath('/Applications/Psychtoolbox'))
fclose('all');
clear all
sca
clc

% PTB basics
AddPsychJavaPath;
LoadPsychHID;
PsychJavaTrouble;
commandwindow;

Screen('Preference', 'SkipSyncTests', 1);

% function handles
n2s = @num2str;

%A unique identifier to go into the log file
try
    randinfo = rng('shuffle');
catch
    randinfo.Seed = sum(100*clock);
    rand('seed',randinfo.Seed)
end

% sets directories
HomeDir = '/Users/labuser/Desktop/Mood';
DataDir = [HomeDir '/DATA'];
StimDir = [HomeDir '/STIM'];

%% user input 
prompt = {'Subject number: ', 'Run number: ','Study: '};
defaults = {'','',''};
dlgout = inputdlg(prompt,'',1,defaults);
subj = str2double(dlgout{1});
run = str2double(dlgout{2});
study = dlgout{3};

commandwindow;
HideCursor

%% initialize data file
%set subject directory
DataDir = [DataDir '/' study];
subjDir = [DataDir '/' n2s(subj)];
mkdir(subjDir);

%% Initialize Trial Variables
earnings = 0;



%% Screen Set up

%screen setup
HideCursor;
[win, ScrRect] = Screen('OpenWindow', max(Screen('Screens')));
Black = [0 0 0];
White = [255 255 255];
Red = [255 0 0];
Green = [0 255 0];
Yellow = [255 255 0];
FontName = 'Arial';
FontLg = 65;
FontSm = 20
Xres = ScrRect(3);
Yres = ScrRect(4);
xCenter = Xres/2;
yCenter = Yres/2;
Dres = sqrt(Xres^2+Yres^2)/1500;
Screen('FillRect',win,Black);
Screen('TextFont',win,FontName);
Screen('TextSize',win,FontLg);

%Positions & Sizes
Certainx = (xCenter-300);
Certainy = 'center';
Gainx = (xCenter+500);
Gainy = (Yres/2)-300;
Lossx = (xCenter+500);
Lossy = (Yres/2)+200;

circlewidth = 250;
Certaincirclex = Certainx+75;
Certaincircley = (Yres/2);
Gaincirclex = Gainx+75;
Gaincircley = Gainy+50;
Losscirclex = Lossx+75;
Losscircley = Lossy+50;


% button setup
KbName('UnifyKeyNames')
TRIG  = KbName('UPARROW');
CERTAINPRESS = KbName('LEFTARROW');
GAMBLEPRESS = KbName('RIGHTARROW');
DONE = KbName('DOWNARROW');

buttonbox = max(GetKeyboardIndices); %%fixed.

%reset Kb to only accept trigger %dan added
klist = zeros(1,256); 
klist(TRIG) = 1; 
klist(CERTAINPRESS) = 1;
klist(GAMBLEPRESS) = 1;
klist(DONE) = 1;
KbQueueCreate(buttonbox, klist); 
KbQueueStart(buttonbox); 

%% waits for initial scanner trigger to begin run
DrawFormattedText(win,'Press the UP arrow to begin.','center','center',White);
Screen('Flip',win);
KbQueueFlush(buttonbox);
while (1)
    [pressed, x1, x2, keyCode, x3] = KbQueueCheck(buttonbox);
    if pressed && keyCode(TRIG)
        %after trigger, reset Kb to allow button press %dan added
        klist = zeros(1,256);
        klist(CERTAINPRESS) = 1;
        klist(GAMBLEPRESS) = 1;
        KbQueueFlush(buttonbox);
        runStart = GetSecs;
        break;
    end
end

avgAcc = 0; 
startTime = (GetSecs-runStart);

%% Initial Check in


for t=1:5 
xCenter=ScrRect(3)/2;
yCenter=ScrRect(4)/2;
ratingQs = {'How do you feel right now?' 'How do you feel right now?' 'How do you feel right now?' 'How do you feel right now?' 'How do you feel right now?'};
scale1Vec = {'Hostile' 'Quick-witted' 'Relaxed' 'Sad' 'Withdrawn'}; %left
scale2Vec = {'Friendly' 'Mentally slow' 'Tense' 'Happy' 'Sociable'}; %right
Screen('TextSize',win,FontSm);
slack = Screen('GetFlipInterval', win); 
vbl = Screen('Flip', win);

commandwindow;
baseRect = [0 0 10 30];
xshift = 0;
LineX = xCenter-xshift;
LineY = yCenter;
rectColor = [255 255 255];
pixelsPerPress = 20;
waitframes = 1;
checkidx = 1;
moodStart = (GetSecs-runStart);

%% initialize data file
%fclose(dataFile);
fileName = fullfile(subjDir,['Gambles_moodratings_subj' n2s(subj) '_run' n2s(run) '.csv']);
dataFile = fopen(fileName, 'a');

%Check for button press
while KbCheck; end

    while true
        [pressed, firstpress, firstrelease, keyCode, lastRelease] = KbQueueCheck(buttonbox); %check response
        pressedKeys = find(keyCode);
        if keyCode(CERTAINPRESS)
            LineX = LineX - pixelsPerPress;
        elseif keyCode(GAMBLEPRESS)
            LineX = LineX + pixelsPerPress;
        elseif keyCode(DONE)
            StopPixel_M = (((LineX - xCenter-xshift) + 250)/5);
            break;
            false
        end
        
        %Don't allow them to go off the response line
        if LineX < (xCenter-250-xshift)
            LineX = (xCenter-250-xshift);
        elseif LineX > (xCenter+250-xshift) 
            LineX = (xCenter+250-xshift);
        end
        if LineY < 0
            LineY = 0;
        elseif LineY > (yCenter+10)
            LineY = (yCenter+10);
        end
        
        text_P = ratingQs{t};
        centeredRect = CenterRectOnPointd(baseRect, LineX, LineY);
        DrawFormattedText(win, text_P ,xCenter-250-xshift, (yCenter-100), [255, 255, 255],...
            [],[],[],5)
        Screen('DrawLine', win, [255, 255, 255], (xCenter+250-xshift ), (yCenter), ...
            (xCenter-250-xshift), (yCenter), 1);
        Screen('DrawLine', win, [255, 255, 255], (xCenter+250-xshift ), (yCenter+10),...
            (xCenter+250-xshift), (yCenter-10), 1);
        Screen('DrawLine', win, [255, 255, 255], (xCenter-250-xshift ), (yCenter+10),...
            (xCenter- 250-xshift), (yCenter-10), 1); 
        Screen('DrawText', win,scale1Vec{t}, (xCenter-300-xshift), (yCenter+25),...
            [255, 255, 255]);
        Screen('DrawText', win,scale2Vec{t}, (xCenter+200-xshift), (yCenter+25),...
            [255, 255, 255]);
        Screen('FillRect', win, rectColor, centeredRect);
        vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * slack);
    end
moodEnd = (GetSecs-runStart);    

%Cleanup and writeout
Screen('Flip',win);  %black out the screen
Screen('FillRect',win,Black);
Screen('Flip',win); 

checkin_resp(checkidx) = StopPixel_M;  %record response
LineX = xCenter-xshift;  %reset position to 50%
Screen('TextSize',win,FontLg);  %change default font size back to FontLg
WaitSecs(1.0);
%t=0;
fprintf(dataFile, '%d,%d,%d,%d,%d,%s,%s\n',...
    t,checkidx,checkin_resp(checkidx),moodStart,moodEnd,scale1Vec{t},scale2Vec{t});
end 



fclose(dataFile);
% copyDir = [HomeDir '/DATA_copy/'];
% copyFileName = fullfile(copyDir,['MID_' n2s(subj) '_run' n2s(run) '_raw.csv']);
% copyfile(fileName,copyFileName);
sca;
    
    
    
