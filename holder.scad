lighter = [23.8, 10.3, 80];
tank_h = 65;
button_l = 11;

module frame() {
    difference() {
        translate([-30, -lighter.y / 2 - 2, -(lighter.x - 5)/2 +3.5])
        cube([
            tank_h + 30,
            lighter.y + 4,
            lighter.x - 5
        ]);
        
        rotate([0, 90, 0]) lighter_module();
    }
    
    translate([0, (lighter.y + 4) / 2, 0])
    rotate([-90, 0, 180])
        linear_extrude(lighter.y + 4)
        polygon([
            [0, 0], [30, 0], [50, 40], [20, 40]
        ]);
}

module lighter_module() {   
    metal = [lighter.x + 2, lighter.y, lighter.z - tank_h];
    
    translate([0, 0, (lighter.z - metal.z) / 2]) 
    cube([lighter.x, lighter.y, lighter.z - metal.z], true);
    
    translate([1, 0, tank_h + metal.z / 2]) 
        cube(metal, true);
}

module slide() {
    translate([0, -(lighter.y + 8) / 2, -15]) 
    cube([lighter.z + 2 + 0, lighter.y + 8, 15]);
    
    translate([15, 2.5, -20])
    rotate([90, 0, 0])
    linear_extrude(5)
    difference() {
        circle(15);
        translate([7, -7, 0]) circle(15);
    }
}

%rotate([0, 90, 0]) lighter_module();
frame();
slide();