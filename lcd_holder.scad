include <configuration.scad>;

psu_l = 122;
psu_w = 56;
psu_h = 31;

panel_height = 73;
printer_height = 45;
screw_separation = (49+56)/2; //center to center distance between mounting screws

angle = asin(printer_height/panel_height);

side = 1;

width = 9;

button_r = 8;

module lcd_holder(extra_width, button){
	rotate([0,-90,0]){
		union(){
			difference(){
				cube([width+extra_width,extrusion,thickness]);
				translate([width/2,extrusion/2,thickness/2])
					cylinder(r=m3_wide_radius, h=2*thickness, center=true, $fn=16);
			}
			rotate([angle, 0, 0]) translate([0,-panel_height,0])
				difference(){
					cube([width+extra_width, panel_height, thickness]);
					translate([width/2,(panel_height-screw_separation)/2,thickness/2])
						cylinder(r=m3_wide_radius, h=2*thickness, center=true, $fn=16);
					translate([width/2,panel_height-(panel_height-screw_separation)/2,thickness/2])
						cylinder(r=m3_wide_radius, h=2*thickness, center=true, $fn=16);
					rotate([0, 0, 45]) translate([0,-(width+extra_width),-thickness/2])
						cube([(width+extra_width)*2,width+extra_width,thickness*2]);
					if(button == true){
						translate([width+(extra_width/2)-2,panel_height*2/3,thickness/2]) cylinder(r = 8, h = thickness*2, center=true);
					}
				}
			difference(){
				rotate([0,90,0])
					cylinder(r=thickness, h=width+extra_width, $fn=48);
				translate([(width+extra_width)/2,0,-thickness])
					cube([width+extra_width+2, thickness*2, thickness*2], center=true);
			}
		}
	}
}

module lcd_holders(num){
	for(i = [0 : num-1]){
		if(i % 2 == 0){
			translate([i*thickness*2, panel_height, 0]) rotate([0, 0, -angle])
				lcd_holder(0,false);
		} else {
			mirror([0, 1, 0]) translate([i*thickness*2, 0, 0])  rotate([0, 0, -angle])
				lcd_holder(20, true);
		}
	}
}

lcd_holders(2);