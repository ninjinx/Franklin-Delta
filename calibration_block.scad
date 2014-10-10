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

module calibration_block(height){
	difference(){
		translate([extrusion*0.75, 0, 0]) cube([3*extrusion,2*extrusion,height], center=true);
		extrusion_cutout(height+10, extra_extrusion_width*2);
		translate([extrusion,0,0]){ 
			translate([0, 0, -1.5]) screw_socket();
			translate([10, 0, (height/2)-1.5]) cylinder(r=m3_nut_radius, h=4, $fn=6, center=true);
		}
	}
}

calibration_block(6);