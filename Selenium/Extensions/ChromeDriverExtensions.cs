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
                .Pause(TimeSpan.FromSeconds(0.25))
                .Perform();
        }
    }

    public static void ShiftTabNTimes(this IWebDriver driver, int n)
    {
        for (int i = 0; i < n; i++)
        {
            new Actions(driver)
                .KeyDown(Keys.Shift)
                .KeyDown(Keys.Tab)
                .KeyUp(Keys.Tab)
                .KeyUp(Keys.Shift)
                .Pause(TimeSpan.FromSeconds(0.25))
                .Perform();
        }
    }

    public static void PauseXSeconds(this IWebDriver driver, double x)
    {
        new Actions(driver)
            .Pause(TimeSpan.FromSeconds(x))
            .Perform();
    }

    public static void PressEnter(this IWebDriver driver)
    {
        new Actions(driver)
            .KeyDown(Keys.Enter)
            .KeyUp(Keys.Enter)
            .Perform();
    }

    public static void PressTabUntilOnLinkWithText(this IWebDriver driver, string text)
    {
        for (int i = 0; i < 10; i += 1)
        {
            driver.TabNTimes(1);
            IWebElement activeElement = driver.SwitchTo().ActiveElement();

            if (activeElement.Text == text)
            {
                return;
            }
        }
    }

    public static void PressShiftTabUntilOnLinkWithText(this IWebDriver driver, string text)
    {
        for (int i = 0; i < 10; i += 1)
        {
            driver.ShiftTabNTimes(1);
            IWebElement activeElement = driver.SwitchTo().ActiveElement();

            if (activeElement.Text == text)
            {
                return;
            }
        }
    }
}
