package K2;

class Main
{
  public static void main(String[] args)
  {
    for (int i = 0; i < args.length; ++i)
    {
      try
      {
        System.out.printf("%s = %d\n", args[i], parseTricky(args[i]));
      }
      catch (IllegalArgumentException e)
      {
        System.out.printf("ERROR: %s\n", e.getMessage());
      }
    }
  }

  private static int parseTricky(String str)
  {
    if (str != null && str.length() == 0)
    {
      throw new IllegalArgumentException("Empty string!");
    }

    if (!isValidRoman(str))
    {
      throw new IllegalArgumentException("Incorrect roman numeral format!");
    }

    int res = 0;
    int prev = 0;
    for (int i = str.length() - 1; i >= 0; --i)
    {
      int curr = decipherSymbol(str.charAt(i));
      res = curr < prev ? res - curr : res + curr;
      prev = curr;
    }
    return res;
  }

  private static int decipherSymbol(char c)
  {
    try
    {
      return RomanSymbol.valueOf(String.valueOf(c)).value();
    }
    catch (IllegalArgumentException e)
    {
      throw new IllegalArgumentException("Incorrect roman digit '" + c + '\'');
    }
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

    public int value()
    {
      return value;
    }
  }

  private static boolean isValidRoman(String str)
  {
    return str.matches("^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$");
  }
}

