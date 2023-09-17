// Agent sample_agent in project aulaUnesp_ex2

/* Initial beliefs and rules */
direcao(right).


/* Initial goals */

!start.

/* Plans */

+!start : true <- makeArtifact("rooms", "aulaUnesp_ex2.Rooms", [10], ID);
                  focus(ID);
                  !searchTrash.

+!searchTrash <- .drop_all_intentions;
                 !move;
                 .wait(1000);
                 !searchTrash.

+!move : at0(X) & direcao(right) <- .println("Moving to room ", X + 1);
                                    goRight(0).
+!move : at0(X) & direcao(left) <- .println("Moving to room ", X );
                                    goLeft(0).

+border : direcao(left) <- .println("Left Border Reached");
    		     			 -+direcao(right).
							 
+border : direcao(right) <- .println("Right Border Reached");
		   									-+direcao(left).


+dirty : at0(X) <- .println("Cleaning room ", X);
                            clean(0).



{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moise/asl/org-obedient.asl") }
