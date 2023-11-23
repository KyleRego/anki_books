using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.DevTools.V116.Profiler;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public partial class ChromeDriverExtensions
{
    /// <summary>
    /// Hold Shift and then press Tab n times, and then lift Shift
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="n"></param>
    public static void ShiftTabNTimes(this IWebDriver driver, int n)
    {
        for (int i = 0; i < n; i++)
        {
            new Actions(driver)
                .KeyDown(Keys.Shift)
                .KeyDown(Keys.Tab)
                .KeyUp(Keys.Tab)
                .KeyUp(Keys.Shift)
                .Pause(TimeSpan.FromSeconds(0.04))
                .Perform();
        }
    }

    /// <summary>
    /// It will try to shift tab until the active element has the specified text
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="text"></param>
    public static void PressShiftTabUntilOnText(this IWebDriver driver, string text)
    {
        IWebElement initialActiveElement = driver.CurrentActiveElement();
        if (initialActiveElement.Text == text)
        {
            return;
        }

        for (int i = 0; i < 20; i += 1)
        {
            driver.ShiftTabNTimes(1);
            IWebElement activeElement = driver.CurrentActiveElement();

            if (activeElement.Text == text)
            {
                return;
            }
        }
        throw new Exception("could not find element with text in less than 20 shift tabs");
    }

}