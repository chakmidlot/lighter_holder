lighter = [23.8, 10.3, 80];
tank_h = 65;
button_l = 11;

module frame() {
    difference() {
        union() {
            difference() {
                translate([-75, -lighter.y / 2 - 2, -(lighter.x - 5) + 5 ])
                cube([
                    tank_h + 75, 
                    lighter.y + 4,
                    lighter.x - 5
                ]);
                
                translate([0, -(lighter.y/2) -0.5, lighter.x/2 + 0.5])
                rotate([0, 90, 0]) cube([lighter.x+1, lighter.y+1, lighter.z+1]);
            }
            
            // handle
            translate([-45, (lighter.y - 2) / 2, 3])
            minkowski () {
                difference() {
                    rotate([-90, 0, 180])
                        linear_extrude(lighter.y -2)
                        polygon([
                            [0, 0], [46, 0], [46, 20], [70, 90], [40, 90]
                        ]);
                    
                    hull() {
                        translate([-60, 20, -35]) 
                            rotate([90, -60, 0]) 
                            scale([1, 0.5, 1])
                            cylinder(50, 30, 30, $fn=40);
                        
                        translate([-122, -20, -90]) 
                            cube([50, 50, 50]);
                    }
                }
                
                cylinder(2, 3, 3, $fn=40);
            }
        }
    
        // trigger hole
        translate([-70, -3, -40]) cube([50, 6, 60]);
        
        // lock hole
        translate([-18, 1, -10]) cube([16, 20, 20]);
    }
    
    //rails
    translate([tank_h-37, lighter.y/2 + 2, 5]) rail();
    translate([tank_h-37, -lighter.y/2 - 2, 5]) mirror([0, 1, 0]) rail();
    translate([-47, lighter.y/2 + 2, 5]) rail();
    translate([-47, -lighter.y/2 - 2, 5]) mirror([0, 1, 0]) rail();
    
    // lock
    
    translate([-17, lighter.y / 2 + 1, -4])
        difference() {
            linear_extrude(9)
            polygon([
                [0, 0], [0, 4.5], [4, 4.5], [8, 1], [16, 1], [16, 0]
            ]);
        
        translate([-1, 1, 9]) rotate([-50, 0, 0]) cube([16, 10, 10]);
        
    }
    translate([-17, lighter.y / 2 + 1, -8])
       linear_extrude(4)
       polygon([
           [0, 0], [0, 4.5], [4, 4.5], [4, 1], [14, 1], [14, 0]
       ]);
    
    // guard
    translate([-70, -2.5, -45]) cube([48, 5, 3]);

    intersection() {    
        translate([-48, -2.5, -15])
        rotate([-90, 0, 0])
            difference() {
                translate([2, -2, 0]) cylinder(5, 40, 40, $fn=100);
                translate([0, 0, -1]) cylinder(7, 37, 37, $fn=100);
            }

        translate([-20, 0, -29]) cube([50, 50, 32], true);
    }
}

module rail() {
    rotate([0, 90, 0])
        linear_extrude(27)
        polygon([
            [0, 0], [0, 2], [2, 2], [4, 0]
        ]);
}

module lighter_module() {   
    metal = [lighter.x + 2, lighter.y, lighter.z - tank_h];
    
    translate([0, 0, (lighter.z - metal.z) / 2]) 
    cube([lighter.x, lighter.y, lighter.z - metal.z], true);
    
    translate([-1, 0, tank_h + metal.z / 2]) 
        cube(metal, true);
}

module slide() {
    difference() {
        union() {
            translate([lighter.z-28 , -(lighter.y + 8) / 2, -17]) 
                cube([30, lighter.y + 8, 15]);
            
            hull() {
                translate([-65, -(lighter.y + 8) / 2, -(lighter.x - 6) / 2 + 5]) 
                    cube([tank_h + 65, lighter.y + 8, lighter.x-6]);
                
                translate([-65, -(lighter.y + 14) / 2, -(lighter.x - 6) / 2 + 5]) 
                    cube([tank_h + 65, lighter.y + 14, 10]);
            }
        }
        
        // barrel
        translate([-40, 0, -lighter.x /2 + lighter.y / 2  - 2.5])
            rotate([0, 90, 0])
            linear_extrude(lighter.z + 40)
            union() {
                 hull() {
                    translate([-lighter.x + lighter.y - 2, 0, 0]) circle(lighter.y/2 + 0.5, $fn=50);
                 }
            }
        
        // frame cut
        translate([(lighter.z + 20) / 2 - 50, 0, -(lighter.x / 2 + 5)/2 + 3.45])
            cube([lighter.z + 80, lighter.y+5, 20.5], true);
        
            
        // rails cut
        mirror([0, -1, 0])
        translate([-56, lighter.y/2 + 2, 5.25])
            rotate([0, 90, 0])
            linear_extrude(tank_h + 57)
            polygon([
                [0, 0], [0, 2.5], [2.5, 2.5], [5, 0]
            ]);
        
        translate([-56, lighter.y/2 + 2, 5.25])
            rotate([0, 90, 0])
            linear_extrude(tank_h + 57)
            polygon([
                [0, 0], [0, 2.5], [2.5, 2.5], [5, 0]
            ]);
            
        translate([-68, lighter.y/2 + 1.5, -5])
            cube([30, 3, 10]);
        translate([-68, -lighter.y/2 - 4.5, -5])
            cube([30, 3, 10]);
            
        translate([tank_h-82.5, lighter.y/2 + 1.5, -5]) cube([54, 3, 10]);
        translate([tank_h-82.5, -lighter.y/2 - 4.5, -5]) cube([54, 3, 10]);
        
        // lock cut
        translate([-17.5, 6, -10]) cube([17, 5, 15.25]);
    }
    
    translate([-55, -2.5, -lighter.x / 2 - 5]) 
        cube([15, 5, lighter.x]);
    translate([-55, 0, -lighter.x / 2 - 5]) trigger();
    
   
}

module trigger() {
    $fn = 30;
    
    translate([0, -1, 0])
    intersection() {
        union () {
            minkowski() {
            translate([16.5, 2, -7])
                rotate([90, 0, 0])
                linear_extrude(2)
                difference() {
                    circle(15);
                    translate([7, -4, 0]) circle(15);
                }
                
                sphere(1.5, $fn=10);
            }
            
            translate([0, -1.5, -7])
            cube([5, 5, 7]);
        }
        
        translate([-35, 0, -50]) cube([100, 100, 100], true);
    }
}

module assembled() {
    intersection() {
        // #translate([0, -90, -96]) cube([400, 200, 200], true);
        // translate([-50, 0, 10]) cube([50, 50, 50], true);
        // translate([-50, 0, 10]) cube([80, 50, 50], true);
        union() {
            %rotate([0, 90, 0]) lighter_module();
            frame();
            slide();
        }
    }
}

module pulled() {
    union() {
    // intersection() {
        frame();
        translate([-10, 0, 0]) slide();
    }
}

module disassemble () {
    union() {
    // intersection() {
        frame();
        translate([20, 0, 0]) slide();
    }
}

// assembled();
disassemble();
// pulled();
//!intersection() {translate([-100, -20, -30]) cube([200, 40, 40]); frame();}
// trigger();