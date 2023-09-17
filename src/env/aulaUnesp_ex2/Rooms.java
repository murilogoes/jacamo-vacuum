package aulaUnesp_ex2;

import java.util.Random;

import cartago.*;

public class Rooms extends Artifact {

    private boolean rooms[] = null;
    // private int robotAt = 0;
    private int robotAt[] = new int[2];
    // private int robot2At = 29;
    private Random rnd = new Random(System.currentTimeMillis());

    void init(int numberOfRooms) {

        robotAt[0] = 0;
        robotAt[1] = 29;

        rooms = new boolean[numberOfRooms];
        defineObsProperty("at0", 0);
        defineObsProperty("at1", 29);

        for (int i = 0; i < numberOfRooms; i++)
            rooms[i] = false;

        execInternalOp("run");
    }

    @INTERNAL_OPERATION
    void run() {
        while (true) {
            if (rnd.nextDouble() <= 0.7)
                rooms[rnd.nextInt(rooms.length)] = true;

            await_time(4000);
        }
    }

    @OPERATION
    void forneceInfo() {
        ObsProperty prop = getObsProperty("at");
        signal("teste");
    }

    @OPERATION
    void goLeft(int i) {
        forneceInfo();
        if (robotAt[i] - 1 > 0) {
            robotAt[i]--;

            getObsProperty("at" + String.valueOf(i)).updateValue(robotAt[i]);

            if (rooms[robotAt[i]])
                signal("dirty");
        } else
            signal("border");
    }

    @OPERATION
    void goRight(int i) {
        // System.out.println(teste);

        if (robotAt[i] + 1 < rooms.length) {
            robotAt[i]++;

            getObsProperty("at" + String.valueOf(i)).updateValue(robotAt[i]);

            if (rooms[robotAt[i]])
                signal("dirty");
        } else
            signal("border");
    }

    @OPERATION
    void clean(int i)

    {
        if (rooms[robotAt[i]])
            rooms[robotAt[i]] = false;
        else
            signal("noDirty");
    }

}
