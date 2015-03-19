include <configuration.scad>;
use <logotype.scad>;
ramps_screw_dist_y = 88.8;
ramps_screw_dist_x = 55.3;

s1 = 240;
s2 = 52;
angle = 60;
height1 = (s1+2*s2)*sqrt(3)/2; //Height of major triangle
height2 = s2*sqrt(3)/2; //Height of minor triangle
inscribed_r = height1/3;

belt_cutout_width = 28;
belt_cutout_length = 43;

tab_cutout_width = 28;
tab_cutout_depth = 45;

screw_cutout_depth = 12;

logo = false;
lcd_bracket = true;
lcd_bracket_separation = 146; //center to center distance between mounting screws
lcd_bracket_width = 10;
print_serial = true;
serial_number = "#0001";

p1 = [0,0];
p2 = [s1,0]+p1;
p3 = [cos(angle)*s2, sin(angle)*s2]+p2;
p4 = [cos(angle*2)*s1, sin(angle*2)*s1]+p3;
p5 = [cos(angle*3)*s2, sin(angle*3)*s2]+p4;
p6 = [cos(angle*4)*s1, sin(angle*4)*s1]+p5;

side_length = 240;
side_height = extrusion * 3;
side_cutout_depth = 6;

power_dia = 12.4;
usb_screw_dia = 3;
usb_screw_dist = 30;
usb_height = 12.0;
usb_width = 13.0;
button_screw_dia = 2.5;
button_screw_dist = 24;
button_width = 20;
button_height = 13;
cable_dia = 15;

mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 6.0;  // Hole for the hotend (J-Head diameter is 16mm).

module plate_base(){
	translate([-s1/2,-height1/3])
			polygon([p1, p2, p3, p4, p5, p6]);
}

module plate_middle(){
	difference(){
		plate_base();
		for(i = [0:2]){
			rotate(2*i*angle)
				polygon([
					[-s2/2, 2+height1*2/3-height2],
					[s2/2, 2+height1*2/3-height2],
					[belt_cutout_width/2, height1*2/3-height2-belt_cutout_length],
					[-belt_cutout_width/2, height1*2/3-height2-belt_cutout_length]
				]);

			rotate(angle+2*angle*i)
			translate([-tab_cutout_width/2, inscribed_r-tab_cutout_depth])
				square([tab_cutout_width, tab_cutout_depth*1.2]);
			
			rotate(2*i*angle){
				mirror([1,0,0]){
				translate([s1/2-13, -inscribed_r-1])
					square([25,15]);
				translate([s1/2-screw_cutout_depth-12, -inscribed_r+7.5-(3.5/2)])
					square([screw_cutout_depth+1, 3.5]);
				}
				translate([s1/2-13, -inscribed_r-1])
					square([25,15]);
				translate([s1/2-screw_cutout_depth-12, -inscribed_r+7.5-(3.5/2)])
					square([screw_cutout_depth+1, 3.5]);
			}
		}

		/*if(lcd_bracket){
			translate([lcd_bracket_separation/2 - lcd_bracket_width/2, -inscribed_r-1])
				square([lcd_bracket_width, 16]);
			translate([-(lcd_bracket_separation/2 + lcd_bracket_width/2), -inscribed_r-1])
				square([lcd_bracket_width, 16]);
		}*/

		if(logo){
			projection() scale(1/5) translate([0, -23]) logotype();
		}
	}
}

module plate_bottom(){
	difference(){
		plate_base();
		for(i = [0:2]){
			rotate(2*i*angle)
				polygon([
					[-s2/2, 2+height1*2/3-height2],
					[s2/2, 2+height1*2/3-height2],
					[s2/2+15, height1*2/3-height2-18],
					[-s2/2-15, height1*2/3-height2-18]
				]);
			
			rotate(2*i*angle){
				mirror([1,0,0]){
				translate([s1/2-screw_cutout_depth-12, -inscribed_r+7.5-(3.5/2)])
					square([screw_cutout_depth+1, 3.5]);
				}
				translate([s1/2-screw_cutout_depth-12, -inscribed_r+7.5-(3.5/2)])
					square([screw_cutout_depth+1, 3.5]);
			}
		}

		//Mounting screws for RAMPS
		translate([ramps_screw_dist_x/2, ramps_screw_dist_y/2-8])
			square([3.4, 60], center=true);
		translate([-ramps_screw_dist_x/2, -ramps_screw_dist_y/2-8])
			square([60, 3.4], center=true);
	}
}

module plate_top(){
	difference(){
		plate_base();
		for(i = [0:2]){
			rotate(2*i*angle)
				polygon([
					[-s2/2, 2+height1*2/3-height2],
					[s2/2, 2+height1*2/3-height2],
					[s2/2+15, height1*2/3-height2-18],
					[-s2/2-15, height1*2/3-height2-18]
				]);
			
			rotate(2*i*angle){
				mirror([1,0,0]){
				translate([s1/2-screw_cutout_depth-12, -inscribed_r+7.5-(3.5/2)])
					square([screw_cutout_depth+1, 3.5]);
				}
				translate([s1/2-screw_cutout_depth-12, -inscribed_r+7.5-(3.5/2)])
					square([screw_cutout_depth+1, 3.5]);
			}
		}
	}
}

module side_base(){
	difference(){
		square([side_length, side_height]);
		translate([-1, (extrusion/2)-(3.5/2)]) square([side_cutout_depth+1, 3.5]);
		translate([-1, side_height-((extrusion/2)-(3.5/2)+3.5)]) square([side_cutout_depth+1, 3.5]);
		translate([side_length-side_cutout_depth, side_height-((extrusion/2)-(3.5/2)+3.5)]) square([side_cutout_depth+1, 3.5]);				translate([side_length-side_cutout_depth,  (extrusion/2)-(3.5/2)]) square([side_cutout_depth+1, 3.5]);
	}
}

module side_left(){
	translate([-side_length/2, -side_height/2])
		difference(){
			side_base();
			/*#square([60,side_height]);
			#translate([side_length-60, 0]) square([60,side_height]);
			#square([side_length, extrusion]);
			#translate([0,extrusion*2]) square([side_length, extrusion]);*/

			//USB
			translate([30,0]){
				translate([(side_length/2) + (usb_screw_dist/2),side_height/2]) 
					circle(d=usb_screw_dia, $fn=64);
				translate([(side_length/2) - (usb_screw_dist/2),side_height/2]) 
					circle(d=usb_screw_dia, $fn=64);
				translate([side_length/2,side_height/2]) square([usb_width, usb_height],center = true);
			}

			//Power connector
			translate([side_length/2, side_height/2]) circle(d=power_dia, $fn=64);
	
			//Power button
			translate([-30,0]) {
				/*translate([(side_length/2) + (button_screw_dist/2),side_height/2]) 
					circle(d=button_screw_dia, $fn=32);
				translate([(side_length/2) - (button_screw_dist/2),side_height/2]) 
					circle(d=button_screw_dia, $fn=32);*/
				translate([side_length/2,side_height/2]) square([button_width, button_height],center = true);
			}
		}
}

module side_right(){
	translate([-side_length/2, -side_height/2])
		difference(){
			side_base();
			/*#square([60,side_height]);
			#translate([side_length-60, 0]) square([60,side_height]);
			#square([side_length, extrusion]);
			#translate([0,extrusion*2]) square([side_length, extrusion]);*/
			translate([side_length/2, side_height/2]) circle(d=cable_dia);
		}
}

module side_front(){
	translate([-side_length/2, -side_height/2])
			difference(){
			side_base();
			translate([60, side_height/3]) square([side_length-120,side_height/3]);
			/*#square([60,side_height]);
			#translate([side_length-60, 0]) square([60,side_height]);
			#square([side_length, extrusion]);
			#translate([0,extrusion*2]) square([side_length, extrusion]);*/
		}
}

module e3d_holder(){
	difference(){
		circle(r=20, $fn=64);
		circle(r=hotend_radius, $fn=64);
		#translate([0,15]) square([2*hotend_radius, 30], center=true);
		for (a = [0:120:359]) rotate([0, 0, a]) {
			rotate([0, 0, 60]) translate([0, mount_radius, 0])
				circle(r=m3_wide_radius, center=true, $fn=48);
		}
	}
}

plate_middle();
//e3d_holder();
//plate_top();
//plate_bottom();
//%plate_base();
//side_left();
//side_right();
//side_front();