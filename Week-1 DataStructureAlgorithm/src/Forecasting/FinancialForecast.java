package Forecasting;

public class FinancialForecast {

 
    public static double Recursive(double currentValue, double GR, int yrs) {
    
        if (yrs == 0) {
            return currentValue;
        }
    
        return Recursive(currentValue, GR, yrs - 1) * (1 + GR);
    }

   
    public static double Iterative(double currentValue, double GR, int yrs) {
        double futureValue = currentValue;
        for (int i = 1; i <= yrs; i++) {
            futureValue *= (1 + GR);
        }
        return futureValue;
    }

    public static void main(String[] args) {
        double currentValue = 10000.0;     
        double GR = 0.08;    
        int yrs = 5;                

      
        double postRecursive = Recursive(currentValue, GR, yrs);
        System.out.printf("Recursive Forecast (Year %d): %.2f%n",yrs, postRecursive);

     
        double postIterative = Iterative(currentValue, GR, yrs);
        System.out.printf("Iterative Forecast (Year %d): %.2f%n", yrs, postIterative);
    }
}