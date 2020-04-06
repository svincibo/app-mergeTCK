function [] = mergeTCK()

% This script will read in all available TCK files for a subject and merge
% them into one TCK file. BIDS format is assumed.

% It will discern between whether the code was called by the mergeTCK
% brainlife.io app (https://doi.org/10.25663/brainlife.app.219) 
% or the merge2TCKs brainlife.io app (https://doi.org/10.25663/brainlife.app.304).

% Dependencies:
% mrtrix3

% Setup json lab.
if ~isdeployed
    
    addpath(genpath('/N/u/brlife/git/jsonlab'));
    addpath(genpath('/N/u/hayashis/git/vistasoft'))
    
end

% Read in config.json.
config = loadjson('config.json');

% Discern between mergeTCK and merge2TCKs.
% Note: This would be better as a switch-case, if I could identify a good switch in the config.jscon file.
if isfield(config, 'tcks') % then this is merge2TCKs.
    
    % Get number of TCKs to be merged.
    N_tcks = size(config(1).tcks, 2);
    
    % Address one TCK file at a time, for now.
    for i_tcks = 1:N_tcks
        
        % Read in data for this subject and this tck. -- NOTE: Consider dtiImportFibersMatrix.
        tck_temp = read_mrtrix_tracks(config(1).tcks{i_tcks});
        
        % Merge.
        if i_tcks == 1
            
            % Initiate new tck information for this subject.
            mergedtck = tck_temp.data;
            
            % Initiate seed and track counters for this subject, if necessary.
            if isfield(tck_temp, 'max_num_seeds') == 1
                count_seed = tck_temp.max_num_seeds;
            end
            if isfield(tck_temp, 'max_num_tracks') == 1
                count_track = tck_temp.max_num_tracks;
            end
            
            % Update user -- NOTE: Update to get subject ID from config file.
            disp(['Started merging TCK files for the a new subject. Merging ' num2str(i_tcks) ' of ' num2str(N_tcks) ' TCKs.'])
            
        else
            
            % Append tck for this tck to previously added tcks for this subject.
            mergedtck = [mergedtck tck_temp.data];
            
            % Update counters for seed and track counts for this subject, if necessary.
            if isfield(tck_temp, 'max_num_seeds') == 1
                count_seed = count_seed + tck_temp.max_num_seeds;
            end
            
            if isfield(tck_temp, 'max_num_tracks') == 1
                count_track = count_track + tck_temp.max_num_tracks;
            end
            
            % Update user -- NOTE: Update to get subject ID from config file.
            disp(['... merging ' num2str(i_tcks) ' of ' num2str(N_tcks) ' TCKs.'])
            
        end % end if i_tcks == 1
        
    end % end for i_tcks
    
elseif isfield(config, 'track1') % then this is merge2TCKs
    
    % Set number of TCKs to be merged to 2 (required by app).
    N_tcks = 2;
    
    % Read in data for this subject's first tck. -- NOTE: Consider dtiImportFibersMatrix.
    tck_temp = read_mrtrix_tracks(config.track1);
    
    % Initiate new tck information for this subject.
    mergedtck = tck_temp.data;
    
    % Initiate seed and track counters for this subject, if necessary.
    if isfield(tck_temp, 'max_num_seeds') == 1
        count_seed = tck_temp.max_num_seeds;
    end
    if isfield(tck_temp, 'max_num_tracks') == 1
        count_track = tck_temp.max_num_tracks;
    end
    
    % Update user -- NOTE: Update to get subject ID from config file.
    disp('Started merging TCK files for the a new subject.')
    
    % Read in data for this subject's second tck. -- NOTE: Consider dtiImportFibersMatrix.
    tck2_temp = read_mrtrix_tracks(config.track2);
    
    % Append tck for this tck to previously added tcks for this subject.
    mergedtck = [mergedtck tck2_temp.data];
    
    % Update counters for seed and track counts for this subject, if necessary.
    if isfield(tck2_temp, 'max_num_seeds') == 1
        count_seed = count_seed + tck2_temp.max_num_seeds;
    end
    if isfield(tck2_temp, 'max_num_tracks') == 1
        count_track = count_track + tck2_temp.max_num_tracks;
    end
    
    % Update user -- NOTE: Update to get subject ID from config file.
    disp(['... merging ' num2str(i_tcks) ' of ' num2str(N_tcks) ' TCKs.'])
    
end % if isfield

% Replace the streamline data in the track_temp struct so that we keep the header information.
tck_temp.data = mergedtck;

% Update basic header information -- NOTE: Does this result in accurate header information for the merged tck?
if isfield(tck_temp, 'count') == 1
    tck_temp.count = length(tck_temp.data);
end
if isfield(tck_temp, 'total_count') == 1
    tck_temp.total_count = length(tck_temp.data);
end

% Update user -- NOTE: Update to get subject ID from config file.
disp('Writing merged TCK file for this subject...')

% Make the output directory if it does not alreayd exist.
if ~exist('output')
    
    mkdir output
    
end

% Write out merged tck file.
write_mrtrix_tracks(tck_temp, 'output/track.tck')

% Update user -- NOTE: Update to get subject ID from config file.
disp(['Finished writing merged TCK file for this subject: ' num2str(tck_temp.total_count) ' total streamlines.'])

exit

