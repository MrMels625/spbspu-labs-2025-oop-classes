package K2;

class Main
{
  public static void main(String[] args)
  {
    if (args.length == 0)
    {
      System.err.println("ERROR: Not enough arguments!");
      System.exit(1);
    }

    for (int i = 0; i < args.length; ++i)
    {
      int res = parseTricky(args[i]);
      if (res == -1)
      {
        System.err.println("ERROR: String is empty!");
      }
      else if (res == -2)
      {
        System.err.println("ERROR: Invalid Roman number!");
      }
      else if (res > 0)
      {
        System.out.printf("%s = %d\n", args[i], res);
      }
    }

    System.exit(0);
  }

  private static int parseTricky(String str)
  {
    if (str == null || str.length() == 0)
    {
      return -1;
    }
    if (!isValidRoman(str))
    {
      return -2;
    }
    int res = 0;
    int prev = 0;
    for (int i = str.length() - 1; i >= 0; --i)
    {
      int curr = RomanSymbol.valueOf(String.valueOf(str.charAt(i))).getValue();
      res = curr < prev ? res - curr : res + curr;
      prev = curr;
    }
    return res;
  }

  private enum RomanSymbol
  {
    I(1),
    V(5),
    X(10),
    L(50),
    C(100),
    D(500),
    M(1000);

    private final int value;

    RomanSymbol(int value)
    {
      this.value = value;
    }

    public int getValue()
    {
      return value;
    }
  }

  private static boolean isValidRoman(String str)
  {
    return str.matches("^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$");
  }
}

