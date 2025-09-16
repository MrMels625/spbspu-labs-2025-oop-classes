package K1;

public class Main
{
  public static void main(String[] args)
  {
    if (args.length != 1)
    {
      System.out.println("Incorrect input!");
      return;
    }
    int n = Integer.parseInt(args[0]);
    int res = trickyProcedure(n);
    System.out.println(res);
  }

  private static int secretAlgorithm(int n)
  {
    int res = 0;
    while (n > 0)
    {
      res += n % 10;
      n /= 10;
    }
    return res;
  }

  private static int trickyProcedure(int n)
  {
    while (n >= 10)
    {
      n = secretAlgorithm(n);
    }
    return n;
  }
}

