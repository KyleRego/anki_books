namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;

[TestFixture]
public class BasicsNotesCreate : AppTests
{
    private void TryToCreateBasicNote()
    {
        driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");
        driver.PressTabUntilOnText("Read");
        driver.PressEnter();
        driver.PressTabUntilOnText("New note");
        driver.PressEnter();
        driver.TabNTimes(1);
        driver.EnterTextInActiveElement("Hello");
        driver.TabNTimes(1);
        driver.EnterTextInActiveElement("Word");
        driver.TabNTimes(1);
        driver.PressEnter();
        driver.PressTabUntilOnText("New note");
    }

    [Test]
    public void LargeScreenTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(1600, 760);
        TryToCreateBasicNote();
    }

    [Test]
    public void MediumScreenTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
        TryToCreateBasicNote();
    }

    [Test]
    public void SmallScreenTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(350, 600);
        TryToCreateBasicNote();
    }
}
