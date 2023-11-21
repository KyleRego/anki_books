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

    public static void TryToLoginWithClick(this IWebDriver driver, string email, string password)
    {
        driver.FindElement(By.LinkText("Login")).Click();
        IWebElement emailInput = driver.FindElement(By.Id("email"));
        IWebElement passwordInput = driver.FindElement(By.Id("password"));
        emailInput.SendKeys(email);
        passwordInput.SendKeys(password);
        driver.FindElement(By.Id("login")).Click();
    }

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
                .Pause(TimeSpan.FromSeconds(0.04))
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

    /// <summary>
    /// It will try to tab through source order until the active element has the specified text
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="text"></param>
    public static void PressTabUntilOnText(this IWebDriver driver, string text)
    {
        try
        {
            Inner(driver, text);
        }
        catch
        {
            Inner(driver, text);
        }

        static void Inner(IWebDriver driver, string text)
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

            for (int i = 0; i < 40; i += 1)
            {
                driver.ShiftTabNTimes(1);
                IWebElement activeElement = driver.CurrentActiveElement();

                if (activeElement.Text == text)
                {
                    return;
                }
            }
        }
    }

    /// <summary>
    /// It will try to tab through reverse source order until the active element has the specified text
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
    }

    public static void EnterTextInActiveElement(this IWebDriver driver, string text)
    {
        IWebElement activeElement = driver.CurrentActiveElement();
        activeElement.SendKeys(text);
    }
}
