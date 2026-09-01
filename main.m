% The 3-Clause BSD License
%
% Copyright 2026 Maksim Elizarev
%
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
%
% 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%

coarse = import_eclipse(result_file_name='COARSE',model_dir='out/');

partition = readmatrix("partition.inc",...
    "FileType","text",...
    "NumHeaderLines",1,...
    "Delimiter",' ',...
    'TrimNonNumeric',true)';
%%
load('fine/rock_fine.mat');

%%
[sub_rock,mask_active] = import_from_mapping_linear([181 317 217],partition,rock_fine,35);

%%
sub_rock = sub_rock(coarse.G.cells.indexMap);
mask_active = mask_active(coarse.G.cells.indexMap);
%%
params = build_params(rock_fine);

function params = build_params(rock_fine)
krg = TableFunction([ ...
    0     0
    0.013 0.000005
    0.026 0.000039
    0.039 0.000130
    0.052 0.000309
    0.065 0.000604
    0.078 0.001044
    0.091 0.001657
    0.104 0.002474
    0.117 0.003522
    0.130 0.004831
    0.144 0.006430
    0.157 0.008348
    0.170 0.010614
    0.183 0.013257
    0.196 0.016305
    0.209 0.019788
    0.222 0.023735
    0.235 0.028175
    0.248 0.033137
    0.261 0.038649
    0.274 0.044741
    0.287 0.051442
    0.300 0.058781
    0.313 0.066786
    0.326 0.075487
    0.339 0.084912
    0.352 0.095092
    0.365 0.106053
    0.378 0.117827
    0.391 0.130441
    0.404 0.143925
    0.418 0.158307
    0.431 0.173617
    0.444 0.189884
    0.457 0.207136
    0.470 0.225402
    0.483 0.244712
    0.496 0.265095
    0.509 0.286579
    0.522 0.309194]);

krw = TableFunction([ ...
    0.478 0
    0.491 0.000016
    0.504 0.000125
    0.517 0.000422
    0.530 0.001000
    0.543 0.001953
    0.556 0.003375
    0.569 0.005359
    0.583 0.008000
    0.596 0.011391
    0.609 0.015625
    0.622 0.020797
    0.635 0.027000
    0.648 0.034328
    0.661 0.042875
    0.674 0.052734
    0.687 0.064000
    0.700 0.076766
    0.713 0.091125
    0.726 0.107172
    0.739 0.125000
    0.752 0.144703
    0.765 0.166375
    0.778 0.190109
    0.791 0.216000
    0.804 0.244141
    0.817 0.274625
    0.830 0.307547
    0.843 0.343000
    0.856 0.381078
    0.870 0.421875
    0.883 0.465484
    0.896 0.512000
    0.909 0.561516
    0.922 0.614125
    0.935 0.669922
    0.948 0.729000
    0.961 0.791453
    0.974 0.857375
    0.987 0.926859
    1.000 1.000000]);

cap_pressure = build_pc(krg.data(:,1),rock_fine);

params = Params(krw,krg,cap_pressure,nan,1000);

end

function cap_pressure = build_pc(sg,rock_fine)
sw = 1 - sg(end:-1:1);
ans = endurance_pc(sw);
cap_pressure = pc_smeahea(sg,rock_fine);
end

function cap_pressure = endurance_pc(sw)
swfn = [8.000000e-02	0.000000e+00	1.253898e+02
    1.035897e-01	2.665023e-04	8.999371e+00
    1.271795e-01	8.840336e-04	6.062127e+00
    1.507692e-01	1.912290e-03	4.811196e+00
    1.743590e-01	3.480852e-03	4.083551e+00
    1.979487e-01	5.775429e-03	3.595831e+00
    2.215385e-01	9.051335e-03	3.240902e+00
    2.451282e-01	1.365508e-02	2.968290e+00
    2.687179e-01	2.005328e-02	2.750748e+00
    2.923077e-01	2.886903e-02	2.572136e+00
    3.158974e-01	4.092447e-02	2.422212e+00
    3.394872e-01	5.728482e-02	2.294132e+00
    3.630769e-01	7.929201e-02	2.183126e+00
    3.866667e-01	1.085634e-01	2.085760e+00
    4.102564e-01	1.469140e-01	1.999490e+00
    4.338462e-01	1.961407e-01	1.922384e+00
    4.574359e-01	2.576103e-01	1.852950e+00
    4.810256e-01	3.316395e-01	1.790013e+00
    5.046154e-01	4.168006e-01	1.732634e+00
    5.282051e-01	5.094790e-01	1.680051e+00
    5.517949e-01	6.041101e-01	1.631643e+00
    5.753846e-01	6.942807e-01	1.586891e+00
    5.989744e-01	7.743326e-01	1.545366e+00
    6.225641e-01	8.406891e-01	1.506702e+00
    6.461538e-01	8.922983e-01	1.470590e+00
    6.697436e-01	9.301909e-01	1.436767e+00
    6.933333e-01	9.566074e-01	1.405003e+00
    7.169231e-01	9.741680e-01	1.375102e+00
    7.405128e-01	9.853216e-01	1.346890e+00
    7.641026e-01	9.920853e-01	1.320217e+00
    7.876923e-01	9.959866e-01	1.294950e+00
    8.112821e-01	9.981113e-01	1.270972e+00
    8.348718e-01	9.991909e-01	1.248178e+00
    8.584615e-01	9.996935e-01	1.226476e+00
    8.820513e-01	9.999018e-01	1.205783e+00
    9.056410e-01	9.999754e-01	1.186024e+00
    9.292308e-01	9.999958e-01	1.167131e+00
    9.528205e-01	9.999996e-01	1.149045e+00
    9.764103e-01	1.000000e+00	1.131711e+00
    1.000000e+00	1.000000e+00	1.115078e+00];

sw_src = swfn(:,1);
jlev_src = TableFunction(swfn(:,[1,3]));


from_dst_to_src = griddedInterpolant([sw(1),sw(end)],[sw_src(1),sw_src(end)],"linear","none");

jlev = jlev_src.func(from_dst_to_src(sw));

mult = 28.750878 * dyne / centi / meter;

cap_pressure = CapPressure(0,mult,TableFunction([sw,jlev]),[1,1,0]);
end

function cap_pressure = pc_smeahea(sg,rock_fine)
SGFN = [
    %sg   krg   pc[barsa]
    0     0		0.01246
    0.05	0.00008		0.0127465
    0.1	0.056218235	0.013033
    0.15	0.112356471	0.0133195
    0.2	0.168494706	0.013606
    0.25	0.224632941	0.0138925
    0.3	0.280771176	0.014179
    0.35	0.336909412	0.0144655
    0.4	0.393047647	0.014752
    0.45	0.449185882	0.0150385
    0.5	0.505324118	0.015325
    0.55	0.561462353	0.0156115
    0.6	0.617600588	0.017036342
    0.65	0.673738824	0.019570297
    0.7	0.729877059	0.022967703
    0.75	0.786015294	0.027755076
    0.8	0.842153529	0.034992705
    0.85	0.898291765	0.04717574
    0.9	0.95443		0.071875136
    0.95	0.95443		0.147631778
    0.9757	0.95443		0.312312124];



sgn = SGFN(:,1);
pc = SGFN(:,3)*barsa;

permx = readmatrix("smeaheia/permx.inc","FileType","text","OutputType","double");
permx = permx';
permx = permx(:);
permx(end-2:end) = [];
permx = permx * milli * darcy;

poro = readmatrix("smeaheia/poro.inc","FileType","text","OutputType","double");
poro = poro';
poro = poro(:);
poro(end-2:end) = [];

mask = poro > 0 & permx > 0 & ~isnan(permx) & ~isnan(poro);

pmult = mean(sqrt(permx(mask)./ poro(mask)));

mult = 28.750878 * dyne / centi / meter;
jfunc = pc./mult .* pmult ./ 40;

sgn_from_sg = interp1([sg(1) sg(end)],[sgn(1) sgn(end)],sg);
jfunc_from_sgn = interp1(sgn,jfunc,sgn_from_sg);
sw = 1 - sg(end:-1:1);
jfunc_from_sgn = jfunc_from_sgn(end:-1:1);
jfunc_from_sgn = TableFunction([sw,jfunc_from_sgn]);
cap_pressure = CapPressure(0,mult,jfunc_from_sgn,[1,1,0]);
end

mask = build_mask(coarse.G,mask_active);

function mask = build_mask(coarse_grid,other_mask)
well_IJs = [
    40, 215
    22, 108
    29, 100
    33, 89
    30, 79
    80, 75
    84, 66
    85, 64
    94, 47
    87, 22
    95, 19
    129,48
    99, 104
    102, 81];
radius = 30;
[I,J,~] = ind2sub(coarse_grid.cartDims,coarse_grid.cells.indexMap);
dI = abs(I-well_IJs(:,1)');
dJ = abs(J-well_IJs(:,2)');
dR = dI;
for w = 1:size(dI,2)
    dR(:,w) = max([dI(:,w),dJ(:,w)],[],2);
end
dR = min(dR,[],2);
mask = (dR <= radius) & other_mask(1:numel(dR));
end

options = Options();...perm_threshold_mD(1e-2*[1,1,0.1]).poro_threshold(0.01);

%% C++ code generation (optional)

cdgmex = CodeGenMex().config().build();

%%

strata_trapped = strata_trapper(coarse.G,sub_rock,params,...
    "enable_waitbar",true,"options",options, mask=uint8(mask),parfor_arg=32);

for table_idx = 1:numel(strata_trapped.tables)
    strata_trapped.tables(table_idx).krw(:,end) = 1;
    strata_trapped.tables(table_idx).krg(:,1) = 0.309194;
    strata_trapped.tables(table_idx).krg(:) = min(strata_trapped.tables(table_idx).krg(:),0.309194);
end

%%

plot_result(strata_trapped,1,"kr_scale","linear","font_size",font_size);

%%

rock_coarse = default_rock(coarse);

function rock = default_rock(coarse)
rock.poro = zeros(prod(coarse.G.cartDims),1);

rock.poro(coarse.G.cells.indexMap) = coarse.init.PORV.values(coarse.G.cells.indexMap) ./ coarse.G.cells.volumes;

rock.perm = zeros(prod(coarse.G.cartDims),3);


rock.perm(coarse.G.cells.indexMap,:) = coarse.rock.perm;
rock.perm(coarse.G.cells.indexMap,1) = coarse.init.PERMX.values.*milli.*darcy;
rock.perm(coarse.G.cells.indexMap,2) = coarse.init.PERMY.values.*milli.*darcy;
rock.perm(coarse.G.cells.indexMap,3) = coarse.init.PERMZ.values.*milli.*darcy;
end

opm_export(strata_trapped,...
    "default_poro",rock_coarse.poro,...
    "default_perm",rock_coarse.perm,...
    "output_folder","mip");
