using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.DevTools.V116.Profiler;
using OpenQA.Selenium.Interactions;

namespace Tests.Extensions;

public static partial class ChromeDriverExtensions
{
    /// <summary>
    /// Attempt a normal login
    /// </summary>
    /// <param name="driver"></param>
    /// <param name="email"></param>
    /// <param name="password"></param>
    public static void TryToLoginWithClick(this IWebDriver driver, string email, string password)
    {
        driver.FindElement(By.LinkText("Login")).Click();
        IWebElement emailInput = driver.FindElement(By.Id("email"));
        IWebElement passwordInput = driver.FindElement(By.Id("password"));
        emailInput.SendKeys(email);
        passwordInput.SendKeys(password);
        driver.FindElement(By.Id("login")).Click();
        driver.PauseXSeconds(1);
    }
}