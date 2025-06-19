package SingletonPatternExample;

public class Logger {
    private static Logger instance;
    private Logger() {
        System.out.println("Singletone Pattern created.");
    }
    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        
        return instance;
    }
    public void statement(String input) {
        System.out.println("Log message: " + input);
    }


}
