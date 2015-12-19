include <configuration.scad>;

use <extrusion.scad>;
use <laser_carriage.scad>;
use <effector.scad>;
use <e3d_v6.scad>;
use <nema17.scad>;
use <lower_vert.scad>;

for(i = [0, 120, 240]){
	rotate([0,0,i]) translate([outer_radius,0,0]) extrusion(600);
	rotate([0,-90,30+i]) translate([7.5, -inner_radius-7.5, 0]) extrusion(240, center = true);
	rotate([0,-90,30+i]) translate([base_height-7.5, -inner_radius-7.5, 0]) 
		extrusion(240, center = true);
	rotate([0,-90,30+i]) translate([590-7.5, -inner_radius-7.5, 0]) extrusion(240, center = true);

	rotate([0,0,i]) translate([outer_radius,0,380]) rotate([0,0,180]) carriage_complete();

	/*color([0.25,0.25,0.25]){
	rotate([0,0,i]) translate([131,28,430]) 
		rotate([0,-90-48,0]) cylinder(d = 6, h = 180, $fn = 32);
	rotate([0,0,i]) translate([131,-28,430]) 
		rotate([0,-90-48,0]) cylinder(d = 6, h = 180, $fn = 32);
	}*/

	color("grey") rotate([0,90,i]) translate([-(42.2/2+8),0, outer_radius-38]) nema17();

	color([0.3,0.3,0.3]){
		rotate([0,0,i]) translate([-inner_radius-15-1.5, 0, base_height/2]) 
			cube(size = [3,side_length,base_height], center = true);

		rotate([0,0,i]) translate([corner_distance+1.5, 0, base_height/2]) 
			cube(size = [3,corner_length,base_height], center = true);
	}

	color("red") rotate([0,0,i]) translate([outer_radius, 0, 0]) lower_vert();
	color("red") rotate([0,0,i]) translate([outer_radius, 0, base_height-15]) lower_vert();
	color("red") rotate([0,0,i]) translate([outer_radius, 0, 575]) lower_vert();
}

%translate([0,0,base_height+.1]) cylinder(d = 200, h = 3, $fn = 64);
translate([0,0,55+240]) effector_base();
translate([0,0,55+240-2.5]) e3d_v6();

color("green") translate([-(inner_radius-130/2+15),0,15+25/2]) 
	cube(size = [130,110,25], center = true);

color("blue")	rotate([0,0,-30]) 
	translate([0,inner_radius-psu_h/2,psu_w/2]) cube(size = [psu_l, psu_h, psu_w], center = true);
color("blue")	rotate([0,0,-150]) 
	translate([0,inner_radius-psu_h/2,psu_w/2]) cube(size = [psu_l, psu_h, psu_w], center = true);
