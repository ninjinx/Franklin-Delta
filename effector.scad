include <configuration.scad>;
include <fan.scad>;
use <e3d_v6.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 9.0;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
m3_extra_clearance = 0.08;

fan_size = 30;
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

module effector_fan_mount(){
	//Fan mount
	difference(){
		translate([18,0,17]) rotate([0,-20,0]) cube(size = [6,32,30], center = true);		
		translate([18,0,17]) rotate([0,90-20,0]) cylinder(r = 14, h = 8, center = true, $fn = 32);
	}
}

module effector_base(){
	difference(){
		union(){
			cylinder(r = 20, h = height, $fn = 64, center = true); //Base
			cylinder(r = 16, h = (height/2)+26.5, $fn = 32); //Tower

			/** E3D screw towers **/
			rotate([0,0,30]) translate([0,15,0]) cylinder(r = 3, h = (height/2)+26.5, $fn = 16);
			rotate([0,0,-30]) translate([0,-15,0]) cylinder(r = 3, h = (height/2)+26.5, $fn = 16);
			rotate([0,0,30]) translate([0,-15,0]) cylinder(r = 3, h = (height/2)+26.5, $fn = 16);
			rotate([0,0,-30]) translate([0,15,0]) cylinder(r = 3, h = (height/2)+26.5, $fn = 16);

			/** Arm connectors **/
			for(i = [0 : 120 : 359]){
				rotate([90, 0, i]) translate([offset, 0, 0]) {
					cylinder(r = height/2, h = separation-8, center = true);
					translate([-height/2,0,0]) cube(size = [8, height, separation-8], center = true);
					translate([0,0,(separation-8)/2]) cylinder(r1 = height/2, r2 = 2.5, h = 4);
					translate([0,0,-(separation-8)/2-4]) cylinder(r2 = height/2, r1 = 2.5, h = 4);
				}
			}
		}
		/*** HOLES ***/
	
		translate([0,0,-(1+height/2)]) cylinder(r = 12, h = height+28, $fn = 32); //E3D hole

		//Airflow
		translate([0,0,(height+27.5+20)/2]) cube(size = [32, 20, 27.5], center = true);
		translate([0,0,(height+20)/2]) rotate([0,90,0]) 
			cylinder(r = 10, h = 32, $fn = 32, center = true);

		//Arm connector holes
		for(i = [0 : 120 : 359]){
			rotate([90, 0, i]) translate([offset, 0, 0]) {
				cylinder(r = m3_radius+0.4, h = separation+2, center = true);
			}
		}

		/** E3D mount screw holes **/
		rotate([0,0,30]) translate([0,15,10]) cylinder(r = 1.5, h = (height/2)+26.5, $fn = 16);
		rotate([0,0,-30]) translate([0,-15,10]) cylinder(r = 1.5, h = (height/2)+26.5, $fn = 16);
		rotate([0,0,30]) translate([0,-15,10]) cylinder(r = 1.5, h = (height/2)+26.5, $fn = 16);
		rotate([0,0,-30]) translate([0,15,10]) cylinder(r = 1.5, h = (height/2)+26.5, $fn = 16);
	}
}

effector_base();
//effector_fan_mount();
//translate([0,0,height]) rotate([0,0,-30]) effector();
translate([0,0,-2.5]) rotate([0,0,0]) e3d_v6();