include <configuration.scad>;

s1 = 240;
s2 = 52;
angle = 60;
height1 = (s1+2*s2)*sqrt(3)/2; //Height of major triangle
height2 = s2*sqrt(3)/2; //Height of minor triangle
inscribed_r = height1/3;

belt_cutout_width = 18;
belt_cutout_length = 43;

tab_cutout_width = 28;
tab_cutout_depth = 45;

screw_cutout_depth = 12;

lcd_bracket = true;
lcd_bracket_separation = 146;

p1 = [0,0];
p2 = [s1,0]+p1;
p3 = [cos(angle)*s2, sin(angle)*s2]+p2;
p4 = [cos(angle*2)*s1, sin(angle*2)*s1]+p3;
p5 = [cos(angle*3)*s2, sin(angle*3)*s2]+p4;
p6 = [cos(angle*4)*s1, sin(angle*4)*s1]+p5;

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
					[tab_cutout_width/2, height1*2/3-height2-tab_cutout_depth],
					[-tab_cutout_width/2, height1*2/3-height2-tab_cutout_depth]
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
		
	}
}

plate_middle();