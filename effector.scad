include <configuration.scad>;
include <fan.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 9.0;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
m3_extra_clearance = 0.08;
fan_twist = 8;
fan_dist = 57;
fan_angle = 44;

module fan_arm(){
	union(){
		difference(){
			translate([13.5,-(fan_dist+(20-7)),5]) cube([6,fan_dist,3]);
			translate([16, -16, 0]) cylinder(r=1.65, h=25, center=true);
		}
		mirror([1,0,0]) difference(){
			translate([13.5,-(fan_dist+(20-7)),5]) cube([6,fan_dist,3]);
			translate([16, -16, 0]) cylinder(r=1.65, h=25, center=true);
		}
		difference(){
			translate([-14,-35,5]) cube([28,20,3]);
			translate([0,7,6]) cylinder(r=26, h=6,center=true, $fn=32);
			translate([0,-46,6]) cylinder(r=18, h=6,center=true, $fn=32);
		}
	}
	//#fan(40);
}

module fan_holder(){
	rotate([180,0,-6]) for(i = [0, 120, 240]){
		rotate([-fan_angle,0,i]) translate([0,fan_dist,0]) rotate([-15.4, fan_twist, 0]){
			fan_arm();
		}
	}
}

module effector() {
  difference() {
    union() {
      cylinder(r=offset-3, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-2, 0, 0])
	  cube([10, 13, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      #cylinder(r=m3_radius+.40, h=separation+1, center=true, $fn=12);
	    rotate([90, 0, 90])
	      #cylinder(r=m3_nut_radius-0.35, h=separation-20, center=true, $fn=6);
	  }
        }
      }
    }
    translate([0, 0, push_fit_height-height/2])
      cylinder(r=hotend_radius, h=height, $fn=36);
    translate([0, 0, -6]) cylinder(r=2.75, h=2*height, center=true, $fn=12);;
    for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius+0.25, h=2*height, center=true, $fn=12);
    }
  }
}

translate([0, 0, height/2]) effector();