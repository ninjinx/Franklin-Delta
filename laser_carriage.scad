include <configuration.scad>;
use <extrusion.scad>;

$fn = 32;

screw_size = 3;

plate_thickness = 3.0;

minor_dia = 12;
major_dia = 15.5;

separation = 40;

wheel_pos = (major_dia+extrusion)/2-0.5;

module wheel(){
	union(){
		cylinder(d = major_dia, h = 3, center = true);
		translate([0,0,1.5]) cylinder(d1 = major_dia, d2 = minor_dia, h = 2.25);
		translate([0,0,1.5+2.25]) cylinder(d = minor_dia, h = 2.25);
		mirror([0,0,1]){
			translate([0,0,1.5]) cylinder(d1 = major_dia, d2 = minor_dia, h = 2.25);
			translate([0,0,1.5+2.25]) cylinder(d = minor_dia, h = 2.25);
		}
	}
}

module carriage_base(){
	difference(){
		hull(){
			translate([-35, -separation/2]) circle(d = 10);
			translate([-35, separation/2]) circle(d = 10);
			translate([20, -separation/2]) circle(d = 10);
			translate([20, separation/2]) circle(d = 10);
		}

		//Screw Holes
		translate([0,wheel_pos]) circle(d = screw_size);
		translate([15,-wheel_pos]) circle(d = screw_size);
		translate([-15,-wheel_pos]) circle(d = screw_size);

		//Mounting holes
		translate([-30,(separation-plate_thickness)/2]) square([10, plate_thickness], center = true);
		translate([-30,-(separation-plate_thickness)/2]) square([10, plate_thickness], center = true);
	}
}

module peg(w){
	translate([-5,-2]) union(){
		square([w+6, 2]);
		intersection(){
			translate([w+4.5,2]) circle(r = 1.5);
			translate([w+4.5,2]) square([1.5,1.5]);
		}
	}
}

module click_fit(w, h){
	union(){
		translate([0,h/2])peg(w);
		mirror([0,1,0]) translate([0,h/2]) peg(w);
		translate([-5.5,0]) square([1,h+4], center = true);
		translate([-5,h/2+0.2]) square([5,1.8]);
		mirror([0,1,0]) translate([-5,h/2+0.2]) square([5,1.8]);
translate([-2.5,0]) square([5, h-5], center = true);
	}
}

module arm_holder(){
	click_fit(plate_thickness, 10);
}

/*
union(){
	arm_holder();
	translate([-13,0]) square([14,14], center = true);
}
translate([20,0]) difference(){
	square([30,30], center = true);
	square([3,10], center = true);
}*/

//carriage_base();


translate([9,0,20]) rotate([0,90,0]) linear_extrude(height = plate_thickness, center = true) carriage_base();

color("Gray") extrusion(600);

color("DimGray"){
	translate([0,(extrusion+15.5)/2-0.5,20]) rotate([0,90,0]) wheel();
	translate([0,-(extrusion+15.5)/2+0.5,35]) rotate([0,90,0]) wheel();
	translate([0,-(extrusion+15.5)/2+0.5,5]) rotate([0,90,0]) wheel();
}