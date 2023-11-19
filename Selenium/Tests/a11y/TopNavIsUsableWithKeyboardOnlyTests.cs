namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

using Tests.Extensions;

[TestFixture]
public class TopNav : AppTests
{
  [Test]
  public void Test() {
    driver.Navigate().GoToUrl("http://localhost:3000/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");
    driver.PressTabUntilOnLinkWithText("Books");
    driver.PauseXSeconds(1);
    driver.PressShiftTabUntilOnLinkWithText("Read");
    driver.PressTabUntilOnLinkWithText("Concepts");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Books");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Books");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Books");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Read");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Read");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Read");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Read");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Read");
    driver.PressTabUntilOnLinkWithText("Downloads");
    driver.PressShiftTabUntilOnLinkWithText("Read");
  }
}
