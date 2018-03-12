#############################################################################
# Model with 9-4-quad-UP element and PressureDependentMultiYield material   #
# By: Arash Khosravifar   January 2009                    #
# Last edit:        August 2010                   #
#############################################################################

wipe
wipe all
set startT [clock seconds]

# define soil material variables
#Elgamal DR 75
set matTag_1              1;
set massDen_1             2.1;  # (ton/m3)
set refG_1                13e4; # (kPa)
set poisson_1             0.33333333;
set refB_1                26e4; #(kPa)
set frinctionAng_1        36.5; # (degree)
set phaseTransAng_1       26;   # (degree)
set peakShearStrain_1     0.1;
set refPress_1            101.;  # (kPa)
set pressDependCoe_1      0.5;

set contractionParam1_1   0.013;    #-->contraction rate
set contractionParam2_1   5.0;    #-->fabric damage
set contractionParam3_1   0.00;     #-->k_sigma effect

set dilationParam1_1      0.3;
set dilationParam2_1      3.0;
set dilationParam3_1      0.0;

set liqParam1_1           1.0;
set liqParam2_1           0.0;

set noYieldSurf_1         100
set void_1                0.55;
set porosity_1            [expr $void_1/(1+$void_1)];
set cs1_1                 0.9;
set cs2_1                 0.02;
set cs3_1                 0.7;
set pa_1                  101; # (kPa)
set c_1                   0.1; # (kPa)


#My Loose Sand
set matTag_2              2;
set massDen_2             1.99; #(ton/m3)
set refG_2                7.5e4; # (kPa)
set poisson_2             0.33333;
set refB_2                [expr 2*$refG_2*(1+$poisson_2)/(3*(1-2*$poisson_2))]; #(kPa)
set frinctionAng_2        30;
set phaseTransAng_2       26;
set peakShearStrain_2      0.1;
set refPress_2             101; # (kPa)
set pressDependCoe_2       0.5;

set contractionParam1_2    0.057;
set contractionParam2_2    5.0; # As suggested by the manual
set contractionParam3_2    0.23; #As suggested by the manual

set dilationParam1_2       0.06;
set dilationParam2_2       3.0; # As suggested by the manual
set dilationParam3_2       0.27; #0.0 Want to see K-sigma's effect only in the contraction zone (before dilation)

set liqParam1_2            1.0;
set liqParam2_2            10.0;

set noYieldSurf_2          100;
set void_2                 0.8; #
set porosity_2             [expr $void_2/(1+$void_2)];
set cs1_2                  0.9;
set cs2_2                  0.02; #0.1;
set cs3_2                  0.7; #1.0;
set pa_2                   101; # (kPa)
set c_2                    0.1; # (kPa)

#Elgamal DR 40%
set matTag_3              3;
set massDen_3             1.9; #(ton/m3)
set refG_3                9.e4; # (kPa)
set poisson_3             0.33333;
set refB_3                22e4; #(kPa)
set frinctionAng_3        32;
set phaseTransAng_3       26;
set peakShearStrain_3      0.1;
set refPress_3             101; # (kPa)
set pressDependCoe_3       0.5;

set contractionParam1_3    0.067;   #0.067
set contractionParam2_3    0.0; # As suggested by the manual
set contractionParam3_3    0.23; #0.23As suggested by the manual

set dilationParam1_3       0.06; #0.06
set dilationParam2_3       3.0; # As suggested by the manual
set dilationParam3_3       0.0; #0.27 Want to see K-sigma's effect only in the contraction zone (before dilation)

set liqParam1_3            1.0;
set liqParam2_3            0.0;

set noYieldSurf_3          100;
set void_3                 0.77; #
set porosity_3             [expr $void_2/(1+$void_2)];
set cs1_3                  0.9;
set cs2_3                  0.02; #0.1;
set cs3_3                  0.7; #1.0;
set pa_3                   101; # (kPa)
set c_3                    0.1; # (kPa)

# some user defined variables for the ELEMENT
# set press         0;   # Isotropic consolidation pressure on quad element(s)
set vertPress     [expr 1.0*(40)];  # kPa vertical gravity load to consolidate
set inclination   0;
set slope         [expr $inclination*3.14/180.];
set loadbias      [expr sin($slope)];

set fluidDen      1.0;       # Fluid mass density
set waterbulk     2.2e6;  #2.2e6 for liq case and 0.0022 for nonliq case
set kdrain        1.e1;      # permeability during gravity and consolidation
set kundrain      1.e-8;    # permeability during cyclic loading
set gravY         0.0;
set gravX         0.0;


set matTag $matTag_2


set csr           0.0689;
set numcycles     43.;
set period        0.1;
set deltaT        0.01;
set duration      [expr $period*$numcycles];
set numSteps      [expr $duration/$deltaT];
set kPerm       $kdrain


# Define Raleight Damping
set raleigh_damping1  0.001; #0.001;
set raleigh_damping2  0.001; #0.001;
set raleigh_w1      [expr 2*3.14/$period];
set raleigh_w2      [expr 2*3.14/($period/2.0)];
set Kinitpropraleigh  [expr 2*$raleigh_w1*$raleigh_w2/($raleigh_w1*$raleigh_w1-$raleigh_w2*$raleigh_w2)*(-1*$raleigh_damping1/$raleigh_w1+1*$raleigh_damping2/$raleigh_w2)]; #This is a1 [expr 2*$dampratio/(2*3.1416/0.02)];
set Mpropraleigh    [expr 2*$raleigh_w1*$raleigh_w2/($raleigh_w1*$raleigh_w1-$raleigh_w2*$raleigh_w2)*($raleigh_damping1*$raleigh_w1-$raleigh_damping2*$raleigh_w2)]; #This is a0 [expr 2*$dampratio*(2*3.1416/2.0)];





#puts "Do you wish to continue y/n ?"; # include if want to pause at analysis failure
#gets stdin ans; # not recommended in parameter study
#if {$ans == "n"} done; # as it interrupts batch file
####################################################################
set xsize 0.1;
set ysize 0.1;
set thickness 0.1;

# define the 3D nodes
model basic -ndm 2 -ndf 3
node 1   0.0 0.0
node 2   $xsize 0.0
node 3   $xsize $ysize
node 4   0.0 $ysize

fix 1  1 1 0
fix 2  1 1 0
fix 3  0 0 1
fix 4  0 0 1
equalDOF 1 2  3
equalDOF 3 4  1 2

# define the 2D nodes
model basic -ndm 2 -ndf 2
node 5   [expr $xsize/2] 0.0
node 6   $xsize [expr $ysize/2]
node 7   [expr $xsize/2] $ysize
node 8   0.0 [expr $ysize/2]
node 9   [expr $xsize/2] [expr $ysize/2]

fix 5 1 1
equalDOF 3 7  1 2
equalDOF 6 8  1 2
equalDOF 6 9  1 2

####################################################################
# define material
eval "nDMaterial PressureDependMultiYield02 $matTag_2 2 $massDen_2 $refG_2 $refB_2 $frinctionAng_2 \
  $peakShearStrain_2 $refPress_2 $pressDependCoe_2 $phaseTransAng_2 \
  $contractionParam1_2 $contractionParam3_2 $dilationParam1_2 $dilationParam3_2 \
  $noYieldSurf_2 $contractionParam2_2 $dilationParam2_2 $liqParam1_2 $liqParam2_2 \
  $void_2 $cs1_2 $cs2_2 $cs3_2 $pa_2 $c_2;"

eval "nDMaterial PressureDependMultiYield02 $matTag_1 2 $massDen_1 $refG_1 $refB_1 $frinctionAng_1 \
  $peakShearStrain_1 $refPress_1 $pressDependCoe_1 $phaseTransAng_1 \
  $contractionParam1_1 $contractionParam3_1 $dilationParam1_1 $dilationParam3_1 \
  $noYieldSurf_1 $contractionParam2_1 $dilationParam2_1 $liqParam1_1 $liqParam2_1 \
  $void_1 $cs1_1 $cs2_1 $cs3_1 $pa_1 $c_1;"

  eval "nDMaterial PressureDependMultiYield02 $matTag_3 2 $massDen_3 $refG_3 $refB_3 $frinctionAng_3 \
  $peakShearStrain_3 $refPress_3 $pressDependCoe_3 $phaseTransAng_3 \
  $contractionParam1_3 $contractionParam3_3 $dilationParam1_3 $dilationParam3_3 \
  $noYieldSurf_3 $contractionParam2_3 $dilationParam2_3 $liqParam1_3 $liqParam2_3 \
  $void_3 $cs1_3 $cs2_3 $cs3_3 $pa_3 $c_3;"
####################################################################
# define the element                     thick        maTag     bulk              fmass      hPerm   vPerm
element 9_4_QuadUP  1  1 2 3 4 5 6 7 8 9  $thickness $matTag    [expr $waterbulk/0.4]  $fluidDen  $kPerm $kPerm $gravX $gravY;

parameter 10000 element 1 hPerm
parameter 10001 element 1 vPerm

####################################################################
# Recorders
file mkdir output
eval "recorder Node -file output/dispx.out -time -node 1 2 3 4 5 6 7 8 9 -dof 1 disp";
eval "recorder Node -file output/dispy.out -time -node 1 2 3 4 5 6 7 8 9 -dof 2 disp";
eval "recorder Node -file output/pwp.out -time -node 1 2 3 4 -dof 3 vel";
eval "recorder Node -file output/accx.out -time -node 1 2 3 4 -dof 1 accel";
eval "recorder Node -file output/accy.out -time -node 1 2 3 4 -dof 2 accel";
eval "recorder Element -file output/stress9.out -time -ele 1 material 9 stress";  # s11 s22 s33 s12 eta (EFFECTIVE stresses)
eval "recorder Element -file output/strain9.out -time -ele 1 material 9 strain";  # e11 e22 g12 (it is not e33 nor e12)
eval "recorder Element -file output/backbone.out -ele 1 material 9 backbone 100 1600";
####################################################################
# GRAVITY APPLICATION (elastic behavior)
model basic -ndm 2 -ndf 3
pattern Plain 1 Constant {
  load 3 [expr $loadbias*$vertPress*$xsize*$thickness*0.25] [expr -$vertPress*$xsize*$thickness*0.25] 0
  load 4 [expr $loadbias*$vertPress*$xsize*$thickness*0.25] [expr -$vertPress*$xsize*$thickness*0.25] 0
}
model basic -ndm 2 -ndf 2
pattern Plain 2 Constant {
  load 7 [expr $loadbias*$vertPress*$xsize*$thickness*0.5] [expr -$vertPress*$xsize*$thickness*0.5]
}

numberer RCM
system ProfileSPD
test NormDispIncr 1.e-5 50 2
constraints Plain; #Penalty 1.e18 1.e18
rayleigh $Mpropraleigh 0.0 $Kinitpropraleigh 0.0
set gama 1.5;
set betta [expr pow($gama+0.5, 2)/4]; #[expr 1./4.]; # 0.25 for const accel, 1/6 for linear accel (in this case deltaT<period/pi)
integrator Newmark $gama $betta;
algorithm KrylovNewton
analysis VariableTransient

updateMaterialStage -material 1 -stage 0
updateMaterialStage -material 2 -stage 0
updateMaterialStage -material 3 -stage 0
for {set i 1} {$i <= 100} {incr i 1} {
analyze 1 1000
set tCurrent [getTime]
puts "time = $tCurrent sec"
}
for {set i 1} {$i <= 100} {incr i 1} {
analyze 1 1000
set tCurrent [getTime]
puts "time = $tCurrent sec"
}
puts "Done Elastic"

#puts "Do you wish to continue y/n ?"; # include if want to pause at analysis failure
#gets stdin ans; # not recommended in parameter study
#if {$ans == "n"} done; # as it interrupts batch file


updateMaterialStage -material 1 -stage 1
updateMaterialStage -material 2 -stage 1
updateMaterialStage -material 3 -stage 1

for {set i 1} {$i <= 100} {incr i 1} {
analyze 1 100
set tCurrent [getTime]
puts "time = $tCurrent sec"
}
for {set i 1} {$i <= 200} {incr i 1} {
analyze 1 1000
set tCurrent [getTime]
puts "time = $tCurrent sec"
}
puts "Done Plastic"
puts "Gravity Done!"


####################################################################
# Adjust some fixities for shear loading

updateParameter 10000 $kundrain
updateParameter 10001 $kundrain

# remove surface pwp fixity
model basic -ndm 2 -ndf 3
remove sp 3 3
remove sp 4 3
equalDOF 3 4  3

# equalDOF middle node
# equalDOF 6 9 1 2

####################################################################
loadConst -time 0.0
wipeAnalysis
####################################################################
# NOW APPLY LOADING SEQUENCE AND ANALYZE (plastic)

# Define analysis parameters
numberer RCM
system ProfileSPD
test NormDispIncr 1.e-5 10 1
constraints Plain
rayleigh $Mpropraleigh  0.0 $Kinitpropraleigh 0.0
set gama 0.5; #0.5; #gama=alfa in other texts
set betta [expr pow($gama+0.5, 2)/4]; # 0.25 for const accel, 1/6 for linear accel (in this case deltaT<period/pi)
integrator Newmark $gama $betta;
algorithm KrylovNewton
analysis VariableTransient

model basic -ndm 2 -ndf 3
pattern Plain 4 "Sine 0 $duration $period" {
  load 3 [expr $csr*$vertPress*$xsize*$thickness*0.25] 0 0
  load 4 [expr $csr*$vertPress*$xsize*$thickness*0.25] 0 0
}
model basic -ndm 2 -ndf 2
pattern Plain 5 "Sine 0 $duration $period" {
  load 7 [expr $csr*$vertPress*$xsize*$thickness*0.5] 0
}

set currentTime 0.0
set success 0;
set motiondt $deltaT
while {$currentTime <= $duration} {
  puts "current time at top of loop $currentTime"
  # perform analysis with timestep reduction loop and drain monitoring
  set ok [analyze 1 $deltaT]
  puts "number of successes $success"
  if {$ok ==0} {
    incr success 1;
    if {$success > 10} {
      puts "10 successful iterations, increasing dT"
      set deltaT [expr $deltaT*2.0]
      set success 0;
      if {$deltaT > $motiondt} {
        if {$deltaT < $duration} {
          puts "still in time of significant shaking, limiting dT to $motiondt"
          set deltaT $motiondt;
          puts "exiting current time loop"
        }
        puts "exiting compdT greater than $motiondt loop"
      }
      if {$deltaT > [expr 10*$motiondt]} {
        puts "deltaT has reached a max of [expr 10*$motiondt]"
        set deltaT [expr 10*$motiondt]
      }
      puts "new deltaT $deltaT"
    }
  }
  # if analysis fails, reduce timestep and continue with analysis
  if {$ok != 0} {
   puts "did not converge, reducing time step"
   set curTime  [getTime]
   puts "curTime: $curTime"
   set deltaT [expr $deltaT/2.0]
   puts "deltaT: $deltaT"
   puts "failed to converge, new dT is $deltaT"
   set success 0;
 }
 set currentTime [getTime]
}
####################################################################
set endT [clock seconds]
puts "Execution time: [expr $endT-$startT] seconds."
puts "Finished with cyclic loading"
wipe all
wipe;  # flush ouput stream
