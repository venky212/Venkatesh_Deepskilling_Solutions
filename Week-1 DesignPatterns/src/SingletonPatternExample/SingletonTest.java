package SingletonPatternExample;


public class SingletonTest {
	public static void main(String[] args) {
        
        Logger message1= Logger.getInstance();
        message1.statement("Congratulations!!");

        Logger message2 = Logger.getInstance();
        message2.statement("Welcome to Deepskilling round.");
        
        if (message1 == message2) {
            System.out.println("Both instances are the same.");
        } else {
            System.out.println("Instances are different.");
        }
    }


}
