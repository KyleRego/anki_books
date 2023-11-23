using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.DevTools.V116.Profiler;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public static partial class ChromeDriverExtensions
{
    /// <summary>
    /// Press Tab n times
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="n"></param>
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

    /// <summary>
    /// Tab until the current active element has the specified text
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="text"></param>
    public static void PressTabUntilOnText(this IWebDriver driver, string text)
    {
        IWebElement initialActiveElement = driver.CurrentActiveElement();
        if (initialActiveElement.Text == text)
        {
            return;
        }

        for (int i = 0; i < 20; i += 1)
        {
            driver.TabNTimes(1);
            IWebElement activeElement = driver.CurrentActiveElement();

            if (activeElement.Text == text)
            {
                return;
            }
        }
        throw new Exception("could not find element with text in less than 20 tabs");
    }

    /// <summary>
    /// Tab until the current active element is a Textarea
    /// </summary>
    /// <param name="driver"></param>
    /// <exception cref="Exception"></exception>
    public static void PressTabUntilOnTextarea(this IWebDriver driver)
    {
        for (int i = 0; i < 5; i++)
        {
            driver.TabNTimes(1);
            IWebElement activeElement = driver.CurrentActiveElement();
            string tagName = activeElement.TagName;

            if (tagName.ToLower() == "textarea")
            {
                return;
            }
        }
        throw new Exception("could not find a textarea in less than 5 tabs");
    }

    /// <summary>
    /// Tab until the current active element is an HTML input type="submit" element
    /// </summary>
    /// <param name="driver"></param>
    /// <exception cref="Exception"></exception>
    public static void PressTabUntilOnSubmitInput(this IWebDriver driver)
    {
        for (int i = 0; i < 5; i++)
        {
            driver.TabNTimes(1);
            IWebElement activeElement = driver.CurrentActiveElement();
            string tagName = activeElement.TagName.ToLower();
            string type = activeElement.GetDomProperty("type").ToLower();

            if (tagName == "input" && type == "submit")
            {
                return;
            }
        }
        throw new Exception("could not find a textarea in less than 5 tabs");
    }
}