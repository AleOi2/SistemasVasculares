// The following command defines a new variable `lc' characteristic length:

lc = 0.05;

// This variable can then be used in the definition of Gmsh's simplest
// `elementary entity', a `Point'. A Point is defined by a list of
// four numbers: three coordinates (X, Y and Z), and a characteristic
// length (lc) that sets the target element size at the point:

Point(1) = {0, 0, 0, lc};
Point(2) = {1, 0, 0, lc} ;
Point(3) = {0, 1, 0, lc} ;
Point(4) = {0, 0, 1, lc} ;
Point(5) = {0, 0,-1, lc} ;

Line(1) = {1,2} ;
Line(2) = {2,3} ;
Line(3) = {1,3} ;
Line(4) = {1,4} ;
Line(5) = {2,4} ;
Line(6) = {3,4} ;
Line(7) = {1,5} ;
Line(8) = {2,5} ;
Line(9) = {3,5} ;

// The third elementary entity is the surface. In order to define a
// simple rectangular surface from the four lines defined above, a
// line loop has first to be defined. A line loop is a list of
// connected lines, a sign being associated with each line (depending
// on the orientation of the line):

Line Loop(1) = {-5,8,-7,4};
Line Loop(2) = {-4,7,-9,6};
Line Loop(3) = {-5,2,6};
Line Loop(4) = {8,-9,-2};

// We can then define the surface as a list of line loops (only one
// here, since there are no holes--see `t4.geo'):

Plane Surface(1) = {1} ;
Plane Surface(2) = {2} ;
Plane Surface(3) = {3} ;
Plane Surface(4) = {4} ;

// Volumes are the fourth type of elementary entities in Gmsh. In the
// same way one defines line loops to build surfaces, one has to
// define surface loops (i.e. `shells') to build volumes. The
// following volume does not have holes and thus consists of a single
// surface loop:

Surface Loop(1) = {1,2,-3,-4};
Volume(1) = {1};


Physical Volume("dois_tetraedros") = {1} ;

