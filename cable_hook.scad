include <configuration.scad>;

radius = 9;

module cable_hook(){
	difference(){
		union(){
			cylinder(r=radius, h=10, $fn=64, center=true);
			translate([0,-(radius-.5), 0]) cube([10, 3, 10], center=true);
		}
		cylinder(r=radius-2, h=12, $fn=64, center=true);
		translate([0,radius,0]) rotate([90,0,0]) cylinder(r=3.5, h=8, center=true, $fn=32);
		translate([0,-radius,0]) rotate([90,0,0]) cylinder(r=m3_wide_radius, h=8, center=true, $fn=32);
		translate([0,-(radius-2),0]) rotate([90,0,0]) cylinder(r=2.8, h=2, center=true, $fn=32);
	}
}

cable_hook();