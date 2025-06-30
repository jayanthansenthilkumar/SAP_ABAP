import java.util.Scanner;
public class OxygenLevel {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int[] oxygen = new int[9];
        boolean invalid = false;
        for (int i = 0; i < 9; i++) {
            oxygen[i] = s.nextInt();
            if (oxygen[i] < 1 || oxygen[i] > 100) {
                invalid = true;
                break;
            }
        }
        if (invalid) {
            System.out.println("INVALID INPUT");
            return;
        }
        int t1 = Math.round((oxygen[0] + oxygen[3] + oxygen[6]) / 3.0f);
        int t2 = Math.round((oxygen[1] + oxygen[4] + oxygen[7]) / 3.0f);
        int t3 = Math.round((oxygen[2] + oxygen[5] + oxygen[8]) / 3.0f);
        int max = Math.max(t1, Math.max(t2, t3));
        if (max < 70) {
            System.out.println("All trainees are unfit");
        } else {
            if (t1 == max) {
                System.out.println("Trainee Number: 1");
            }
            if (t2 == max) {
                System.out.println("Trainee Number :2");
            }
            if (t3 == max) {
                System.out.println("Trainee Number :3");
                
            }
        }
    }
}
