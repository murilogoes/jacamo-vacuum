// Agent sample_agent in project aulaUnesp_ex2

/* Initial beliefs and rules */
direcao(left).


/* Initial goals */

!start.

/* Plans */

/*
+!start : true <- makeArtifact("rooms", "aulaUnesp_ex2.Rooms", [4], ID);
                  focus(ID);
                  !searchTrash.
*/

+!start : true <- !searchArtifact.

+!searchArtifact <- lookupArtifact("rooms", Id);
                    focus(Id);
                    !searchTrash.

+!searchTrash <- .drop_all_intentions;
                 !move;
                 .wait(1000);
                 !searchTrash.

-!searchArtifact <- !searchArtifact.   

+!move : at1(X) & direcao(left) <- .println("Moving to room ", X );
                                    goLeft(1).


+!move : at1(X) & direcao(right) <- .println("Moving to room ", X + 1);
                                    goRight(1).

+border : direcao(left) <- .println("Left Border Reached");
    		     			 -+direcao(right).
							 
+border : direcao(right) <- .println("Right Border Reached");
		   									-+direcao(left).


+dirty : at1(X) <- .println("Cleaning room ", X);
                            clean(1).

/*
+!move : at(X) & X == 0 <- .println("Moving to room ", X + 1);
                            goRight.

+!move : at(X) & X == 1 <- .println("Moving to room ", X - 1 );
                            goLeft.



+dirty : at(X) <- .println("Cleaning room ", X);
                            clean.

                            */


/*
+!start : true <- !searchArtifact.

+!searchArtifact <- lookupArtifact("rooms", Id);
                    focus(Id).

-!searchArtifact <- !searchArtifact.    
*/


{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moise/asl/org-obedient.asl") }
