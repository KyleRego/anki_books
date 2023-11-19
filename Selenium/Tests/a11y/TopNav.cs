namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

using Tests.Extensions;
using Tests.Interfaces;

[TestFixture]
public class TopNav : AppTests
{
    [Test]
    public void Test()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
        driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");
        driver.DanceOnTopNav();
    }
}
