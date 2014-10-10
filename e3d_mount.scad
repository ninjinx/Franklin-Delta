include <configuration.scad>;

mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
push_fit_height = 5.5;  // Length of brass threaded into printed plastic.
height = 3;
hotend_r = 6.1;
m3_extra_clearance = 0.08;


difference(){
	cylinder(r = 20, h=height, $fn=64, center=true);
	rotate(-90) translate([0, -hotend_r, -height])
		cube([20, hotend_r*2, 2*height]);
	cylinder(r=hotend_r, h=2*height, $fn=32, center=true);
	for (a = [0:120:359]) rotate([0, 0, a]) {
			translate([0, mount_radius, 0])
				cylinder(r=m3_wide_radius + m3_extra_clearance, h=2*height, center=true, $fn=12);
	}
}