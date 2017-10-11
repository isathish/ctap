% Create setup for synthetic data based parameter sweeps


%% Often changed 

% Location of project root, very user specific
%projectRoot = '/home/jkor/work_local/projects/hydra';
projectRoot = '/ukko/projects/ReKnow/HYDRA/CTAP';

% This one assumes that working directory is ctap_dev repo root:
%seed_srcdir = '/home/jkor/work_local/projects/ctap/ctap_pipeline/ctap/data/';
seed_srcdir = fullfile(cd(),'/ctap/data');

% Which parts of code to run etc.
RECOMPUTE_SYNDATA = false;
RERUN_PREPRO = false;
STOP_ON_ERROR = true;
OVERWRITE_OLD_RESULTS = true;


%% Steady parameters

% Data generation parameters
big_data = true;
if big_data
    EEG_LEN_MIN = 20;
    SRATE = 512;
else  
    EEG_LEN_MIN = 5;
    SRATE = 256;
end
CH_FILE = 'chanlocs128_biosemi.elp';
EEG_LENGTH = 60 * EEG_LEN_MIN; %in seconds ? 
MODEL_ORDER = 20;
%todo: these are some kind of maxima, how?
BLINK_N = 10 * EEG_LEN_MIN;
EMG_N = 5 * EEG_LEN_MIN;
WRECK_N = 10;
WRECK_MULTIPLIER_ARR = [2 1/2 3 1/3 4 1/4 5 1/5 6 1/6];
%chmatch = ismember({chanlocs.labels}, 'A4');
%chanlocs(chmatch)


% CTAP config
ctapRoot = fullfile(projectRoot);
Cfg.env.paths = cfg_create_paths(ctapRoot, branch_name, '');
Cfg.eeg.chanlocs = CH_FILE;
chanlocs = readlocs(CH_FILE);

Cfg.eeg.reference = {'L_MASTOID' 'R_MASTOID'};
Cfg.eeg.veogChannelNames = {'C17'}; %'C17' has highest blink amplitudes
Cfg.eeg.heogChannelNames = {'HEOG1','HEOG2'};
Cfg.grfx.on = false;


seed_fname = 'BCICIV_calib_ds1a.set';
syndata_dir = fullfile(Cfg.env.paths.ctapRoot, 'syndata');
mkdir(syndata_dir);