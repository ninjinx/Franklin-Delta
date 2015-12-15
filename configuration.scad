// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;
extra_extrusion_width = 0.5;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.35 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 15;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;

fsr_offset = 3;


//NEW CONFIG 
//PSU
psu_w = 57;
psu_h = 32;
psu_l = 126;

inner_radius = 95;
outer_radius = 162;
base_height = psu_w;
side_length = 280;

v1 = [cos(60)*(inner_radius+15+3), sin(60)*(inner_radius+15+3)];
v2 = [cos(-30)*side_length/2, sin(-30)*side_length/2];
v3 = v1+v2;

corner_length = v3[1]*2;
corner_distance = v3[0];

echo(corner_length);
