package Ecommerce_Platform_SearchFunction;

import java.util.Arrays;
import java.util.Comparator;


class Product {
 int productId;
 String productName;
 String category;

 public Product(int productId, String productName, String category) {
     this.productId = productId;
     this.productName = productName;
     this.category = category;
 }

 public String toString() {
     return "[" + productId + "] " + productName + " (" + category + ")";
 }
}

public class ProductSearchDemo {


 public static Product linearSearch(Product[] products, String proname) {
     for (Product pro : products) {
         if (pro.productName.equalsIgnoreCase(proname)) {
             return pro;
         }
     }
     return null;
 }

 
 public static Product binarySearch(Product[] products, String proname) {
     int left = 0, right = products.length - 1;
     while (left <= right) {
         int mid = (left + right) / 2;
         int comp = products[mid].productName.compareToIgnoreCase(proname);
         if (comp == 0)
             return products[mid];
         else if (comp < 0)
             left = mid + 1;
         else
             right = mid - 1;
     }
     return null;
 }

 public static void main(String[] args) {
     Product[] products = {
         new Product(01, "Tablet", "Electronics"),
         new Product(02, "Crocs", "Fashion"),
         new Product(03, "Pen", "Education"),
         new Product(04, "Laptop", "Electronics"),
         new Product(05, "Shirt", "Fashion")
     };

 
     System.out.println("Linear Search Function:");
     Product result1 = linearSearch(products, "Tablet");
     System.out.println(result1 != null ? "Found: " + result1 : "Sorry! Product not found");

   
     Arrays.sort(products, Comparator.comparing(p -> p.productName.toLowerCase()));

 
     System.out.println("Binary Search Function:");
     Product result2 = binarySearch(products, "Tablet");
     System.out.println(result2 != null ? "Found: " + result2 : "Sorry! Product not found");

     System.out.println("Comparison of Time Complexity:");
     System.out.println("Linear Search: O(n)");
     System.out.println("Binary Search: O(log n) -->  sorting the data is required");
     System.out.println("For Large DataSets Binary Search will be more efficient.");
 }
}

