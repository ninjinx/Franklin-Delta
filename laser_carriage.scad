/////******* HUSK AT ÆNDRE MØTRIKSTØRRELSE!!!! **********//////////

include <configuration.scad>;
use <extrusion.scad>;

$fn = 32;

screw_size = 3;
screw_length = 8;

plate_thickness = 3.0;
kerf = 0.14;

//Wheel dimensions
minor_dia = 12;
major_dia = 15.5;

separation = 60;

belt_height = 17.8;

wheel_pressure = 0.93;
wheel_pos = (major_dia+extrusion)/2-wheel_pressure;
arm_pos = 18.3;
horn_thickness = 5;

pls = plate_thickness-kerf;

module nut(d){
	color("silver"){
		difference(){
			cylinder(d = 1.8*d, h = 0.8*d, $fn = 6, center = true);
			cylinder(d = d, h = 0.8*d+1, center = true);
		}
	}
}

module screw(l){
	color("silver"){
		difference(){
			union(){
				cylinder(h = l, d = screw_size);
				translate([0,0,-3]) cylinder(h = 3, d = 5.5);
			}
			translate([0,0,-3.5]) cylinder(h=2.5, d = 2.8125, $fn = 6);
		}
	}
}

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

module mounting_holes(){
		pos = (separation-plate_thickness)/2-horn_thickness;

		translate([-5, pos]) square([4-2*kerf, pls], center = true);
		translate([5, pos]) square([4-2*kerf, pls], center = true);

		translate([0, pos]) circle(d = 3);
}

module carriage_base(){
	pos = (separation-plate_thickness)/2-horn_thickness;

	difference(){
		hull(){
			translate([-30, -pos]) circle(d = 24);
			translate([-30, pos]) circle(d = 24);
			translate([15,-wheel_pos]) circle(d = 12);
			translate([15,wheel_pos]) circle(d = 12);
		}

		//Wheel screw holes
		translate([0,wheel_pos]) circle(d = screw_size);
		translate([15,-wheel_pos]) circle(d = screw_size);
		translate([-15,-wheel_pos]) circle(d = screw_size);

		//Mounting holes
		translate([-30,0]) mounting_holes(); 
		mirror([0,1,0]) translate([-30,0]) mounting_holes(); 
		
		translate([-30,0]) square([pls, separation-2*(plate_thickness+horn_thickness)-10], center = true);
	}
}

module arm_holder(){
	difference(){
		union(){
			translate([-plate_thickness/2,5]) square([plate_thickness, 4], center = true);
			translate([-plate_thickness/2,-5]) square([plate_thickness, 4], center = true);
			hull(){
				translate([arm_pos,0]) circle(d = 8);
				translate([0,-7]) square([2,14]);
			}
		}
		translate([0,-1.5]) square([1+screw_length-plate_thickness,3]);
		translate([2.1,-5.45/2]) square([0.8*3,5.45]);
		translate([9.5,-pls/2]) square([4-kerf,pls]);
		translate([arm_pos, 0]) circle(d = 3);
	}
}

module belt(t){
	union(){
		for(i = [0:t-1]){
			translate([2*i,0]){
				square([2,1.38-0.6]);
				translate([1,1.38-0.555]) circle(r = 0.555);
			}
		}
	}
}

module belt_connector(){
	difference(){
		union(){
			hull(){
				translate([0,3]) circle(d = 8);
				translate([0,12]) circle(d = 8);
				translate([15,7.5]) circle(d = 10);
				translate([-15,7.5]) circle(d = 10);
			}
		}
		translate([4,10.5]) rotate(-15) mirror([0,1,0]) belt(9);
		translate([-21,6]) rotate(15) mirror([0,1,0])belt(9);
		translate([-(plate_thickness-kerf)/2,2]) square([plate_thickness-kerf, 4-kerf]);
		translate([0,10.5]) circle(d = 3);
	}
}

module spacer(){
	w = separation-2*(plate_thickness+horn_thickness);
	difference(){
		union(){
			translate([0,-w/2]) square([9.5, w]);
			translate([-plate_thickness/2,0]) square([plate_thickness,w-10], center = true);
			translate([9.5,-plate_thickness-w/2]) square([4+kerf, w+plate_thickness*2]);
			hull(){
				translate([9.5,0]) square([belt_height-9.5,15]);
				translate([belt_height-2,0]) circle(r = 2);
				translate([belt_height-2,15]) circle(r = 2);
				translate([13.5-2,-w/2]) circle(r = 2);
				translate([13.5-2,w/2]) circle(r = 2);
			}
			translate([0,2]) square([belt_height+2*plate_thickness,4+kerf]);
		}
		
		translate([2.1,w/2-1.4]) square([2.4, 1.4]);
		translate([2.1,-w/2]) square([2.4, 1.4]);
		translate([(belt_height+2*plate_thickness)-21,9]) square([20, 3]);
		translate([(belt_height+2*plate_thickness)-19.5,9-(5.45-3)/2]) square([0.8*3,5.45]);
	}
}

module plate_3x(){
	for(i = [0:2]){
		translate([-(i%2)*21,(separation+2)*i]) rotate((i%2)*180) carriage_base();
		translate([30.5,(separation+2)*i-14]) rotate(100) arm_holder();
		translate([39,(separation+2)*i+8]) rotate(-80) arm_holder();
		translate([-46,(separation+2)*i]) rotate(180) spacer();
	}

	translate([34,21]) rotate(-40) belt_connector();
	translate([34,21+(separation+2)]) rotate(-40) belt_connector();
	translate([20,21+2*(separation+2)]) rotate(-40) belt_connector();
	translate([-14,34+2*(separation+2)]) rotate(-35) belt_connector();
	translate([-62,separation/2-3]) rotate(90) belt_connector();
	translate([-62,separation*1.5]) rotate(90) belt_connector();
}

module plate_1x(){
	carriage_base();
	translate([15,30]) rotate(172) arm_holder();
	translate([15,-30]) rotate(190) arm_holder();
	translate([38,0]) rotate(90) belt_connector();
	translate([56,0]) rotate(90) belt_connector();
	translate([-46,0]) rotate(180) spacer();
}

module pressure_test(){
	difference(){
		square([70, 60], center = true);
		for(i = [0:8]){
			assign(pos = (major_dia+extrusion)/2-(0.4+i*0.2)){
				echo(0.4+i*0.2);
				translate([-16+i*4,-6+i*2+pos]) circle(d = screw_size);
				translate([-1+i*4,-6+i*2-pos]) circle(d = screw_size);
				translate([-31+i*4,-6+i*2-pos]) circle(d = screw_size);
			}
		}
		translate([-6,4]) square([0.8*3,5.45], center = true);
	}
}

module carriage_complete(){

	//Screws
	translate([10.5+belt_height+plate_thickness*2,10.5,50]) rotate([0,-90,0]) screw(20);
	translate([7.5,(separation-horn_thickness-2.5*plate_thickness)/2,50]) rotate([0,90,0]) screw(8);
	translate([7.5,-(separation-horn_thickness-2.5*plate_thickness)/2,50]) rotate([0,90,0]) screw(8);

	translate([10.5,(extrusion+15.5)/2-wheel_pressure,20]) rotate([0,-90,0]) screw(20);
	translate([10.5,-(extrusion+15.5)/2+wheel_pressure,35]) rotate([0,-90,0]) screw(20);
	translate([10.5,-(extrusion+15.5)/2+wheel_pressure,5]) rotate([0,-90,0]) screw(20);

	//Nuts
	translate([10.5+5.5,10.5,50]) rotate([0,-90,0]) nut(3);
	translate([13.75,(separation-horn_thickness-2.5*plate_thickness)/2,50]) rotate([0,90,0]) rotate([0,0,30]) nut(3);
	translate([13.75,-(separation-horn_thickness-2.5*plate_thickness)/2,50]) rotate([0,90,0]) rotate([0,0,30]) nut(3);

	translate([-7,-(extrusion+15.5)/2+wheel_pressure,5]) rotate([0,-90,0]) nut(3);

	translate([-7,-(extrusion+15.5)/2+wheel_pressure,35]) rotate([0,-90,0]) nut(3);

	translate([-7,(extrusion+15.5)/2-wheel_pressure,20]) rotate([0,-90,0]) nut(3);

	//Parts
	translate([10.5+belt_height,0,50]) rotate([90,90,90]) 
		linear_extrude(height = 2*plate_thickness) belt_connector();

	translate([10.5,0,50]) linear_extrude(height = plate_thickness, center = true) spacer();

	translate([ 10.5, (separation-plate_thickness)/2-horn_thickness, 50]) 
		rotate([90,0,0]) linear_extrude(height = plate_thickness, center = true) arm_holder();
	translate([ 10.5, -(separation-plate_thickness)/2+horn_thickness, 50]) 
		rotate([90,0,0]) linear_extrude(height = plate_thickness, center = true) arm_holder();

	translate([9,0,20]) rotate([0,90,0]) linear_extrude(height = plate_thickness, center = true) carriage_base();

	//Extrusion
	//color("Gray") translate([0,0,-300]) extrusion(600);

	//Wheels
	color("DimGray"){
		translate([0,(extrusion+15.5)/2-wheel_pressure,20]) rotate([0,90,0]) wheel();
		translate([0,-(extrusion+15.5)/2+wheel_pressure,35]) rotate([0,90,0]) wheel();
		translate([0,-(extrusion+15.5)/2+wheel_pressure,5]) rotate([0,90,0]) wheel();
	}
}

//pressure_test();

//carriage_complete();

plate_3x();

//belt(10);

//belt_connector();

//spacer();

//arm_holder();

//carriage_base();
