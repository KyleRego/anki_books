namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;

[TestFixture]
public class StudyCards : AppTests
{
  [Test]
  public void Test()
  {
    driver.Navigate().GoToUrl("http://localhost:3000/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");

    driver.PressTabUntilOnText("Study cards");
    driver.PressEnter();
    driver.PressTabUntilOnText("Back to article");
    driver.PressEnter();
    driver.PauseXSeconds(5);
  }
}
