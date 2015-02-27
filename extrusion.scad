include <configuration.scad>;

module extrusion_cutsection(){
	import("openbeam.dxf", convexity = 8);
}


module extrusion(h){
	linear_extrude(height = h){
		extrusion_cutsection();
	}
}

extrusion(300);