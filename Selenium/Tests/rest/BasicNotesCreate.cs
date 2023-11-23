namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;
using Tests.Interfaces;

[TestFixture]
public class BasicsNotesCreate : AppTests, IScreenWidthTesting
{
    private void DoTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");
        driver.PressTabUntilOnText("Read");
        driver.PressEnter();
        driver.PressTabUntilOnText("New note");
        driver.PressEnter();
        driver.PressTabUntilOnTextarea();
        driver.EnterTextInActiveElement("Hello 1");
        driver.PressTabUntilOnTextarea();
        driver.EnterTextInActiveElement("Word 1");
        driver.PressTabUntilOnSubmitInput();
        driver.PressEnter();
        driver.PauseXSeconds(5);
        driver.PressTabUntilOnText("New note");
        driver.PressEnter();
        driver.PressTabUntilOnTextarea();
        driver.EnterTextInActiveElement("Hello 2");
        driver.PressTabUntilOnTextarea();
        driver.EnterTextInActiveElement("Word 2");
        driver.PressTabUntilOnSubmitInput();
        driver.PressEnter();
    }

    [Test]
    public void LargeScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(1600, 760);
        DoTest();
    }

    [Test]
    public void MediumScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
        DoTest();
    }

    [Test]
    public void SmallScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(350, 600);
        DoTest();
    }

    [Test]
    public void VerySmallScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(200, 320);
        DoTest();
    }
}
