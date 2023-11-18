using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public static class ChromeDriverExtensions
{
    public static void TabNTimes(this IWebDriver driver, int n)
    {
        for (int i = 0; i < n; i++)
        {
            new Actions(driver)
                .KeyDown(Keys.Tab)
                .KeyUp(Keys.Tab)
                .Pause(TimeSpan.FromSeconds(0.1))
                .Perform();
        }
    }

    public static void PauseXSeconds(this IWebDriver driver, int x)
    {
        new Actions(driver)
            .Pause(TimeSpan.FromSeconds(x))
            .Perform();
    }
}
