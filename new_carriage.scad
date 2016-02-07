//FOR NEXT VERSION

use <extrusion.scad>;

$fn = 32;

thickness = 6.6;

magnet_h = 2.7;
magnet_dia = 10;

angle = 15;

arm_separation = 60;
spring_length = 13.2;
spring_angle = 55;
spring_dia = 3.7;

belt_distance = 12.5;

//Wheel dimensions
minor_dia = 12;
major_dia = 15.5;

separation = 46;

wheel_pressure = 0.83;
wheel_pos = (major_dia+15)/2-wheel_pressure;
arm_pos = 18.3;

hole_size = 1.65;

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

module spring(){
	union(){
		cylinder(d = spring_dia, h = thickness);
		translate([0.4-spring_dia/2, 0, 0]) rotate([90,0,0]) 
			cylinder(d = 0.8, h = spring_length);
		rotate([0,0,-spring_angle])
			translate([spring_dia/2-0.4, 0, thickness]) rotate([90,0,0]) 
				cylinder(d = 0.8, h = spring_length);
		translate([0.4-spring_dia/2, -spring_length, 0]) cylinder(d = 0.8, h = 5);
		rotate([0,0,-spring_angle]) 
			translate([spring_dia/2-0.4, -spring_length, thickness-5]) 
				cylinder(d = 0.8, h = 5);
	}
}

module carriage(){
	difference(){
		union(){
			hull(){
				translate([-wheel_pos,20,0]) cylinder(d = 14, h = thickness);
				translate([-wheel_pos,-20,0]) cylinder(d = 14, h = thickness);
				translate([wheel_pos,0,0]) cylinder(d = 14, h = thickness);
				translate([wheel_pos,0,0]) cylinder(d = 14, h = thickness);
				//translate([-separation/2, 35, 0]) cylinder(d = 20, h = thickness);
				//translate([separation/2, 35, 0]) cylinder(d = 20, h = thickness);
				translate([separation/2, 35, 0]) 
					rotate([0,0,-30]) magnet_holder(thickness, 8);
				translate([-separation/2, 35, 0]) 
					rotate([0,0,30]) magnet_holder(thickness, 8);
			}

			//Magnet holders
			hull(){
				translate([-separation/2, 35, thickness]) 
					rotate([0,0,30]) magnet_holder(1, 8);
				translate([-separation/2, 35, 12]) rotate([30,0,0])
					rotate([0,0,30]) magnet_holder(8, 8);
			}
			hull(){
				translate([separation/2, 35, thickness]) 
					rotate([0,0,-30]) magnet_holder(1, 8);
				translate([separation/2, 35, 12]) rotate([30,0,0])
					rotate([0,0,-30]) magnet_holder(8, 8);
			}

			//Belt holder
			hull(){
				translate([3.5,-7,belt_distance-8]) cylinder(d = 14, h = 8);
				translate([3.5,30,belt_distance-8]) cylinder(d = 14, h = 8);
			}
		}

		//Magnet holes
		translate([separation/2, 35, 12]) rotate([30,0,0]) 
			translate([0,0,8]) rotate([0,0,-30]) magnet_holder_holes();
		translate([-separation/2, 35, 12]) rotate([30,0,0]) 
			translate([0,0,8]) rotate([0,0,30]) magnet_holder_holes();

		//Screw holes for wheels
		translate([-wheel_pos,20,0]) screw_hole();
		translate([-wheel_pos,-20,0]) screw_hole();
		translate([wheel_pos,0,0]) screw_hole();

		//Belt holder
		translate([5-1.1,12.5-9-22,belt_distance-6]) cube([2.5, 22, 7]);
		translate([5-1.1,12.5+9,belt_distance-6]) cube([2.5, 22, 7]);
		translate([5,12.5+5,belt_distance-6]) difference(){
			hull(){
				cylinder(d = 9.2, h = 7);
				translate([-1.1,5,0]) cube([2.2, 2, 7]);
			}
			cylinder(d = 6, h = 7);
		}
		translate([5,12.5-5,belt_distance-6]) difference(){
			hull(){
				cylinder(d = 9.2, h = 7);
				translate([-1.1,-7,0]) cube([2.2, 2, 7]);
			}
			cylinder(d = 6, h = 7);
		}

		//Remove unnecessary plastic
		hull(){
			translate([-wheel_pos,-10,-0.1]) cylinder(d = 6, h = thickness+0.2);
			translate([-(wheel_pos+3.5),11,-0.1]) cylinder(d = 6, h = thickness+0.2);
			translate([-7.5,11,-0.1]) cylinder(d = 6, h = thickness+0.2);
			translate([-7.5,-13,-0.1]) cylinder(d = 6, h = thickness+0.2);
		}
		hull(){
			translate([wheel_pos+2.5,9,-0.1]) cylinder(d = 9, h = thickness+0.2);
			translate([wheel_pos+0.5,26,-0.1]) cylinder(d = 6, h = thickness+0.2);
			translate([wheel_pos+6,22.5,-0.1]) cylinder(d = 6, h = thickness+0.2);
		}
		translate([0,83.2,0]) cylinder(d = 90, h = thickness*3, center = true, $fn = 128);
	}
}

module magnet_holder_holes(){
	translate([0,0,-magnet_h+0.7]) cylinder(d1 = magnet_dia, d2 = magnet_dia+0.6, h = magnet_h+.01, $fn=64);
	for(a = [0,120,240]){
		rotate([0,0,a]) translate([0,7.5,0])
			rotate([angle, 0, 0]) translate([0,0,-6.55])
				cylinder(d = 3.95, h = 8.5, $fn = 48);
	}
}

module magnet_holder(height, dia){
	hull(){
		for(a = [0,120,240]){
			rotate([0,0,a]) translate([0,dia,0]) cylinder(d = 8.5, h = height, $fn = 48);
		}
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

module magnet(){
	color("silver") translate() difference(){
		cylinder(d = magnet_dia-0.05, h = magnet_h, $fn=64);
		cylinder(d = 3, h = 7, $fn=24, center = true);
		translate([0,0,magnet_h-1.79]) cylinder(d1 = 3, d2 = 6.55, h = 1.81, $fn=24);
	}
}

module screw(){
	color("DimGray"){
		cylinder(d2 = 5.9, d1=2.8, h = 1.77, $fn = 48);
		translate([0,0,-4]) cylinder(d=2.8, h = 4.0, $fn = 48);
	}
}

module screw_hole(){
	cylinder(d = 3.3, h = thickness*3, center = true); 
	translate([0,0,3.5]) cylinder(d = 6.5, h = thickness, $fn = 6); 
}

carriage();

/*
color("Silver") extrusion(150, true);

rotate([90,0,0]){
	color("Orange") translate([0,0,15/2+2.1]) carriage();
	color("Dimgray") {
		translate([wheel_pos,0,0]) wheel();
		translate([-wheel_pos,20,0]) wheel();
		translate([-wheel_pos,-20,0]) wheel();
	}
}

//Visualization stuff
/*translate([0,0,-magnet_h+0.6]) magnet();

for(a = [0,120,240]){
		rotate([0,0,a]) translate([0,7.5,0]) rotate([angle, 0, 0]) screw();
}*/