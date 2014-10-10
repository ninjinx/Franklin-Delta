button_dia = 15.9;
power_dia = 12.4;
usb_screw_dia = 3;
usb_screw_dist = 30;
usb_height = 14.2;
usb_width = 18.4;

spacing = 10;
width = spacing*4+usb_screw_dist+usb_screw_dia+power_dia+button_dia;
height = 25;
thickness = 3.5;

module panel(){
	difference(){
		cube([width, height, thickness]);
		translate([spacing, height/2, 0]){
			//USB
			cylinder(r=usb_screw_dia/2, h=thickness*3, center=true, $fn=12);
			translate([usb_screw_dist, 0, 0])
				cylinder(r=usb_screw_dia/2, h=thickness*3, center=true, $fn=12);
			translate([usb_screw_dist/2, 0, 0])
				cube(size=[usb_width, usb_height, thickness*3], center=true);
			
			//barrel jack
			translate([usb_screw_dist+spacing+(power_dia/2), 0, 0])
				cylinder(r = power_dia/2, h=thickness*3, $fn=32, center=true);

			//power button
			translate([usb_screw_dist+spacing*2+(power_dia)+(button_dia/2), 0, 0])
				cylinder(r = button_dia/2, h=thickness*3, $fn=32, center=true);
		}
	}
}

panel();