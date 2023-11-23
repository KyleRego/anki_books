using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public static partial class ChromeDriverExtensions
{
    /// <summary>
    /// Tabs and shift tabs in a pattern over the top nav
    /// </summary>
    /// <param name="driver"></param>
    public static void DanceOnTopNav(this IWebDriver driver)
    {
        driver.PressTabUntilOnText("Logout");
        driver.PressShiftTabUntilOnText("Read");
        driver.PressTabUntilOnText("Downloads");
        driver.PressShiftTabUntilOnText("Read");
        driver.PressTabUntilOnText("Books");
        driver.PressShiftTabUntilOnText("Read");
        driver.PressTabUntilOnText("Concepts");
        driver.PressShiftTabUntilOnText("Read");
        driver.PressTabUntilOnText("Write");
        driver.PressShiftTabUntilOnText("Read");
    }
}
