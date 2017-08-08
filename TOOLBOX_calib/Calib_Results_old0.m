% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 912.185581361577192 ; 912.070425318282901 ];

%-- Principal point:
cc = [ 386.114188920094193 ; 235.356409190661878 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.250923784891487 ; 0.544410353373095 ; 0.012307467614144 ; -0.009658846086837 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 23.147402088793704 ; 22.807924374399249 ];

%-- Principal point uncertainty:
cc_error = [ 23.513750059451784 ; 20.373032876080078 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.066725731760323 ; 0.292094576187073 ; 0.004806006151474 ; 0.006844777826306 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 27;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.848902e+00 ; 1.906300e+00 ; 8.670017e-02 ];
Tc_1  = [ -3.691863e+02 ; -1.649313e+01 ; 1.123259e+03 ];
omc_error_1 = [ 1.986126e-02 ; 2.220055e-02 ; 3.761706e-02 ];
Tc_error_1  = [ 2.932091e+01 ; 2.572950e+01 ; 3.042018e+01 ];

%-- Image #2:
omc_2 = [ 1.676513e+00 ; 2.344168e+00 ; -1.092546e-01 ];
Tc_2  = [ -3.693092e+02 ; -1.058484e+02 ; 1.152631e+03 ];
omc_error_2 = [ 1.835348e-02 ; 3.090339e-02 ; 4.822103e-02 ];
Tc_error_2  = [ 2.990058e+01 ; 2.630925e+01 ; 3.112272e+01 ];

%-- Image #3:
omc_3 = [ 1.483563e+00 ; 2.454445e+00 ; -3.478461e-02 ];
Tc_3  = [ -2.144379e+02 ; -8.645398e+01 ; 1.120821e+03 ];
omc_error_3 = [ 1.922089e-02 ; 3.157909e-02 ; 4.804611e-02 ];
Tc_error_3  = [ 2.895983e+01 ; 2.527531e+01 ; 3.009713e+01 ];

%-- Image #4:
omc_4 = [ 1.865834e+00 ; 2.214119e+00 ; -5.109025e-02 ];
Tc_4  = [ -3.570513e+02 ; -3.295369e+01 ; 1.077941e+03 ];
omc_error_4 = [ 2.244218e-02 ; 3.042624e-02 ; 5.021919e-02 ];
Tc_error_4  = [ 2.800984e+01 ; 2.470339e+01 ; 2.955405e+01 ];

%-- Image #5:
omc_5 = [ NaN ; NaN ; NaN ];
Tc_5  = [ NaN ; NaN ; NaN ];
omc_error_5 = [ NaN ; NaN ; NaN ];
Tc_error_5  = [ NaN ; NaN ; NaN ];

%-- Image #6:
omc_6 = [ NaN ; NaN ; NaN ];
Tc_6  = [ NaN ; NaN ; NaN ];
omc_error_6 = [ NaN ; NaN ; NaN ];
Tc_error_6  = [ NaN ; NaN ; NaN ];

%-- Image #7:
omc_7 = [ 1.861323e+00 ; 1.931735e+00 ; 2.837074e-02 ];
Tc_7  = [ -3.308358e+02 ; -1.696000e+02 ; 1.199418e+03 ];
omc_error_7 = [ 1.851752e-02 ; 2.433696e-02 ; 3.775842e-02 ];
Tc_error_7  = [ 3.121177e+01 ; 2.721210e+01 ; 3.246811e+01 ];

%-- Image #8:
omc_8 = [ NaN ; NaN ; NaN ];
Tc_8  = [ NaN ; NaN ; NaN ];
omc_error_8 = [ NaN ; NaN ; NaN ];
Tc_error_8  = [ NaN ; NaN ; NaN ];

%-- Image #9:
omc_9 = [ 1.917091e+00 ; 2.329950e+00 ; 8.302884e-01 ];
Tc_9  = [ -1.840897e+02 ; -1.267184e+02 ; 1.092024e+03 ];
omc_error_9 = [ 2.427710e-02 ; 1.705213e-02 ; 4.081452e-02 ];
Tc_error_9  = [ 2.850260e+01 ; 2.449400e+01 ; 3.223161e+01 ];

%-- Image #10:
omc_10 = [ 1.776424e+00 ; 1.682651e+00 ; -7.187494e-02 ];
Tc_10  = [ -3.298738e+02 ; -1.408374e+02 ; 1.239308e+03 ];
omc_error_10 = [ 1.747304e-02 ; 2.207543e-02 ; 3.220209e-02 ];
Tc_error_10  = [ 3.210430e+01 ; 2.806968e+01 ; 3.349324e+01 ];

%-- Image #11:
omc_11 = [ 2.391219e+00 ; 1.435054e+00 ; 7.278597e-01 ];
Tc_11  = [ -1.475042e+02 ; 4.883065e+00 ; 1.274100e+03 ];
omc_error_11 = [ 2.913354e-02 ; 1.313519e-02 ; 3.922343e-02 ];
Tc_error_11  = [ 3.289707e+01 ; 2.845117e+01 ; 3.554746e+01 ];

%-- Image #12:
omc_12 = [ 2.240413e+00 ; 9.861455e-01 ; 2.957691e-01 ];
Tc_12  = [ -2.110410e+02 ; -2.916685e+01 ; 1.328622e+03 ];
omc_error_12 = [ 2.439169e-02 ; 1.580415e-02 ; 3.476597e-02 ];
Tc_error_12  = [ 3.423924e+01 ; 2.974750e+01 ; 3.659689e+01 ];

%-- Image #13:
omc_13 = [ 1.453820e+00 ; 1.968204e+00 ; 2.117482e-01 ];
Tc_13  = [ -9.262006e+01 ; -1.717718e+02 ; 1.376221e+03 ];
omc_error_13 = [ 1.957893e-02 ; 2.293405e-02 ; 3.189605e-02 ];
Tc_error_13  = [ 3.557708e+01 ; 3.080251e+01 ; 3.540203e+01 ];

%-- Image #14:
omc_14 = [ 1.784779e+00 ; 2.105177e+00 ; -7.049875e-01 ];
Tc_14  = [ -1.177109e+02 ; -1.455996e+02 ; 1.459498e+03 ];
omc_error_14 = [ 1.440481e-02 ; 2.477446e-02 ; 3.898113e-02 ];
Tc_error_14  = [ 3.774031e+01 ; 3.256663e+01 ; 3.533142e+01 ];

%-- Image #15:
omc_15 = [ 1.703099e+00 ; 2.109406e+00 ; -5.255804e-02 ];
Tc_15  = [ -6.250118e+01 ; -2.097458e+02 ; 1.163140e+03 ];
omc_error_15 = [ 1.976217e-02 ; 2.494700e-02 ; 3.829563e-02 ];
Tc_error_15  = [ 3.022620e+01 ; 2.606400e+01 ; 2.929417e+01 ];

%-- Image #16:
omc_16 = [ 2.324698e+00 ; 1.502769e+00 ; 4.441263e-01 ];
Tc_16  = [ -3.838230e+02 ; -9.151957e+01 ; 9.736664e+02 ];
omc_error_16 = [ 2.457416e-02 ; 1.805720e-02 ; 3.781534e-02 ];
Tc_error_16  = [ 2.597312e+01 ; 2.247627e+01 ; 2.736260e+01 ];

%-- Image #17:
omc_17 = [ 1.955794e+00 ; 1.948607e+00 ; 2.884766e-01 ];
Tc_17  = [ -2.970812e+02 ; -1.851752e+02 ; 1.004186e+03 ];
omc_error_17 = [ 2.120743e-02 ; 2.341651e-02 ; 3.719114e-02 ];
Tc_error_17  = [ 2.652156e+01 ; 2.286403e+01 ; 2.754112e+01 ];

%-- Image #18:
omc_18 = [ 2.006011e+00 ; 1.995130e+00 ; 2.446761e-01 ];
Tc_18  = [ -3.642668e+02 ; -1.791262e+02 ; 9.613555e+02 ];
omc_error_18 = [ 2.197011e-02 ; 2.601525e-02 ; 4.077157e-02 ];
Tc_error_18  = [ 2.560488e+01 ; 2.217167e+01 ; 2.645350e+01 ];

%-- Image #19:
omc_19 = [ 1.822480e+00 ; 1.845495e+00 ; 5.222639e-01 ];
Tc_19  = [ -1.452216e+02 ; -1.697248e+02 ; 1.057860e+03 ];
omc_error_19 = [ 2.271953e-02 ; 2.049478e-02 ; 3.326901e-02 ];
Tc_error_19  = [ 2.757560e+01 ; 2.368494e+01 ; 2.922698e+01 ];

%-- Image #20:
omc_20 = [ 2.235855e+00 ; 2.149750e+00 ; -3.217551e-01 ];
Tc_20  = [ -2.566967e+02 ; -1.385195e+02 ; 1.163974e+03 ];
omc_error_20 = [ 1.980437e-02 ; 2.435683e-02 ; 5.008767e-02 ];
Tc_error_20  = [ 3.018014e+01 ; 2.620369e+01 ; 2.979041e+01 ];

%-- Image #21:
omc_21 = [ 2.575204e+00 ; 1.663419e+00 ; -3.345385e-01 ];
Tc_21  = [ -3.292121e+02 ; -2.837964e+01 ; 1.162506e+03 ];
omc_error_21 = [ 2.148956e-02 ; 1.972086e-02 ; 4.921644e-02 ];
Tc_error_21  = [ 3.011333e+01 ; 2.636907e+01 ; 3.034926e+01 ];

%-- Image #22:
omc_22 = [ 2.758678e+00 ; 1.320119e+00 ; -2.232889e-01 ];
Tc_22  = [ -2.956978e+02 ; 4.900513e+01 ; 1.108723e+03 ];
omc_error_22 = [ 2.589714e-02 ; 1.637082e-02 ; 5.237757e-02 ];
Tc_error_22  = [ 2.868475e+01 ; 2.510378e+01 ; 2.940368e+01 ];

%-- Image #23:
omc_23 = [ NaN ; NaN ; NaN ];
Tc_23  = [ NaN ; NaN ; NaN ];
omc_error_23 = [ NaN ; NaN ; NaN ];
Tc_error_23  = [ NaN ; NaN ; NaN ];

%-- Image #24:
omc_24 = [ 2.364641e+00 ; 1.373666e+00 ; 3.850059e-01 ];
Tc_24  = [ -2.477911e+02 ; -1.363248e+01 ; 1.005753e+03 ];
omc_error_24 = [ 2.537670e-02 ; 1.473990e-02 ; 3.840660e-02 ];
Tc_error_24  = [ 2.609107e+01 ; 2.268090e+01 ; 2.765172e+01 ];

%-- Image #25:
omc_25 = [ 1.394032e+00 ; 2.272787e+00 ; -1.861455e-01 ];
Tc_25  = [ -1.716763e+02 ; -2.643825e+02 ; 1.154237e+03 ];
omc_error_25 = [ 1.300769e-02 ; 2.676472e-02 ; 3.575172e-02 ];
Tc_error_25  = [ 3.015938e+01 ; 2.596614e+01 ; 2.945209e+01 ];

%-- Image #26:
omc_26 = [ 2.082846e+00 ; 1.359624e+00 ; 3.308585e-01 ];
Tc_26  = [ -1.685218e+02 ; -6.875362e+00 ; 9.738316e+02 ];
omc_error_26 = [ 2.346164e-02 ; 1.598475e-02 ; 3.381820e-02 ];
Tc_error_26  = [ 2.508028e+01 ; 2.178444e+01 ; 2.625271e+01 ];

%-- Image #27:
omc_27 = [ 2.190040e+00 ; 8.248494e-01 ; 4.417586e-01 ];
Tc_27  = [ -1.586834e+02 ; 1.024585e+01 ; 9.462714e+02 ];
omc_error_27 = [ 2.413138e-02 ; 1.478592e-02 ; 3.197324e-02 ];
Tc_error_27  = [ 2.437369e+01 ; 2.117970e+01 ; 2.645779e+01 ];

