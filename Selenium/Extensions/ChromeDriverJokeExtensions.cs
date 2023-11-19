using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public static partial class ChromeDriverExtensions
{
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
