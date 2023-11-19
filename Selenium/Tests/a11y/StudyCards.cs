namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;
using Tests.Interfaces;

[TestFixture]
public class StudyCards : AppTests, IScreenWidthTesting
{
    private void StudyCardsRandomOrder()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");

        driver.PressTabUntilOnText("Study cards");
        driver.PressEnter();
        driver.PressTabUntilOnText("Back to article");
        driver.PressEnter();
        driver.PressTabUntilOnText("Study cards");
        driver.PressEnter();
        driver.PressTabUntilOnText("Random order");
        driver.PressEnter();
    }

    [Test]
    public void LargeScreenTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(1600, 760);
        StudyCardsRandomOrder();
    }

    [Test]
    public void MediumScreenTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
        StudyCardsRandomOrder();
    }

    [Test]
    public void SmallScreenTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(350, 600);
        StudyCardsRandomOrder();
    }
}
