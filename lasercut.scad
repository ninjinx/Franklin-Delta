include <configuration.scad>;
use <glass_tab.scad>;

s1 = 240;
s2 = 52;
angle = 60;
height1 = (s1+2*s2)*sqrt(3)/2; //Height of major triangle
height2 = s2*sqrt(3)/2; //Height of minor triangle
inscribed_r = height1/3;

cutout_width = 18;
cutout_length = 43;

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

module top_plate(){
	difference(){
		plate_base();
		for(i = [0:2]){
			rotate([0, 0, 2*i*angle]) translate([0,height1*(2/3)-height2])
				square([cutout_width, cutout_length*2], center=true);
projection() glass_tab();
		}
	}
}

top_plate();