using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.DevTools.V116.Profiler;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public static partial class ChromeDriverExtensions
{
    private static IWebElement CurrentActiveElement(this IWebDriver driver)
    {
        return driver.SwitchTo().ActiveElement();
    }

    /// <summary>
    /// Pause the driver from doing anything for x seconds
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="x"></param>
    public static void PauseXSeconds(this IWebDriver driver, double x)
    {
        new Actions(driver)
            .Pause(TimeSpan.FromSeconds(x))
            .Perform();
    }

    /// <summary>
    /// Press the Enter key once
    /// </summary>
    /// <param name="driver"></param>
    public static void PressEnter(this IWebDriver driver)
    {
        new Actions(driver)
            .KeyDown(Keys.Enter)
            .KeyUp(Keys.Enter)
            .Perform();
    }

    /// <summary>
    /// Enter text in the current active element
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="text"></param>
    public static void EnterTextInActiveElement(this IWebDriver driver, string text)
    {
        IWebElement activeElement = driver.CurrentActiveElement();
        activeElement.SendKeys(text);
    }
}
