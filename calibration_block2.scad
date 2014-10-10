include <configuration.scad>;

$fn = 48;
roundness = 6;

module extrusion_cutout(h, extra) {
  difference() {
    cube([extrusion+extra, extrusion+extra, h], center=true);
    for (a = [0:90:359]) rotate([0, 0, a]) {
      translate([extrusion/2, 0, 0])
        cube([6, 2.5, h+1], center=true);
    }
  }
}

module screw_socket() {
  cylinder(r=m3_wide_radius, h=20, center=true);
  translate([0, 0, 3.8]) cylinder(r=3.5, h=5);
}

module screw_socket_side() {
  cylinder(r=m3_wide_radius_side, h=20, center=true);
  translate([0, 0, 3.8]) cylinder(r=3.5, h=5);
}

module calibration_block2(height){
	difference(){
		cube([15,15,15], center=true);
		translate([0,0,-2]) rotate([180,0,0]) screw_socket();
		translate([0, 0, 6.2]) cylinder(r=m3_nut_radius, h=4, $fn=6, center=true);
		rotate([90,0,0]){
			translate([0,0,-2]) rotate([180,0,0]) screw_socket_side();
			translate([0, 0, 6.2]) cylinder(r=m3_nut_radius_side, h=4, $fn=6, center=true);
		}
	}
}

calibration_block2();