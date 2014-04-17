include <configuration.scad>;

tab_length = 45;
tab_width = 25;
tab_thickness = 3.6;
glass_thickness = 3.0; 
glass_radius = 85.0;
guard_thickness = 18;

fsr_radius = 6.5;
fsr_recess = 1.0;
fsr_connector_width = 8.0;

m3_head_radius = 3.0;
ridge_length = 12;


//The basic glass tab
module glass_tab_base(){
	intersection(){
		difference(){
			cylinder(r=glass_radius+guard_thickness, h=glass_thickness+tab_thickness, $fn=256);
			translate([0, 0, tab_thickness])
				cylinder(r=glass_radius, h=10, center=false, $fn=256);
		}
		translate([-tab_width/2,(glass_radius+guard_thickness)-tab_length,0])
			cube([tab_width, (glass_radius+guard_thickness), glass_thickness+tab_thickness]);
	}
}


//..with added FSR recess
module glass_tab_recess(){
	difference(){
		glass_tab_base();
		translate([0,(glass_radius+guard_thickness)-((tab_length+guard_thickness)/2),tab_thickness-fsr_recess])
			cylinder(r=fsr_radius, h=10);
		translate([-fsr_connector_width/2,0,tab_thickness-fsr_recess])
			cube([fsr_connector_width,(glass_radius+guard_thickness)-((tab_length+guard_thickness)/2),10]);
	}
}


//..and mounting hole
module glass_tab(){
	translate([0,-(glass_radius+guard_thickness)+(tab_length/2),0]){
		difference(){
			glass_tab_recess();
			hull(){
				translate([0,glass_radius+(guard_thickness/2)-(ridge_length/2)+m3_wide_radius,-1])
					cylinder(r=m3_wide_radius, h = 20, $fn=16);
				translate([0,glass_radius+(guard_thickness/2)+(ridge_length/2)-m3_wide_radius,-1])
					cylinder(r=m3_wide_radius, h = 20, $fn=16);
			}
			hull(){
				translate([0,glass_radius+(guard_thickness/2)-(ridge_length/2)+m3_wide_radius,tab_thickness])
					cylinder(r=m3_head_radius, h = 20, $fn=16);
				translate([0,glass_radius+(guard_thickness/2)+(ridge_length/2)-m3_wide_radius,tab_thickness])
					cylinder(r=m3_head_radius, h = 20, $fn=16);
			}
		}
	}
}

glass_tab();